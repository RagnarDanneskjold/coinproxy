----------------------------------------------------------------------
How to use it?

    Dependencies:

        bitcoind // http://www.bitcoin.org/en/download

    Preparation:

        We have two hosts (machines): NodeFront and NodeBitcoind

	On NodeBitcoind, a full Bitcoin node is installed and
	syncronized, and a "bitcoin.conf" file with the following
	content needs to be created:

	    rpcuser=<a user name>
	    rpcpassword=<a password>

	On NodeFront, only "bitcoind" needs to be downloaded and put
	into the "bin" directory since we use "bitcoind" only as a
	client on this host. In addition, a "bitcoin.conf" file with
	the following content also needs to be created:

	    rpcuser=<the same user name as the above>
	    rpcpassword=<the same password as the above>
	    rpcconnect=<IP of NodeBitcoind>

	Done.

    Enjoy:

        Now we can use "bitcoind" (as a client) from within NodeFront
        to interact with the "bitcoind" full node (as a server) on the
        remote NodeBitcoind.

	Example:

	    // On NodeFront
	    $ bitcoind getinfo
----------------------------------------------------------------------
References

    Sample "bitcoin.conf"
        https://en.bitcoin.it/wiki/Running_Bitcoin#Sample_Bitcoin.conf
----------------------------------------------------------------------
