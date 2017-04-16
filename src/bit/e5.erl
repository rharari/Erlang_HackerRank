%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Aug 2016 11:13 PM
%%%-------------------------------------------------------------------
-module(e5).
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  start(N).

start(0) -> {ok};
start(N) -> { ok, [L,R]} = io:fread("", "~d~d"),
  A = getA(L - 1),
  io:fwrite("~p~n", [go(L-1,A,A,L-1,R-1)]),
  start(N-1).

getA(N) when N rem 4 == 3 -> 0;
getA(N) when N rem 4 == 1 -> 1;
getA(N) when N rem 4 == 2 -> N + 1;
getA(N) when N rem 4 == 0 -> N.

go(I, V1, V2, _, E) when I == E ->
  io:fwrite("I [~p]   V1=~p   V2=~p   FINISH ~n", [I, V1, V2]),
  In = I + 1,
  V1n = V1 bxor In,
  V2 bxor V1n;
go(I, V1, V2, S, E) when I == S ->
  io:fwrite("I [~p]   V1=~p   V2=~p    START ~n", [I, V1, V2]),
   In = I + 1,
   V1n = V1 bxor In,
   go(In, V1n, V1n, S, E);
go(I, V1, V2, S, E) ->
  io:fwrite("I [~p]   V1=~p   V2=~p ~n", [I, V1, V2]),
  In = I + 1,
  V1n = V1 bxor In,
  go(I + 1, V1n, V2 bxor V1n, S, E).
