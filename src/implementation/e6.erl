%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/jumping-on-the-clouds-revisited
%%% Hackerrank - Jumping on the Clouds: Revisited
%%% @end
%%%-------------------------------------------------------------------
-module(e6).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> {ok, [N, K]} = io:fread("", "~d ~d"),
          io:format("~p", [move(100, N, K, 1 + K, getNum(N, []))]).

move(E, N, K, _, L) when N =:= K -> E - getEnergy(1, L);
move(E, _, _, 1, L) -> E - getEnergy(1, L);
move(E, N, K, P, L) -> move(E-getEnergy(P,L), N, K, getPos(P + K, N), L).

getEnergy(P, L) ->
  case lists:nth(P, L) == 1 of
    true -> 3;
    false -> 1
  end.

getPos(P, N) when P > N -> P - N;
getPos(P, _) -> P.

getNum(0, T) -> lists:reverse(T);
getNum(N, T) -> {ok, [X]} = io:fread("", "~d"), getNum(N-1, [X|T]).