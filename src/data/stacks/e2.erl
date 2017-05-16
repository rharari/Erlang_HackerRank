%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% Balanced Backets
%%%
%%% @end
%%% https://www.hackerrank.com/challenges/balanced-brackets
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> [_|Lst] = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]), go(Lst).

go([]) -> ok;
go([H|T]) -> check(binary_to_list(H), []), go(T).

check([], []) -> io:fwrite("YES~n");
check([H|T], Acc) when H == 123 orelse H == 91 orelse H == 40 -> check(T, [H] ++ Acc);
check([H|T], [HA|TA]) when HA == 123 andalso H == 125 -> check(T, TA);
check([H|T], [HA|TA]) when HA == 40 andalso H == 41 -> check(T, TA);
check([H|T], [HA|TA]) when HA == 91 andalso H == 93 -> check(T, TA);
check(_, _) -> io:fwrite("NO~n").

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of {ok, D} -> getBin(<<T/bytes, D/bytes>>); eof -> T end.
