%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Aug 2016 9:52 AM
%%%-------------------------------------------------------------------
-module(e4).
-author("rharari").
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"), go(N).

go(0) -> {ok};
go(N) -> { ok, [X]} = io:fread("", "~d"),
         io:fwrite("~p~n", [4294967295-X]),
         go(N-1).
