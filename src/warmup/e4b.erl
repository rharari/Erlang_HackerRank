%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/birthday-cake-candles
%%% @end
%%%-------------------------------------------------------------------
-module(e4b).
-author("ricardo.harari@gmail.com").

%% API
-export([main/0]).

main() ->
  A = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [_|L] = [binary_to_integer(C) || C <- A],
  M = lists:max(L),
  N = lists:foldl(fun(_X,Count) when _X =:= M -> Count+1; (_,Count) -> Count end,0,L),
  io:format("~p", [N]).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
