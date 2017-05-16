%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% hacker rank week of code 32
%%% fight the monsters
%%%
%%% @end
%%% https://www.hackerrank.com/contests/w32/challenges/fight-the-monsters
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
          [_,Hit,T|L2] = [binary_to_integer(C) || C <- X1],
          io:format("~p", [max(0,shoot(Hit,T,lists:sort(L2),0))]).

shoot(_, N, _, Acc) when N < 0 -> Acc - 1;
shoot(_, 0, _, Acc) -> Acc;
shoot(_, _, [], Acc) -> Acc;
shoot(Hit, N, [H|T], Acc) -> shoot(Hit, N-ceil(H / Hit), T, Acc + 1).

ceil(N) -> NT = trunc(N), case N - NT == 0 of true -> NT; false -> NT + 1 end.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.