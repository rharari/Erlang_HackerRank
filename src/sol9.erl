%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 8:41 AM
%%%-------------------------------------------------------------------
-module(sol9).
-author("ricardo.harari@gmail.com").
-export([main/0]).
-define(  L, [1, 2, 4, 6, 12, 24, 36, 48, 60, 120, 180, 240, 360, 720, 840, 1260, 1680, 2520, 5040,
  7560, 10080, 15120, 20160, 25200, 27720, 45360, 50400, 55440, 83160, 110880, 166320, 221760, 277200,
  332640, 498960, 554400, 665280, 720720, 1081080, 1441440, 2162160]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  A0 = array:new(N),
  A1 = go(N, 0, A0),
  print(array:to_list(A1)).

print([]) -> {ok};
print([H|T]) ->
  io:fwrite("~p~n", [H]),
  print(T).


go(0, _, A0) -> A0;
go(N, Pos, A0) ->
  { ok, [Num]} = io:fread("", "~d"),
  A1 = array:set(Pos, getElement(Num), A0),
  %%io:fwrite("~p~n", [getElement(Num)]),
  go(N - 1, Pos + 1, A1).

getElement(N) ->
  case lists:dropwhile(fun(X) -> N > X end, ?L) of
    [] -> error;
    [X | _] -> X
  end.