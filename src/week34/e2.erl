%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% hacker rank - maximum gcd and sum
%%% @end
%%% https://www.hackerrank.com/contests/w34/challenges/maximum-gcd-and-sum
%%%-------------------------------------------------------------------
-module(e2).
-export([main/0]).
-author("ricardo.harari@gmail.com").

main() ->
  %                       !
  X = <<"1,2,3,4,5,6,7,9,10,12,21">>,
  [N|A] = binary:split(X, [<<"\n">>, <<" ">>], [global]),
  L = [binary_to_integer(C) || C <- A],
  {L1,L2} = lists:split(binary_to_integer(N), L),
  LA = lists:usort(fun(A,B)-> B =< A end,L1),
  LB = lists:usort(fun(A,B)-> B =< A end,L2),
  io:format("~p", [go(LA,LB,0,0)]).

go([], _, _, T2) -> T2;
go(_, [], _, T2) -> T2;
go(LA,LB,T1,T2) ->
  [HA|TA] = LA, [HB|TB] = LB,
  Tx = gcd(HA, HB),
  check(LA, LB, Tx, T1, T2, HA + HB).

check([HA|_],[HB|_],Tx,T1,T2,Ty) when Tx >= HA orelse Tx >= HB ->
  case Tx > T1 of
    true -> Ty;
    false -> T2
  end;
check([HA|_],[HB|_],Tx,T1,T2, Ty) when T1 >= HA orelse T1 >= HB -> T2;
check(LA,LB,Tx,T1,T2,Ty) when Tx < T1 -> go2(LA,LB,T1,T2);
check(LA,LB,Tx,T1,T2,Ty) when Tx > T1 -> go2(LA,LB,Tx,Ty);
check(LA,LB,Tx,T1,T2,Ty) when Tx =:= T1 andalso Ty > T2 -> go2(LA,LB,Tx,Ty);
check(LA,LB,Tx,T1,T2,Ty) -> go2(LA,LB,T1,T2).

go2(LA,LB,T1,T2) ->
  [HA|TA] = LA, [HB|TB] = LB,
  case HA > HB of
    true -> go(TA, LB, T1, T2);
    false -> go(LA, TB, T1, T2)
  end.

max(A,B) when A > B -> A;
max(A,B) -> B.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of {ok, D} -> getBin(<<T/bytes, D/bytes>>); eof -> T  end.
