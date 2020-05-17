%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%%   https://www.hackerrank.com/challenges/sherlock-and-permutations/problem
%%% @end
%%%-------------------------------------------------------------------

-module(lowest_triangle).
-author("rharari").
-export([main/0]).

main() -> {ok, [B, A]} = io:fread("", "~d~d"),
          io:format("~p~n", [trunc(math:ceil(2 * A / B))] ).