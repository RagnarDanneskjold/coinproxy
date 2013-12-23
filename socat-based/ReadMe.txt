----------------------------------------------------------------------
How to use it?

    Dependencies:

        bitcoind // http://www.bitcoin.org/en/download
	screen // sudo apt-get install screen
	socat // sudo apt-get install socat

    Preparation:

        We have two hosts (machines): NodeFront and NodeBitcoind

	On NodeBitcoind, a full Bitcoin node is installed and
	syncronized, and a "bitcoin.conf" file with the following
	content needs to be created:

	    rpcuser=<a user name>
	    rpcpassword=<a password>
	    rpcallowip=<IP of NodeFront>

	On NodeFront, only "bitcoind" needs to be downloaded and put
	into the "bin" directory since we use "bitcoind" only as a
	client on this host. In addition, a "bitcoin.conf" file with
	the following content also needs to be created:

	    rpcuser=<the same user name as the above>
	    rpcpassword=<the same password as the above>

	Done.

    Setting up the proxy:

        On NodeFront, start a "screen" session:

	    $ screen

	Within the screen session, execute:

	    $ socat tcp-listen:8332,reuseaddr,fork tcp:<IP of NodeBitcoind>:8332

	Type "ctrl-a d" to detach from the screen session.

	Done.

    Enjoy:

        Now we can use "bitcoind" (as a client) from within NodeFront
        to interact with the "bitcoind" full node (as a server) on the
        remote NodeBitcoind.

	Example:

	    // On NodeFront
	    $ bitcoind getinfo
----------------------------------------------------------------------
