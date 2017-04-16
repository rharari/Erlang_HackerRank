%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 3:15 AM
%%%-------------------------------------------------------------------
-module(sol5).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N, K, Q]} = io:fread("", "~d~d~d"),
  Table = ets:new('solution', [{read_concurrency, true}]),
  {ok} = read_array(N, 1, Table),
  {ok} = printElem(N, Q, Table, K rem N).

printElem(_, 0, _, _) -> {ok};
printElem(Size, Q, Table, Shift) ->
  {ok, [X]} = io:fread("", "~d"),
  V = ets:lookup_element(Table, getPos(X - Shift + Size, Size, 2)),
  io:format("~p~n", [V]),
  printElem(Size, Q-1, Table, Shift).

read_array(0, _, _) -> {ok};
read_array(N, Pos, Table) ->
  {ok, [X]} = io:fread("", "~d"),
  ets:insert(Table, {Pos, X}),
  read_array(N - 1, Pos + 1, Table).

getPos(Pos, N) when Pos >= N -> Pos - N + 1;
getPos(Pos, _) -> Pos + 1.
