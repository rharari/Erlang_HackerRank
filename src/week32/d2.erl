%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. May 2017 14:08
%%%-------------------------------------------------------------------
-module(d2).
-author("rharari").

%% API
-export([main/0]).

main() ->
  % n s t
  % p
  % r g seed < p
  R0 = 0,
  G = 2,
  Seed = 4,
  P = 70,
  % (R0 x G + Seed) mod P
  R1 = (R0 * G + Seed) rem P,
  calc(R0, R1, G, Seed, P, [R1]).

calc(R1st, R0, G, Seed, P, Acc) when R1st == R0 -> Acc;
calc(R1st, R0, G, Seed, P, Acc) ->
  R1 = (R0 * G + Seed) rem P,
  calc(R1st, R1, G, Seed, P, Acc ++ [R1]).
