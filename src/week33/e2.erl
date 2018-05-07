%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% pattern count
%%% @end
%%% https://www.hackerrank.com/contests/w33/challenges/pattern-count
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> [_|Lst] = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]), process(Lst).

process([]) -> ok;
process([H|T]) -> io:format("~p~n", [countPattern(binary:bin_to_list(H), false, false, 0)]), process(T).

countPattern([], _, _, Acc) -> Acc;
countPattern([H|T], _, true, Acc) when H =:= 49 -> countPattern(T, true, false, Acc + 1);
countPattern([H|T], _, _, Acc) when H =:= 49 -> countPattern(T, true, false, Acc);
countPattern([H|T], true, _, Acc) when H =:= 48 -> countPattern(T, true, true, Acc);
countPattern([_H|T], _, _, Acc) -> countPattern(T, false, false, Acc).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of {ok, D} -> getBin(<<T/bytes, D/bytes>>); eof -> T  end.