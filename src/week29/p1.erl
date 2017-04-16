%%%-------------------------------------------------------------------
%%% @author Ricardo A Harari
%%%-------------------------------------------------------------------
-module(p1).
-author("ricardo.harari@gmail.com").

%% API
-export([main/0]).

main() ->
  { ok, [Y]} = io:fread("", "~d"),
  printDate(Y).

printDate(Y) when Y > 1918 andalso Y rem 400 =:= 0 -> io:format("12.09.~p", [Y]);
printDate(Y) when Y > 1918 andalso Y rem 4 =:= 0 andalso Y rem 100 > 0 -> io:format("12.09.~p", [Y]);
printDate(Y) when Y > 1918 -> io:format("13.09.~p", [Y]);
printDate(Y) when Y < 1918 andalso Y rem 4 =:= 0 -> io:format("12.09.~p", [Y]);
printDate(Y) when Y < 1918 -> io:format("13.09.~p", [Y]);
printDate(Y) when Y == 1918 -> io:format("26.09.1918").
