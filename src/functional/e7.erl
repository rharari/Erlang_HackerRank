%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% hacker hank - super digit
%%% @end
%%% https://www.hackerrank.com/challenges/super-digit
%%%-------------------------------------------------------------------
-module(e7).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [Lst,N]} = io:fread("", "~s~d"),
          superdigit(integer_to_list(sum(Lst, 0) * N)).

superdigit(V) when length(V) =:= 1 -> io:format("~s", [V]);
superdigit(V)  -> superdigit(integer_to_list(sum(V, 0))).

sum([], Acc) -> Acc;
sum([A|B], Acc) -> sum(B, Acc + A - 48).
