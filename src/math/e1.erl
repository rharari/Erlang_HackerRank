%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%%
%%% @end
%%% https://www.hackerrank.com/challenges/maximum-draws
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [T]} = io:fread("", "~d"), go(T).

go(0) -> {ok};
go(T) -> { ok, [N]} = io:fread("", "~d"),
         io:format("~p~n", [N + 1]), go(T-1).

