%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% computing GCD
%%% @end
%%% https://www.hackerrank.com/challenges/functional-programming-warmups-in-recursion---gcd
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [A,B]} = io:fread("", "~d~d"),
  io:fwrite("~p", [gcd(A, B)]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
