%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% Fibonacci
%%% @end
%%% Created : 03. Aug 2016 12:42 AM
%%%-------------------------------------------------------------------
-module(func2).

-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"), go(N).

go(0) -> {ok};
go(N) -> { ok, [V]} = io:fread("", "~d"),
  io:fwrite("~p~n", [fib(V) rem (100000007)]),
  go(N-1).

fib(N) -> {_, V, _, _} = mtx(N, {1,1,1,0}, {1,0,0,1}), V.

mtx(0, _, R) -> R;
mtx(N, M, R) when N rem 2 =/= 0 -> mtx(N  div 2, mtxc(M, M), mtxc(R, M));
mtx(N, M, R)  -> mtx(N div 2, mtxc(M, M), R).

mtxc({X0,X1,X2,X3}, {Y0,Y1,Y2,Y3}) -> {X0*Y0+X1*Y2, X0*Y1+X1*Y3, X2*Y0+X3*Y2, X2*Y1+X3*Y3}.