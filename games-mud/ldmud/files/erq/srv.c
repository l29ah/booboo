/* SRV implementation by the PSYC developers at psyced.org
 *
 * REMINDER: when modifying anything about these files, remember
 * that not only the psyced installer needs to be updated, you
 * also have to manually update the gentoo tar.
 */

#include "srv.h"


#include <unistd.h>
#include <stdlib.h>
#include <strings.h>
#include <arpa/inet.h>  // For solaris
#include <arpa/nameser.h>
#include <resolv.h>

#if !defined(__FreeBSD__) && !defined(__NetBSD__) && !defined(__OpenBSD__)
# include <malloc.h>
#else
# include <stdlib.h>
#endif

/* the biggest packet we'll send and receive */
#if PACKETSZ > 1024
#define	MAXPACKET PACKETSZ
#else
#define	MAXPACKET 1024
#endif

/* and what we send and receive */
typedef union {
	HEADER hdr;
	u_char buf[MAXPACKET];
} querybuf;

#ifndef T_SRV
#define T_SRV		33
#endif


void freesrvhost ( struct srvhost * s )
{
    struct srvhost * n;
    while( s ) {
	n = s->next;
	/* hack to make double-free visible by causing null dereference */
	s->next = NULL;
	free( (void *)s );
	s = n;
    }
}


static int compare( const void * a, const void * b )
{
    struct srvhost * aa, * bb;

    if ( !a )
	return 1;
    if ( !b )
	return -1;

    aa  = (struct srvhost *) *(int*)a;
    bb = (struct srvhost *) *(int*)b;

    if ( aa->pref > bb->pref )
	return 1;
    if ( aa->pref < bb->pref )
	return -1;

    if ( aa->rweight > bb->rweight )
	return -1;
    if ( aa->rweight < bb->rweight )
	return 1;
    
    return 0;
}


struct srvhost * getsrv( const char * domain,
			 const char * service, const char * protocol ) {
    querybuf answer;		/* answer buffer from nameserver */
    int n;
    char * zone;
    int ancount, qdcount;		/* answer count and query count */
    HEADER *hp;			/* answer buffer header */
    struct srvhost **replyarray;
    struct srvhost * firsthost;
    int answerno;
    u_char hostbuf[256];
    u_char *msg, *eom, *cp;	/* answer buffer positions */
    int dlen, type, pref, weight, port;

    if ( !domain || !*domain ||
	 !service || !*service ||
	 !protocol || !*protocol )
	return NULL;

    zone = (char *)malloc( strlen( domain ) + 
			   strlen( service ) +
			   strlen( protocol ) + 20 );
    if (zone == NULL)
        return NULL;

    *zone = '\0';

    if (*service != '_')    // If service and protocol do not start with a
        strcat(zone, "_");  // _, prepend the _ to them...

    strcat(zone, service);
    strcat(zone, ".");

    if (*protocol != '_')
        strcat(zone, "_");

    strcat(zone, protocol);
    strcat(zone, ".");

    strcat(zone, domain);
        
    n = res_query( zone, C_IN, T_SRV, (u_char *)&answer, sizeof( answer ) );

    (void) free( zone );
    zone = NULL;

    if ( n < (int)sizeof(HEADER) )
	return NULL;

    /* valid answer received. skip the query record. */

    hp = (HEADER *)&answer;
    qdcount = ntohs(hp->qdcount);
    ancount = ntohs(hp->ancount);

    msg = (u_char *)&answer;
    eom = (u_char *)&answer + n;
    cp  = (u_char *)&answer + sizeof(HEADER);

    while ( qdcount-- > 0 && cp < eom ) {
	n = dn_expand( msg, eom, cp, (char *)hostbuf, 256 );
	if (n < 0)
	    return NULL;
	cp += n + QFIXEDSZ;
    }

    /* make a big-enough (probably too big) reply array */

    replyarray 
	= (struct srvhost **) malloc( ancount * sizeof(struct srvhost *) );
    for( n = 0; n < ancount; n++ )
	replyarray[n] = NULL;
    answerno = 0;

    /* loop through the answer buffer and extract SRV records */
    while ( ancount-- > 0 && cp < eom ) {
	n = dn_expand( msg, eom, cp, (char *)hostbuf, 256 );
	if ( n < 0 ) {
	    for( n = 0; n < answerno; n++ )
		(void) free( replyarray[n] );
	    (void)free( replyarray );
	    return NULL;
	}

	cp += n;

	type = _getshort(cp);
	cp += sizeof(u_short);

	/* class = _getshort(cp); */
	cp += sizeof(u_short);

	/* ttl = _getlong(cp); */
	cp += sizeof(u_long);

	dlen = _getshort(cp);
	cp += sizeof(u_short);

	if ( type != T_SRV ) {
	    cp += dlen;
	    continue;
	}

	pref = _getshort(cp);
	cp += sizeof(u_short);

	weight = _getshort(cp);
	cp += sizeof(u_short);

	port = _getshort(cp);
	cp += sizeof(u_short);

	n = dn_expand( msg, eom, cp, (char *)hostbuf, 256 );
	if (n < 0)
	    break;
	cp += n;

	replyarray[answerno] 
	    = (struct srvhost *)malloc( sizeof( struct srvhost ) +
					strlen( (char *)hostbuf ) );
	replyarray[answerno]->pref = pref;
	replyarray[answerno]->weight = weight;
	if ( weight )
	    replyarray[answerno]->rweight = 1+random()%( 10000 * weight );
	else
	    replyarray[answerno]->rweight = 0;
	replyarray[answerno]->port = port;
	replyarray[answerno]->next = NULL;
	strcpy( replyarray[answerno]->name, (char *)hostbuf );

	answerno++;
    }
    if (answerno == 0) return NULL;
    qsort( replyarray, answerno, sizeof( struct srvhost * ),
	   compare );

    // Recreate a linked list from the sorted array...
    for( n = 0; n < answerno; n++ )
	replyarray[n]->next = replyarray[n+1];
    replyarray[answerno-1]->next = NULL;

    firsthost = replyarray[0];
    (void) free( replyarray );
    return firsthost;
}

