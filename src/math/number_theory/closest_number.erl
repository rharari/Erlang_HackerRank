%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%% https://www.hackerrank.com/challenges/strange-grid/problem
%%% @end
%%% Created : 20. Oct 2019
%%%-------------------------------------------------------------------
-module(closest_number).
-author("ricardo.harari@gmail.com").
-import(os, [getenv/1]).
-export([main/0]).

main() -> X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
          [_|L] = [binary_to_integer(C) || C <- X1], go(L).

go([]) -> {ok};
go([A,B,X|Arr]) -> V = math:pow(A, B),
                   V1 = X * trunc(V / X),
                   io:fwrite("~p~n", [check_closest(V, V1, V1 + X)]),
                   go(Arr).

check_closest(_, D1, D2) when D1 < 0 -> D2;
check_closest(V, D1, D2) -> V1 = abs(V - D1),
                            case min(V1, abs(V - D2)) == V1 of
                              true -> D1;
                              false -> D2
                            end.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.