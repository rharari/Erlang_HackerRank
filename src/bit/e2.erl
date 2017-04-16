%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Aug 2016 1:27 AM
%%%-------------------------------------------------------------------
-module(e2).
-author("rharari").
-export([main/0]).

solve(0) ->
  0;
solve(N) ->
  {ok, [Number]} = io:fread("", "~d"),
  Number bxor solve(N - 1).

main() ->
  {ok, [N]} = io:fread("", "~d"),
  io:format("~B~n", [solve(N)]).
