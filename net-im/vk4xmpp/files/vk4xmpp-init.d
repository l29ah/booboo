#!/sbin/openrc-run
DESC="VK Jabber Transport"
APPDIR="/usr/lib64/python2.7/site-packages/vk4xmpp"
PIDDIR="/run/vk4xmpp/"
PIDFILE="$PIDDIR/vk4xmpp.pid"
LOGFILE="/var/log/vk4xmpp"

depend() {
        need net
        use jabber-server
}

start() {
	ebegin "Starting VK Jabber Transport"
	start-stop-daemon --user vk4xmpp:nobody --exec python2 -- "$APPDIR/gateway.py" -c /etc/vk4xmpp
	eend $?
}

stop() {
        ebegin "Stopping VK Jabber Transport"
        start-stop-daemon --stop --quiet --pidfile "$PIDFILE"
        eend $?
}
