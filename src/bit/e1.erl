%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Aug 2016 1:05 AM
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"),
  io:fwrite("~p", read_array(N, sets:new())).

read_array(0, S) -> sets:to_list(S);
read_array(N, S) -> {ok, [X]} = io:fread("", "~d"),
                    case sets:is_element(X, S) of
                      true -> read_array(N-1, sets:del_element(X, S));
                      false -> read_array(N-1, sets:add_element(X, S))
                    end.
