%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% Gears of War
%%% @end
%%% Created : 12. Sep 2016 11:18 PM
%%%-------------------------------------------------------------------
-module(e1).
-export([main/0]).

main() ->
  B = getBin(),
  A = binary:split(B, [<<"\n">>, <<" ">>], [global]),
  [H|T] = [binary_to_integer(C) rem 2 || C <- A],
  print(T).

print([]) -> {ok};
print([0|T]) -> io:fwrite("Yes\n"), print(T);
print([1|T]) -> io:fwrite("No\n"), print(T).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.