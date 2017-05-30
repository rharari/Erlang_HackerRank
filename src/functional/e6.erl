%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% string compression
%%% @end
%%% https://www.hackerrank.com/challenges/string-compression
%%%-------------------------------------------------------------------
-module(e6).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [S]} = io:fread("", "~s"), compress(S, "", 0, []).

compress([], Ch, Cnt, Acc) -> {_, Acc2} = check(" ", Ch, Cnt, Acc), io:fwrite("~s~n", [Acc2]), ok;
compress([H|T], Ch, Cnt, Acc) -> {Cnt2, Acc2} = check(H, Ch, Cnt, Acc), compress(T, H, Cnt2, Acc2).

check(H, Ch, Cnt, Acc) when H =:= Ch -> {Cnt+1, Acc};
check(H, Ch, Cnt, Acc) when H =/= Ch andalso Cnt > 1 -> {1, [Acc | [ [Ch] ++ integer_to_list(Cnt)]]};
check(H, Ch, 1, Acc) when H =/= Ch -> {1, [Acc | [Ch]]};
check(_, _, _, Acc) -> {1, Acc}.
