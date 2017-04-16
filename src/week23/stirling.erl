%%%-------------------------------------------------------------------
%%% @author Ricardo A Harari - ricardo.harari@gmail.com
%%% @copyright MIT
%%% @doc
%%% Stirling numbers of the first kind
%%% @end
%%% Created : 19. Sep 2016 3:32 AM
%%%-------------------------------------------------------------------
-module(stirling).
-author("ricardo.harari@gmail.com").
-export([calculate/1]).

calculate(N) -> printResult(0, triangle(N)).

printResult(_, []) -> {ok};
printResult(0, [H|T]) -> printResult(H, T);
printResult(L, [H|T]) -> D = H - L, io:format("~p ", [D]), printResult(D, T).

triangle(N) when N == 2 -> [1, 2];
triangle(N) when N == 3 -> [1, 4, 6];
triangle(N) -> genTriangle([1,4,6], 3, N).

genTriangle(T, NT, N) when NT == N -> T;
genTriangle(T, NT, N) -> T2 = calcTriangle(T, NT, 2, [1]), genTriangle(T2, NT + 1, N).

calcTriangle(T, NT, I, T2) when I > NT -> T2 ++ [lists:nth(I-1,T2) + lists:nth(I-1,T)];
calcTriangle(T, NT, I, T2) -> calcTriangle(T, NT, I + 1, T2 ++ [lists:nth(I, T) + (NT) * lists:nth(I - 1, T)]).
