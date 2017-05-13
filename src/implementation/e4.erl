%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/the-hurdle-race
%%% Hackerrank - The hurdle race
%%% @end
%%%-------------------------------------------------------------------
-module(e4).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> {ok, [N,K]} = io:fread("", "~d~d"),
          io:format("~p ", [max(getMax(0, N) - K, 0)]).

getMax(I, 0) -> I;
getMax(I, N) -> {ok, [G]} = io:fread("", "~d"), getMax(max(I, G), N-1).
