%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% hacker rank week of code 32
%%% Duplication
%%%
%%% @end
%%% https://www.hackerrank.com/contests/w32/challenges/duplication
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0, fillArray/1]).

main() -> { ok, [N]} = io:fread("", "~d"), print(N, fillArray([0])).

print(0, _) -> ok;
print(N, Lst) -> {ok, [I]} = io:fread("", "~d"),
                 io:fwrite("~p~n", [lists:nth(I+1, Lst)]), print(N-1, Lst).

fillArray(Lst) ->  Lst2 = Lst ++ inverse(Lst, []),
                   case length(Lst2) > 1000 of true -> Lst2; false -> fillArray(Lst2) end.

inverse([], Acc) -> Acc;
inverse([H|T], Acc) -> inverse(T, Acc ++ [abs(H-1)]).
