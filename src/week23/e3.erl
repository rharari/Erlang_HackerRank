%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Sep 2016 11:57 PM
%%%-------------------------------------------------------------------
-module(e3).
-export([main/0]).

main() ->
  { ok, [X1,Y1,A,B]} = io:fread("", "~d~d~d~d"),
  io:format("~p\n~p", calc(X1,Y1,A,B)).

calc(X1,Y1,A,B) ->
  M2 = math:tan(math:pi()/2 + math:atan(B/A)),
  Xpa = (Y1 - M2*X1)/(B/A-M2),
  Ypa = B/A * Xpa,
  D1 = math:sqrt(A*A + B*B),
  D2 = math:sqrt(Xpa*Xpa + Ypa*Ypa),
  D3 = math:sqrt((Xpa-X1)*(Xpa-X1) + (Ypa-Y1)*(Ypa-Y1)),
  case Xpa < X1 of
    true -> [D2/D1, -D3/D1];
    false -> [D2/D1, D3/D1]
  end.
