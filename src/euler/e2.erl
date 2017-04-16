%%%-------------------------------------------------------------------
%%% @author ricardo.harari@gmail.com
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/contests/projecteuler/challenges/euler002
%%% @end
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->  X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
           [_|L] = [binary_to_integer(C) || C <- X1],
           go(L).

go([]) -> {ok};
go([N|T]) -> io:fwrite("~p~n", [calc(N, 1, 2, 2)]),  go(T).

calc(1, _, _, _) -> 0;
calc(2, _, _, _) -> 2;
calc(N, L1, L2, Sum) when N < L1 + L2 -> Sum;
calc(N, L2, L1, Sum) -> L0 = L2 + L1,
                        calc(N, L1, L0, Sum + even(L0)).

even(L) when L rem 2 =:= 0 -> L;
even(_) -> 0.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.