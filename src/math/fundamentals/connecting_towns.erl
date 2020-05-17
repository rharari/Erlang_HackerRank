%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%% https://www.hackerrank.com/challenges/connecting-towns/problem
%%% @end
%%% Created : Oct 2019 01:28
%%%-------------------------------------------------------------------
-module(connecting_towns).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [T]} = io:fread("", "~d"), execute(T).

execute(0) -> ok;
execute(T) -> {ok, [N]} = io:fread("", "~d"),
              calculate(N, string:tokens(string:chomp(io:get_line("")), " ")),
              execute(T - 1).

calculate(1, _) -> io:format("0~n");
calculate(_, Lst) -> io:format("~w~n", [lists:foldl(fun (X, P) -> X * P end, 1, lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, Lst)) rem 1234567]).
