%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% hacker rank - once in a tram
%%% @end
%%% https://www.hackerrank.com/contests/w34/challenges/once-in-a-tram
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->  { ok, [A]} = io:fread("", "~s"),
           io:format("~s", [start(A)]).

start([X1,X2,X3,X4,X5,X6]) -> nxtLucky([X1,X2,X3,X4,X5,X6+1]).
nxtLucky([X1,58,X3,X4,X5,X6]) -> nxtLucky([X1+1,48,X3,X4,X5,X6]);
nxtLucky([X1,X2,58,X4,X5,X6]) -> nxtLucky([X1,X2+1,48,X4,X5,X6]);
nxtLucky([X1,X2,X3,58,X5,X6]) -> nxtLucky([X1,X2,X3+1,48,X5,X6]);
nxtLucky([X1,X2,X3,X4,58,X6]) -> nxtLucky([X1,X2,X3,X4+1,48,X6]);
nxtLucky([X1,X2,X3,X4,X5,58]) -> nxtLucky([X1,X2,X3,X4,X5+1,48]);
nxtLucky([X1,X2,X3,X4,X5,X6]) -> {N1,N2} = sum([X1,X2,X3,X4,X5,X6]),
                                       case N1 =:= N2 of
                                         true -> [X1,X2,X3,X4,X5,X6];
                                         false -> nxtLucky([X1,X2,X3,X4,X5,X6+1])
                                       end.

sum([X1,X2,X3,X4,X5,X6]) -> {X1 + X2 + X3, X4 + X5 + X6}.
