%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% https://www.hackerrank.com/challenges/special-multiple/problem
%%% @end
%%%-------------------------------------------------------------------
-module(special_multiple).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
          [_|L] = [binary_to_integer(C) || C <- X1],
          consume_query(L, gen_result(gen_multiples(1, []), #{}, 1)).

gen_result(_M, Map, 501) -> Map;
gen_result(M, Map, N) -> gen_result(M, maps:put(N, find_multiple(N, 1, M), Map), N + 1).

consume_query([], _) -> ok;
consume_query([H|T], M) -> {ok, V} = maps:find(H, M),
                           io:format("~w~n", [V]),
                           consume_query(T, M).

gen_multiples(5000, Acc) -> Acc;
gen_multiples(N, Acc) -> {V, _} = string:to_integer(string:replace(binary_to_list(integer_to_binary(N, 2)), "1", "9", all)),
                         gen_multiples(N + 1, Acc ++ [V]).

find_multiple(N, Pos, M) ->
  case lists:nth(Pos, M) rem N of
    0 -> lists:nth(Pos, M);
    _ -> find_multiple(N, Pos + 1, M)
  end.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
