%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/birthday-cake-candles
%%% @end
%%%-------------------------------------------------------------------
-module(e4).
-author("ricardo.harari@gmail.com").

%% API
-export([main/0]).

main() -> A = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
          [_, I|L] = [binary_to_integer(C) || C <- A],
          countCandles(I, L, 1).

countCandles(_, [], Acc) -> io:format("~p", [Acc]), ok;
countCandles(I, [H|T], Acc) when H < I -> countCandles(I, T, Acc);
countCandles(_, [H|T], Acc) -> countCandles(H, T, Acc + 1).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.