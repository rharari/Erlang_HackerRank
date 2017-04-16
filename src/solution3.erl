%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 2:32 AM
%%%-------------------------------------------------------------------
-module(solution3).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N] } = io:fread("", "~d"),
  io:format("~p~n", [read_array(N, 0)]).

read_array(0, S) -> S;
read_array(N, S) ->
  {ok, [X]} = io:fread("", "~d"),
  read_array(N-1, S + X).
