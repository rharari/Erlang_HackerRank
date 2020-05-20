%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% https://www.hackerrank.com/challenges/candies/problem
%%% @end
%%% c("candies.erl").
%%% candies:main().
%%%-------------------------------------------------------------------
-module(candies).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> L1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
          [_|Arr] = [binary_to_integer(C) || C <- L1],
          Arr1 = forward(nil, Arr, nil, nil),
          Total = backward(nil, lists:reverse(Arr), Arr1, [], nil),
          io:format("~p~n", [Total]).

backward(_, [], _, Acc, _) -> Acc;
backward(nil, [H|T], [X|Tx], _, _) -> backward(H, T, Tx, X, 1);
backward(A0, [A1|T], [X1|Tx], Acc, Acc0) when A1 > A0 -> backward(A1, T, Tx, Acc + max(Acc0 + 1, X1), Acc0 + 1);
backward(_A0, [A1|T], [X1|Tx], Acc, _Acc0) -> backward(A1, T, Tx, Acc + X1, 1).

forward(_, [], Acc, _) -> Acc;
forward(nil, [H|T], _, _) -> forward(H, T, [1], 1);
forward(A0, [A1|T], Acc, Acc0) when A1 > A0 -> forward(A1, T, [(Acc0 + 1)] ++ Acc, Acc0 + 1);
forward(_A0, [A1|T], Acc, _Acc0) -> forward(A1, T, [1] ++ Acc, 1).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
