%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% string o-permute
%%% @end
%%% https://www.hackerrank.com/challenges/string-o-permute
%%%-------------------------------------------------------------------
-module(e5).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"), go(N).

go(0) -> ok;
go(N) -> { ok, [S]} = io:fread("", "~s"), permute(S, []), go(N-1).

permute([], Acc) -> io:fwrite("~s~n", [Acc]), ok;
permute([H1,H2|T], Acc) -> permute(T, [Acc | [[H2] | [H1]]]).