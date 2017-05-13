%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% Extra Long Factorials
%%% @end
%%% https://www.hackerrank.com/challenges/extra-long-factorials
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"),
          io:format("~p~n", [factorial(N, 1)]).

factorial(0, Acc) -> Acc;
factorial(N, Acc) -> factorial(N-1, Acc * N).