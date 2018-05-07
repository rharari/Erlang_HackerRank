%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% left rotation
%%% @end
%%% https://www.hackerrank.com/challenges/array-left-rotation
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  [_, D|Arr] = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  {L1,L2} = lists:split(binary_to_integer(D), Arr),
  io:format("~s", [binary:list_to_bin(lists:join(" ", L2 ++ L1))]).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.