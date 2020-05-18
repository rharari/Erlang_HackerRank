%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% https://www.hackerrank.com/challenges/sherlock-and-cost/problem
%%% @end

%%% c("sherlock_cost.erl").
%%% sherlock_cost:main().
%%%-------------------------------------------------------------------
-module(sherlock_cost).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"),
          run(N).
run(0) -> ok;
run(I) -> io:fread("", "~d"),
          [N|Arr] = lists:map(fun(X) -> {J, _} = string:to_integer(X), J end, re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim])),
          io:format("~p~n", [calc(N, Arr, {0, 0})]),
          run(I - 1).

calc(_, [], {A, B}) -> max(A, B);
calc(N, [H|T], {A, B}) -> calc(H, T, {max(A, B + N - 1), max(B + abs(N - H), A + H - 1)}).
