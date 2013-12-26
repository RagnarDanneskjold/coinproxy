----------------------------------------------------------------------
Yaws-based CoinProxy
----------------------------------------------------------------------
Dependencies:

    Erlang (http://www.erlang.org/)
    Yaws (http://hyber.org/)
----------------------------------------------------------------------
Usage:

    1) Install dependencies (scripts for installing Erlang and Yaws
    for Ubuntu are provided under tool/ directory)

    2) Set up a bitcoin.conf file in the remote bitcoind node

    3) $ git clone https://github.com/peatio/coinproxy.git
       $ cd coinproxy/yaws-based/

    4) Edit include/coinproxy.hrl accordingly

    5) Enable the APIs we want through "api_controller.conf"
    
    6) Start the proxy (better do this within a screen session)
       $ yaws --conf ./yaws.conf

    7) Now we can talk with the remote bitcoind node via the local
    Yaws-based coinproxy

----------------------------------------------------------------------
