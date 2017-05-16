%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% pascals triangle
%%% @end
%%% https://www.hackerrank.com/challenges/pascals-triangle
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [K]} = io:fread("", "~d"), pascal([],2,K).

pascal(_,_,1) -> io:format("1");
pascal(_,2,K) -> io:format("1~n1 1"), pascal([1,1], 3, K);
pascal(_,I,K) when I > K -> true;
pascal([_|Lst],I,K) -> pascal(genPascal([1],1,Lst), I + 1, K).

genPascal(Acc, _, []) -> Ret = Acc ++ [1], print(Ret, "~n"), Ret;
genPascal(Acc, A, [B|T]) -> genPascal(Acc ++ [A+B], B, T).

print([], _) -> true;
print([H|T], Sep) -> io:format(Sep ++ "~p", [H]), print(T, " ").
