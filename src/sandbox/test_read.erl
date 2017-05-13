%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Jul 2016 2:18 AM
%%%-------------------------------------------------------------------
-module(test_read).
-author("ricardo.harari@gmail.com").
-export([main/0]).

-define(BLK_SIZE, 16384).

main() ->
  Bin = read(),
  io:format("~p~n", [byte_size(Bin)]).

read() ->
  ok = io:setopts(standard_io, [binary]),
  read(<<>>).


read(Acc) ->
  case io:read(standard_io, ?BLK_SIZE) of
    {ok, Data} ->
      read(<<Acc/bytes, Data/bytes>>);
    eof ->
      io:fwrite('EOF !!!!'),
      Acc
  end.