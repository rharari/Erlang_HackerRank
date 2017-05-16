%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% rotate string
%%% @end
%%% https://www.hackerrank.com/challenges/rotate-string
%%%-------------------------------------------------------------------
-module(e4).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"), reverse(N).

reverse(0) -> ok;
reverse(N) -> { ok, [C]} = io:fread("", "~s"),
  go(C, length(C)), reverse(N-1).

go(_,0) -> io:fwrite("~n");
go([H|T], I) -> io:fwrite("~s~c ",[T,H]), go(T ++ [H], I-1).

