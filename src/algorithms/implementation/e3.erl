%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% The grid search
%%% @end
%%% https://www.hackerrank.com/challenges/the-grid-search
%%%-------------------------------------------------------------------
-module(e3).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [T]} = io:fread("", "~d"), start(T).

start(0) -> true;
start(T) -> { ok, [R, C]} = io:fread("", "~d~d"),
            go(readMatrix(R, ""), C),
            start(T - 1).

go(S, C0) -> { ok, [R, C]} = io:fread("", "~d~d"),
                RE = readRE(R, string:copies(".", C0 - C), ""),
                case re:run(S, RE) of
                  nomatch -> io:format("NO~n");
                  _ -> io:format("YES~n")
                end,
                true.

readRE(1, _, Acc) -> { ok, [S]} = io:fread("", "~s"), Acc ++ S;
readRE(R, S0, Acc) -> { ok, [S]} = io:fread("", "~s"),
                      readRE(R - 1, S0, Acc ++ S ++ S0).

readMatrix(0, Acc) -> Acc;
readMatrix(R, Acc) -> { ok, [S]} = io:fread("", "~s"),
                      readMatrix(R - 1, Acc ++ S).