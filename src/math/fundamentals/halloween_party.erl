%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% https://www.hackerrank.com/challenges/halloween-party/problem
%%% @end
%%% c("halloween_party.erl")
%%%-------------------------------------------------------------------
-module(halloween_party).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
          [_L|Ks] = [binary_to_integer(C) || C <- X1],
          process_cuts(Ks).

process_cuts([]) -> ok;
process_cuts([K|L]) -> print(K, K div 2),
                       process_cuts(L).

print(K, K2) when (K band 1) == 0 -> io:format("~w~n", [K2 * K2]);
print(_K, K2) -> io:format("~w~n", [K2 * (K2 + 1)]).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
