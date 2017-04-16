%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Aug 2016 2:11 AM
%%%-------------------------------------------------------------------
-module(e6).
-export([main/0]).

main() ->
  { ok, [N,Q]} = io:fread("", "~d~d"),
  {ok, [N1,N2]} = io:fread("", "~2u~2u"),
  {N1, N2}.
%%  {ok, [N1,N2]} = io:fread("", "~s~s"),
%%  start(N, Q, array:from_list(lists:reverse(N1)), array:from_list(lists:reverse(N2))).

start(_, 0, A, B) -> {A,B};
start(N, Q, A, B) ->
  {ok, CMD} = io:fread("", "~s"),
  case CMD of
    ["set_a"] -> {ok, [POS, V]} = io:fread("", "~d~d"),
                 start(N, Q-1, array:set(POS, V+48, A), B);
    ["set_b"] -> {ok, [POS, V]} = io:fread("", "~d~d"),
                 start(N, Q-1, A, array:set(POS, V+48, B));
    ["get_c"] -> {ok, [POS]} = io:fread("", "~d"),
                 C = array:get(POS - 1, A) + array:get(POS - 1, B) - 96,
                 io:fwrite("~p", [C]),
                 start(N, Q-1, A, B)
  end.

    %%%start(N).

