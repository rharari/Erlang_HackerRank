%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% hacker rank - twin array
%%% @end
%%% https://www.hackerrank.com/contests/w33/challenges/twin-arrays
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  %% X = <<"3 1 10 10 1 10 1">>,
  A = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [N|L] = [binary_to_integer(C) || C <- A],
  {L1,L2} = lists:split(N, L),
  {A1,P1,A2,_} = findMin(L1, 0, 1000000, 0, 1000000, 0),
  {B1,Q1,B2,_} = findMin(L2, 0, 1000000, 0, 1000000, 0),
  case P1 =/= Q1 of
    true -> io:format("~p", [A1+B1]);
    false ->
      case A1 + B2 < A2 + B1 of
        true -> io:format("~p", [A1+B2]);
        false -> io:format("~p", [A2+B1])
      end
  end.

findMin([], _, A1, P1, A2, P2) -> {A1, P1, A2, P2};
findMin([H|T], Px, A1, P1, A2, P2) ->
  case H < A1 of
    true -> findMin(T, Px + 1, H, Px, A1, P1);
    false ->
      case H < A2 of
        true -> findMin(T, Px + 1, A1, P1, H, Px);
        false -> findMin(T, Px + 1, A1, P1, A2, P2)
      end
  end.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.