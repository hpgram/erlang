%%%-------------------------------------------------------------------
%%% @author gavin
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Oct 2013 3:19 PM
%%%-------------------------------------------------------------------
-module(echo_http_handler).
-author("gavin").

-behaviour(cowboy_http_handler).

%% API
-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

terminate(_Reason, _Req, _State) ->
  ok.

handle(Req, State) ->
  {Method, Req1} = cowboy_req:method(Req),
  process(Method, Req1).

process(<<"POST">>, Req) ->
  {ok, Data, Req1}  = cowboy_req:body(Req),
  jsonBody = binary_to_list(Data),
  {struct, [{"target", Target}, {"message", Message}]} = mochijson:decode(jsonBody),
  Msg = string:concat(Target,"says "),
  Msg1 = string:concat(Msg, Message),

  Res = {struct, [{"status", "ack"},{"message", Msg1}]},
  Res1 = mochijson:encode(Res),
  cowboy_req:reply(200, [], Res1).
