%%%-------------------------------------------------------------------

%%%-------------------------------------------------------------------
-module(t3).
-author("ricardo.harari@gmail.com").
-export([print_triangle/1, pascal_triangle/1]).


% {l1, l2, l3}
% {
%   [1],
%   [1,1],
%   [1,2,1],
%   [1,3,3,1],
%   ....
% }

print_triangle(N) ->
  R = pascal_triangle(N),
  element(N, R).

pascal_triangle(0) -> {[]};
pascal_triangle(1) -> {[1]};
pascal_triangle(2) -> {[1],[1,1]};
pascal_triangle(N) -> calc(pascal_triangle(2), 3, N).

calc(Acc, I, N) when I > N -> Acc;
calc(Acc, I, N) -> calc(erlang:insert_element(I, Acc, calc_triangle(element(I-1,Acc), [1])), I+1, N).

calc_triangle([H1, H2|[]], Acc) -> Acc ++ [H1 + H2] ++ [1];
calc_triangle([H1,H2|T], Acc) -> calc_triangle([H2] ++ T, Acc ++ [H1 + H2]).
