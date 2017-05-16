%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% minimum multiple
%%% @end
%%% https://www.hackerrank.com/challenges/minimum-multiple
%%%-------------------------------------------------------------------
-module(e5).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> [N,A,K|Arr] = binary:split(getBin(), [<<"\n">>], [global]),
        io:format("~s", [merge(<<>>,P,Q,0,size(P))]).

merge(Acc, _,_,I, Size) when I == Size -> Acc;
merge(Acc, P,Q,I,Size) ->
  P1 = binary:at(P,I), Q1 = binary:at(Q,I),
  merge(<<Acc/binary, <<P1>>/binary, <<Q1>>/binary>>, P,Q,I+1,Size).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
