%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% super reduced string
%%% @end
%%% https://www.hackerrank.com/challenges/reduced-string
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->  { ok, [S]} = io:fread("", "~s"),
           io:fwrite(go(S, []) ++ "~n").

go([], _) -> "Empty String";
go(S, S2) when S == S2 -> S;
go(S, _) -> S1 = reduce(S, []), go(S1, S).

reduce([], R) -> R;
reduce([H|T], R) -> reduce2(H, T, R).

reduce2(H1,[H2|T], R) when H1 =:= H2 -> reduce(T, R);
reduce2(H, L, R) -> reduce(L, R ++ [H]).
