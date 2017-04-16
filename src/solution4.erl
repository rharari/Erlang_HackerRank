%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 2:37 AM
%%%-------------------------------------------------------------------
-module(solution4).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N] } = io:fread("", "~d"),
  io:format("~p~n", [read_array(N, 0, 0, 0)]).

read_array(Size, CurrentLine, S1, S2) when CurrentLine =:= Size ->
  abs(S1 - S2);
read_array(Size, CurrentLine, S1, S2) ->
  [Sum1, Sum2] = read_line(Size, CurrentLine, Size - CurrentLine - 1, S1, S2),
  read_array(Size, CurrentLine + 1, Sum1, Sum2).

read_line(0, _, _, S1, S2 ) -> [S1, S2];
read_line(Size, Col1, Col2, S1, S2 ) ->
  {ok, [X]} = io:fread("", "~d"),
  read_line(Size - 1, Col1 - 1, Col2 - 1, getSum(S1, X, Col1), getSum(S2, X, Col2) ).

getSum(S, X, Col) when Col =:= 0 -> S + X;
getSum(S, _, _) -> S.

