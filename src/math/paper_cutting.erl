%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%%   https://www.hackerrank.com/challenges/sherlock-and-permutations/problem
%%% @end
%%%-------------------------------------------------------------------

-module(paper_cutting).
-author("rharari").
-export([main/0]).

main() -> {ok, [N, M]} = io:fread("", "~d~d"),
          io:format("~p~n", [N * M - 1] ).