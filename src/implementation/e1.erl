%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017
%%% @doc
%%% see: https://www.hackerrank.com/challenges/grading
%%% @end
%%%
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"), go(N).

go(0) -> {ok};
go(N) -> {ok, [G]} = io:fread("", "~d"),
         grade(G, G rem 5), go(N-1).

grade(N, Nrem) when N < 38 orelse Nrem < 3 -> io:format("~p~n", [N]);
grade(N, Nrem) -> io:format("~p~n", [N + 5 - Nrem]).