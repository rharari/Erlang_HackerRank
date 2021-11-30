%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% https://www.hackerrank.com/challenges/sherlock-and-moving-tiles/problem
%%% @end
%%%-------------------------------------------------------------------
-module(sherlock_moving_tiles).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
          [L,S1,S2,_Q|Qs] = [binary_to_integer(C) || C <- X1],
          process_queries(L, (S1 - S2) * 0.7071067811865476, Qs).

process_queries(_L, _Ds, []) -> ok;
process_queries(L, Ds, [Qi|Qs]) ->
  io:format("~w~n", [abs((math:sqrt(Qi) - L) / Ds)]),
  process_queries(L, Ds, Qs).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
