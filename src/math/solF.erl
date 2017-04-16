%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% Compute the Area of a Polygon on N points
%%% @end
%%% Created : 30. Jul 2016 9:27 AM
%%%-------------------------------------------------------------------
-module(solF).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  { ok, [X,Y]} = io:fread("", "~d~d"),
  {A,X1,Y1} = read(N-1,0,X,Y),
  io:fwrite("~p~n", [round( abs((A + calc(X1,Y1,X,Y))*5))/10]).

read(0,A,X,Y) -> {A,X,Y};
read(N,A,X,Y) ->
  { ok, [X1,Y1]} = io:fread("", "~d~d"),
  get(N-1,A + calc(X,Y,X1,Y1),X1,Y1).

calc(X,Y,X1,Y1) -> (X+X1) * (Y1-Y).
