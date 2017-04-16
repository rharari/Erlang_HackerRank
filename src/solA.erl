%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 11:59 AM
%%%-------------------------------------------------------------------
-module(solA).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  { ok, [Track]} = io:fread("", "~s"),
  C = count(Track, N, 0, 1, 0),
  io:fwrite("~p~n", [C]).

count(Track, N, 0, Pos, Total) when Pos > N -> Total;

count(Track, N, Level, Pos, Total) ->
  Direction = lists:nth(Pos, Track),
  NewLevel = Level + getLevel(Direction),
  count(Track, N, NewLevel, Pos +1, sumTotal(Total, Level, NewLevel)).


getLevel(Direction) when Direction == 85 -> 1;
getLevel(_) -> -1.

sumTotal(Total, Level1, NewLevel) when Level1 < 0 andalso NewLevel == 0 -> Total + 1;
sumTotal(Total, _, _) -> Total.