%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/beautiful-days-at-the-movies
%%% @end
%%%-------------------------------------------------------------------
-module(e4).
-author("ricardo.harari@gmail.com").

%% API
-export([main/0]).

main() -> {ok, [I,J,K]} = io:fread("", "~d ~d ~d"), go(I, J, K, 0).
go(I, J, _, Acc) when I > J -> io:format("~p", [Acc]), ok;
go(I, J, K, Acc) -> case (I - list_to_integer(lists:reverse(integer_to_list(I)))) rem K =:= 0 of
                      true -> go(I + 1, J, K, Acc + 1);
                      false -> go(I + 1, J, K, Acc)
                    end.
