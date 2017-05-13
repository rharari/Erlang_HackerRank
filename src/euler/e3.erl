%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% Project Euler #3: Largest prime factor
%%%
%%% @end
%%% https://www.hackerrank.com/contests/projecteuler/challenges/euler003
%%%-------------------------------------------------------------------
-module(e3).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [T]} = io:fread("", "~d"), go(T).

go(0) -> true;
go(T) -> { ok, [N]} = io:fread("", "~d"),
         io:format("~p~n", [maxFactor(N, 1, 2)]),
         go(T-1).

maxFactor(0, Max, _) -> Max;
maxFactor(N, Max, D) when N rem D == 0 -> maxFactor(trunc(N / D), max(Max, D), D);
maxFactor(N, Max, D) ->
  D2 = D + 1,
  case D2 * D2 > N of
    true -> max(Max, N);
    false -> maxFactor(N, Max, D2)
  end.
