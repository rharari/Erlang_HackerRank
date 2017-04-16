%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Oct 2016 1:28 AM
%%%-------------------------------------------------------------------
-module(sol1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  X1 = getBin(),
  X2 = binary:split(X1, [<<"\n">>, <<" ">>], [global]),
  [S, T, A, B, M, _|Tail] = [binary_to_integer(C) || C <- X2],
  {L1, L2} = lists:split(M, Tail),
  io:fwrite("~p~n~p", [count(L1, S-A, T-A, 0, 1), count(L2, B-T, B-S, 0, -1)]).

count([], _, _, C, _) -> C;
count([D|T], A1, A2, C, S) ->
  DD = D*S,
  case DD >= A1 andalso DD=<A2 of
    true -> count(T, A1, A2, C + 1, S);
    false -> count(T, A1, A2, C, S)
  end.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.


