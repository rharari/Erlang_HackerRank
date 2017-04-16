%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Aug 2016 2:44 AM
%%%-------------------------------------------------------------------
-module(e1).
-author("rharari").

%% API
-export([main/0]).

main() ->
  {ok, [C]} = io:fread("", "~d"),
  go(C, {0,0,0}).

go(0, {P,N,Z}) -> T = P+N+Z,
                  io:fwrite("~p~n~p~n~p~n", [P/T,N/T,Z/T]),
                  ok;
go(C, {P,N,Z}) -> {ok, [V]} = io:fread("", "~d"),
                  go(C-1, sum(V, {P,N,Z})).
sum(0, {P,N,Z}) -> {P,N,Z+1};
sum(V, {P,N,Z}) when V < 0 -> {P,N+1,Z};
sum(_, {P,N,Z}) -> {P+1,N,Z}.
