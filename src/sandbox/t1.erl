%%%-------------------------------------------------------------------

%%%-------------------------------------------------------------------
-module(t1).
-author("ricardo.harari@gmail.com").
-export([is_sorted/1, test/0]).

is_sorted([]) -> true;
is_sorted([H|T]) -> check(H, T).

check(_, []) -> true;
check(H, [H2|_]) when H > H2 -> false;
check(_, [H2|T]) -> check(H2, T).

test() ->
  {true, false} =:= {is_sorted(lists:seq(1,10000)), is_sorted(lists:seq(1,100000) ++ [1])}.
