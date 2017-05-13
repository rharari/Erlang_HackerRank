%%%-------------------------------------------------------------------

%%%-------------------------------------------------------------------
-module(t5).
-author("ricardo.harari@gmail.com").
-export([reverse_list/1, reverse_list2/1]).

%% sample input "2 --> 1 --> 4 --> 5 --> NULL"

reverse_list(Lst) -> print(reverse(Lst, [])).

reverse_list2(S) ->
  S1 = re:replace(S, " -->", "", [global, {return,list}]),
  S2 = re:replace(S1, "NULL", "", [global, {return,list}]),
  print2(lists:reverse(string:tokens(S2, " "))).

print2([]) -> true;
print2([H|T]) -> io:format("~s~n", [H]), print2(T).

print([]) -> true;
print([H|T]) -> io:format("~p~n", [H]), print(T).

reverse([], Acc) -> Acc;
reverse([H|T], Acc) -> reverse(T, [H] ++ Acc).