%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% Project Euler #4: Largest palindrome product
%%%
%%% @end
%%% https://www.hackerrank.com/contests/projecteuler/challenges/euler004
%%%-------------------------------------------------------------------
-module(e4).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [T]} = io:fread("", "~d"), go(T).


%% API
-export([]).
