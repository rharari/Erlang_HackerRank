%%%-------------------------------------------------------------------

%%%-------------------------------------------------------------------
-module(t2).
-author("ricardo.harari@gmail.com").
-export([reverse_word/1]).


reverse_word(S) ->
  Lst = string:tokens(S, " "),
  reverse(Lst, "", "").

reverse([], _, Acc) -> Acc;
reverse([H|T], Sp, Acc) -> reverse(T, " ", H ++ Sp ++ Acc).