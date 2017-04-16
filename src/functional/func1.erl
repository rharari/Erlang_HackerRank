%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% Evaluating e^x
%%% @end
%%% Created : 30. Jul 2016 7:14 PM
%%%-------------------------------------------------------------------
-module(func1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  F = getFactorial([1], 2),
  { ok, [N]} = io:fread("", "~d"),
  read(N, F).

read(0,_) -> {ok};
read(N, F) ->
  { ok, [M]} = io:fread("", "~f"),
  io:format("~p~n", [ calc(1, 1, 1, M, F)]),
  read(N-1, F).

calc(10,V,_,_,_) -> V;
calc(Q, V, X, N,F) -> calc(Q+1, V + X*N/lists:nth(Q, F), X*N, N, F).

getFactorial(Arr, 10) -> Arr;
getFactorial(Arr, N) -> getFactorial(Arr ++ [N * lists:nth(N-1, Arr)], N+1).
