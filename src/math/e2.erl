%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017
%%% @doc
%%%
%%% @end
%%% https://www.hackerrank.com/challenges/handshake
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> {ok, [T]} = io:fread("", "~d"), go(T).

go(0) -> {ok};
go(T) -> {ok, [N]} = io:fread("", "~d"),
  io:format("~p~n", [N * (N - 1) div 2]), go(T - 1).