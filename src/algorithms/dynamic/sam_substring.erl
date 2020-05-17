%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% https://www.hackerrank.com/challenges/sam-and-substrings/problem
%%% @end

%%% c("sam_substring.erl").
%%%-------------------------------------------------------------------
-module(sam_substring).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
    {ok, [S]} = io:fread("", "~s"),
    R = calculate(string:reverse(S), length(S), 0, 1),
    io:format("~p~n", [R rem 1000000007]).

calculate([], _, Total, _) -> Total;
calculate([H|T], Pos, Total, M) -> calculate(T, Pos - 1, Total + M * ((H - 48) * Pos), (M * 10 + 1) rem 1000000007).
