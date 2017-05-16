%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% Maximum Element
%%%
%%% @end
%%% https://www.hackerrank.com/challenges/maximum-element
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [_|L] = [binary_to_integer(C) || C <- X1],
  process({[], L, 0}).

process({_, [], _}) -> ok;
process({Acc, [Cmd|T], Max}) -> process(processCmd(Cmd, Acc, T, Max)).

processCmd(1, Acc, [V|T], Max) -> {[V] ++ Acc,T, findMax(Max,V)};
processCmd(2, [V|T], T2, Max)  -> {T, T2, newMax(V,Max)};
processCmd(3, Acc, T, Max) -> NMax = getMax(Max, Acc), io:fwrite("~p~n", [NMax]), {Acc,T,NMax}.

findMax(Max, V) when Max > 0 -> max(Max, V);
findMax(_, _) -> 0.

getMax(0, Lst) -> lists:max(Lst);
getMax(Max, _) -> Max.

newMax(V, Max) when V < Max -> Max;
newMax(_, _) -> 0.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.