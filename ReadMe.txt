----------------------------------------------------------------------
CoinProxy
----------------------------------------------------------------------
sinatra-based

    The Sinatra-based (Ruby) version can unpack and repack the RPC
    initiated by the client and functions as a proxy. Enabling and
    disabling certain APIs are supported.

    Detailed instructions for using sinatra-based coinproxy can be
    found in sinatra-based/ReadMe.txt

yaws-based (deprecated)

    The Yaws-based (Erlang) version can unpack and repack the RPC
    initiated by the client and functions as a proxy. Enabling and
    disabling certain APIs are supported.

    Detailed instructions for using yaws-based coinproxy can be found
    in yaws-based/ReadMe.txt

bitcoind-based (deprecated)

    This is the simplest way to set up a proxy, but it doesn't
    validate the commands sent to bitcoind.

socat-based (deprecated)

    socat-based version is a working solution, instructions for using
    socat are under the "socat-based" directory. This method doesn't
    validate the commands sent to bitcoind either.
----------------------------------------------------------------------
