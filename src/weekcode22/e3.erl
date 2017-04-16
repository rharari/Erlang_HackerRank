%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Aug 2016 3:56 AM
%%%-------------------------------------------------------------------
-module(e3).
-author("rharari").
-export([main/0]).
main() -> {ok, [N]} = io:fread("", "~d"),
  A = lists:sort(lists:map(fun(X) -> {Int, _} = string:to_integer(X),  Int end,  string:tokens(io:get_line(""), " "))),
  B = lists:sort(lists:map(fun(X) -> {Int, _} = string:to_integer(X),  Int end,  string:tokens(io:get_line(""), " "))),
  print(sum({0,0}, A,B)).

print({V1, V2}) when V1 =/= V2 -> io:format("-1");
print({V1, _}) -> io:format("~p", [V1]).


sum({V1, V2}, [], _) -> {V1, V2};
sum({V1, V2}, [H1|T1], [H2|T2]) ->
  V = H1 - H2,
  case V >= 0 of
    true -> sum({V1 + V, V2}, T1, T2);
    false -> sum({V1, V2 - V}, T1, T2)
  end.

%%read_array(0) -> [];
%%read_array(N) -> {ok, [X]} = io:fread("", "~d"), [X | read_array(N-1)].
