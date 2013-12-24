----------------------------------------------------------------------
CoinProxy
----------------------------------------------------------------------
yaws-based (use this one)

    The Yaws-based version can unpack and repack the RPC initiated by
    the client and functions as a proxy. Filtering and validating
    functionalities can be added in the future.

    Detailed instructions for using yaws-based coinproxy can be found
    in yaws-based/ReadMe.txt

bitcoind-based

    This is the simplest way to set up a proxy, but it doesn't
    validate the commands sent to bitcoind.

socat-based

    socat-based version is a working solution, instructions for using
    socat are under the "socat-based" directory. This method doesn't
    validate the commands sent to bitcoind either.
----------------------------------------------------------------------
