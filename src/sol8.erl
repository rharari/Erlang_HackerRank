%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 8:12 AM
%%%-------------------------------------------------------------------
-module(sol8).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  Str = string:strip(io:get_line(""), right, $\n),
  H = lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, string:tokens(Str, " ")),
  Max = lists:max(H),
  io:format("~p~n", [length([X || X <- H, X == Max])]).

