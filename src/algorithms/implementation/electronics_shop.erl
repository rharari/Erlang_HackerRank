%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%%   https://www.hackerrank.com/challenges/electronics-shop/problem
%%% @end
%%% Created : 19. Aug 2019 02:18
%%%-------------------------------------------------------------------

-module(electronics_shop).
-author("rharari").
-export([main/0]).
-import(os, [getenv/1]).

getMoneySpent(K, D, B) -> sum(K, D, B, -1).

sum([], _, _, Max) -> Max;
sum([H|T], D, B, Max) -> sum2(H, T, D, D, B, Max).

sum2(_, T, [], D, B, Max) -> sum(T, D, B, Max);
sum2(H, T, [Dh|Dt], D, B, Max) -> verify(H, T, Dh + H, Dt, D, B, Max).

verify(_, _, Tot, _, _, B, _) when Tot == B -> B;
verify(H, T, Tot, Dt, D, B, Max) when Tot > Max andalso Tot < B -> sum2(H, T, Dt, D, B, Tot);
verify(H, T, _, Dt, D, B, Max) -> sum2(H, T, Dt, D, B, Max).

main() ->
  {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),
  Bnm = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),
  {B, _} = string:to_integer(lists:nth(1, Bnm)),
  {_N, _} = string:to_integer(lists:nth(2, Bnm)),
  {_M, _} = string:to_integer(lists:nth(3, Bnm)),
  KeyboardsTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),
  Keyboards = lists:map(fun(X) -> {I, _} = string:to_integer(X), I end, KeyboardsTemp),
  DrivesTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),
  Drives = lists:map(fun(X) -> {I, _} = string:to_integer(X), I end, DrivesTemp),
  %
  % The maximum amount of money she can spend on a keyboard and USB drive, or -1 if she can't purchase both items
  %
  MoneySpent = getMoneySpent(Keyboards, Drives, B),
  io:fwrite(Fptr, "~w~n", [MoneySpent]),
  file:close(Fptr),
  ok.

