%%%-------------------------------------------------------------------
%%% @author ricardo.harari@gmail.com
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/contests/projecteuler/challenges/euler001
%%% @end
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->  X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [_|L] = [binary_to_integer(C) || C <- X1],
  sum(L).

sum([]) -> {ok};
sum([N|T]) ->
  N1 = (N-1) div 3,
  N2 = (N-1) div 5,
  N3 = (N-1) div 15,
  io:fwrite("~p~n", [ (3 * N1 * (N1 + 1) + 5 * N2 * (N2 + 1) - 15 * N3 * (N3 + 1)) div 2]),
  sum(T).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.