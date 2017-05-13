%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(test).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  L2 = lists:seq(1,90000),
  Lst = ets:new(matrix, [set]),
  L = merge_list(0, L2, Lst),
  lookup(89000, Lst),
  ets:lookup(Lst, 80000).
  %%% ets:insert(Lst, L).

lookup(0, _) -> {ok};
lookup(N, Lst) ->
  A = ets:lookup(Lst, N),
  lookup(N - 1, Lst).

merge_list(_, [], _) -> {ok};
merge_list(N, [H|T], Lst) ->
  ets:insert(Lst, {N, H}),
  merge_list(N + 1, T, Lst).

go(0, L) -> L;
go(N, L) ->
  {L1, L2} = lists:split(10,L),
  go(N - 1, lists:merge(L1,L2)).