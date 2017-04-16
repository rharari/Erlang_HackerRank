%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2016 7:08 PM
%%%-------------------------------------------------------------------
-module(solH).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"),
    exec(N).

exec(0) -> {ok};
exec(N) ->
    { ok, [X]} = io:fread("", "~d"),
    printDivisors(X),
    exec(N-1).

printDivisors(N) ->
  I = 1,
  io:format("~p~n", [countDivisors(N, I, 0)]).

countDivisors(N, I, Size) when I*I > N -> Size;
countDivisors(N, I, Size) ->
  V = round(N/I),
  case N rem I of
      0 ->
        case V of
          I -> countDivisors(N, I + 1, Size + checkDiv2(I));
          _ -> countDivisors(N, I + 1, Size + checkDiv2(I) + checkDiv2(V))
        end;
      _ -> countDivisors(N, I + 1, Size)
  end.

checkDiv2(N) when N rem 2 == 0 -> 1;
checkDiv2(_) -> 0.