%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 2:11 AM
%%%-------------------------------------------------------------------
-module(solution2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, A} = io:fread("", "~d~d~d"),
  { ok, B} = io:fread("", "~d~d~d"),
  io:format("~p ~p~n", count(A, B, 0, 0)).

count([], [], Ca, Cb) -> [Ca, Cb];
count([Ah|At], [Bh|Bt], Ca, Cb) when Ah > Bh -> count(At, Bt, Ca + 1, Cb);
count([Ah|At], [Bh|Bt], Ca, Cb) when Ah < Bh -> count(At, Bt, Ca, Cb + 1);
count([Ah|At], [Bh|Bt], Ca, Cb) -> count(At, Bt, Ca, Cb ).




