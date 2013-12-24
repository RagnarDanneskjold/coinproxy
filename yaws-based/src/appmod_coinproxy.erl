-module(appmod_coinproxy).

-import(yaws_api, [f/2]).

-compile(export_all).

-include_lib("yaws.hrl").
-include_lib("yaws_api.hrl").

%% -include("coinproxy.hrl").
-include("coinproxy_dev.hrl").

out(Arg) ->
    Peer = case yaws_api:get_sslsocket(Arg#arg.clisock) of
               {ok, SslSocket} ->
                   ssl:peername(SslSocket);
               _ ->
                   inet:peername(Arg#arg.clisock)
           end,

    {ok, {IP, _}} = Peer,
    A2 = Arg#arg{state = [{ip, IP}]},
    yaws_rpc:handler_session(A2, {?MODULE, bitcoin_rpc_handler}).

bitcoin_rpc_handler([{ip, IP}] = _State, {call, RPCMethod, Value} = _RPCRequest, _Session) ->
    {127,0,0,1} = IP,
    io:format("Client IP: ~p~n", [IP]),
    io:format("RPC Method: ~p~n", [RPCMethod]),
    {array, Args} = Value,
    io:format("RPC Arguments: ~p~n", [Args]),

    Method      = post,
    URL         = lists:append(["http://", ?RPC_USERNAME, ":", ?RPC_PASSWORD, "@", ?BITCOIND_HOST, ":", ?RPC_PORT, "/"]),
    ContentType = "text/json",
    %% RequestBody = "{\"jsonrpc\": \"2.0\", \"id\":\"1\", \"method\": \"" ++ atom_to_list(RPCMethod) ++ "\", \"params\": []}",
    RequestBody = ejson:encode({[{<<"method">>, atom_to_binary(RPCMethod, utf8)},
				 {<<"params">>, lists:map(fun(X) -> case is_list(X) of true -> list_to_binary(X); false -> X  end end, Args)}]}),
    Request     = {URL, [], ContentType, RequestBody},

    {ok, Result} = httpc:request(Method, Request, [], []),
    {_Status, _Headers, Body} = Result,

    {ok, {struct, [{"result", Response}, {"error", Error} | _]}} = json2:decode_string(Body),
    io:format("Response: ~p~n", [Response]),
    io:format("Response body: ~p~n", [Body]),
    %% io:format("Response from remote bitcoind host: ~p~n", [Response]),

    case Response of
	null ->
	    {true, 0, _Session, {response, Error}};
	_ ->
	    {true, 0, _Session, {response, Response}}
    end.
