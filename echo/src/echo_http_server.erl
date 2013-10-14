%%%-------------------------------------------------------------------
%%% @author gavin
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Oct 2013 3:06 PM
%%%-------------------------------------------------------------------
-module(echo_http_server).
-author("gavin").

-behaviour(gen_server).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0]).


%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
  terminate/2, code_change/3]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
  NumAcceptors = 16,
  Port = 8080,
  Ip = "127.0.0.1",

  Dispatch = cowboy_router:compile([
    {'_', [
      {"/reactiveprogramming/sendecho/", handler_echo, []}
    ]}
  ]),
  {ok, _} = cowboy:start_http(http, 1, [{port, 8080}], [
    {env, [{dispatch, Dispatch}]}
  ]).


handle_call(_Request, _From, State) ->
  {reply, ok, State}.


handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.