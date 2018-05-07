%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% hacker rank - Triple Recursion
%%% @end
%%% https://www.hackerrank.com/contests/w35/challenges/triple-recursion
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").

-export([main/0]).

main() -> { ok, [N,M,K]} = io:fread("", "~d~d~d"),
  genRow(2, 1, N, K, createArray(N - 1, K, M, [M]), [], M).

genRow(L, _, N, _, [], _, _) when L == N -> {ok};
genRow(L, _, N, K, [], L2, _) ->  io:format("~n"), genRow(L + 1, 1, N, K, L2, [], lists:nth(L, L2));
genRow(L, C, N, K, [H|T], L2, V0) when L > C ->  print(H - 1), space(), genRow(L, C + 1, N, K, T, lists:append(L2, [H - 1]), V0);
genRow(L, C, N, K, [_|T], L2, V0) when L == C ->  print(V0 + K), genRow(L, C + 1, N, K, T, lists:append(L2, [V0 + K]), V0 + K);
genRow(L, C, N, K, [_|T], L2, V0) when L < C ->  space(), print(V0 - 1), genRow(L, C + 1, N, K, T, lists:append(L2, [V0 - 1]), V0 - 1).

createArray(0, _, V, A) -> print(V), io:format("~n"), A;
createArray(N, K, V, A) -> print(V), space(), createArray(N - 1, K, V - 1, lists:append(A, [V - 1])).

print(N) -> io:format("~p", [N]).
space() -> io:format(" ").