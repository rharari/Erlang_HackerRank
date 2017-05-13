%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017
%%% @doc
%%%
%%% @end
%%% https://www.hackerrank.com/challenges/handshake
%%%-------------------------------------------------------------------
-module(e2b).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [T]} = io:fread("", "~d"),
  T_list = lists:seq(1,T),
  lists:foreach(
      fun(_) ->
          { ok, [N]} = io:fread("", "~d"),
          io:format("~p~n", [N * (N-1) div 2])
      end, T_list),
  {ok}.