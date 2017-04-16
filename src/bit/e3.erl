%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Aug 2016 1:33 AM
%%%-------------------------------------------------------------------
-module(e3).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [L,R]} = io:fread("", "~d~d"),
  io:fwrite("~p", [getMax({L,R},{L,L},-1)]).

getMax({_,R}, {L1,_}, M) when L1 > R -> M;
getMax({L,R}, {L1,R1}, M) when R1 > R -> getMax({L1+1,R}, {L1 + 1, L1 + 1}, M);
getMax({L,R}, {L1,R1}, M) -> K = L1 bxor R1,
  getMax({L,R}, {L1, R1 + 1}, case K > M of true -> K; false -> M end).

getBit(<<0:16>>, _) -> 0;
getBit(<<B:1, Rest/bitstring>>, N) when B == 1 -> N;
getBit(<<B:1, Rest/bitstring>>, N) -> getBit(Rest, N-1).

