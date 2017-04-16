%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 1:46 AM
%%%-------------------------------------------------------------------
-module(solution).
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  Arr = read_array(N),
  T = sum(Arr, 0),
  io:format("~p~n", [T]).

read_array(0) -> [];
read_array(N) ->
  {ok, [X]} = io:fread("", "~d"),
  [X | read_array(N-1)].

sum([H|T], S) -> sum(T, S + H);
sum([], S) -> S.
