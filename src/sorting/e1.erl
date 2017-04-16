%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Sep 2016 1:44 AM
%%%-------------------------------------------------------------------
-module(e1).
-export([main/0]).

main() ->
  { ok, [V,_]} = io:fread("", "~d~d"),
  io:format("~p", find(V,0)).

find(V,P) -> { ok, [A]} = io:fread("", "~d"),
            case A == V of
              true -> [P];
              false -> find(V, P+1)
            end.
