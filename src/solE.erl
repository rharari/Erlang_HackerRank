%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2016 11:40 AM
%%%-------------------------------------------------------------------
-module(solE).

-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [X]} = io:fread("", "~d"),
  Arr = array:to_list(array:new(X, {default,0})),
  io:format("~B~n", [length(Arr)]).

