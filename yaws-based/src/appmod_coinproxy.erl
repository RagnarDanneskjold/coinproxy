-module(appmod_coinproxy).

-import(yaws_api, [f/2]).

-compile(export_all).

-include_lib("yaws.hrl").
-include_lib("yaws_api.hrl").

-include("coinproxy.hrl").

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

bitcoin_rpc_handler([{ip, IP}] = _State, {call, Method, _Value} = _Request, _Session) ->
    io:format("Request = ~p, IP = ~p~n", [_Request, IP]),

    %% lab
    {ok, {{_, 200, _}, _, ResultStream}} = httpc:request(post, {"http://" ++ ?Username ++ ":" ++ ?Password ++ "@" ++ ?BitcoindHost ++ ":8332/", [], "text/json", "{\"jsonrpc\": \"2.0\", \"id\":\"1\", \"method\": \"" ++ atom_to_list(Method) ++ "\", \"params\": []}"}, [], []),

    {ok, {struct, [{"result", Response} | _]}} = json2:decode_string(ResultStream),
    io:format("~p~n", [Response]),
    
    {true, 0, _Session, {response, Response}}.

%% bitcoin_rpc_handler([{ip, IP}] = _State, {call, test, _Value} = _Request, _Session) ->
%%     io:format("Request = ~p, IP = ~p~n", [_Request, IP]),
%%     %% error: {"code":-32601,"message":"Method not found"}
%%     Response = {struct, [{"code", -32601}, {"message", "Method not found"}]},
%%     {false, {error, Response}}.
