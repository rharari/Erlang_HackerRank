%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 7:09 AM
%%% Circular Array Rotation
%%%-------------------------------------------------------------------
-module(sol6).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N, K, Q]} = io:fread("", "~d~d~d"),
  Arr = string:tokens(string:strip(io:get_line(""), right, $\n), " " ),
  {ok} = printElem(N, Q, Arr, K rem N).

printElem(_, 0, _, _) -> {ok};
printElem(Size, Q, Arr, Shift) ->
  {ok, [X]} = io:fread("", "~d"),
  io:format("~s~n", [lists:nth(getPos(X - Shift + Size, Size), Arr)]),
  printElem(Size, Q-1, Arr, Shift).

getPos(Pos, N) when Pos >= N -> Pos - N + 1;
getPos(Pos, _) -> Pos + 1.
