%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%%   https://www.hackerrank.com/challenges/sherlock-and-permutations/problem
%%% @end
%%%-------------------------------------------------------------------

%%% c("sherlock_permutation.erl").

-module(sherlock_permutation).
-author("rharari").
-export([main/0]).

main() -> {ok, [T]} = io:fread("", "~d"), read(T).

read(0) -> ok;
read(T) -> {ok, [N, M]} = io:fread("", "~d~d"),
           permutation(N, M - 1),
           read(T - 1).

permutation(N, M) ->
  io:format("~p~n", [factorial(N + M) div (factorial(N) * factorial(M)) rem 1000000007]).

factorial(N) -> factorial_calc(N, 1).
factorial_calc(0, Acc) -> Acc;
factorial_calc(N, Acc) -> factorial_calc(N - 1, Acc * N).
