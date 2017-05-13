%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% How many substrings
%%% @end
%%% https://www.hackerrank.com/challenges/how-many-substrings
% http://stackoverflow.com/questions/2560262/generate-all-unique-substrings-for-given-string
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N,Q,S]} = io:fread("", "~d~d~s"),
  { ok, [L,R]} = io:fread("", "~d~d"),
  S0 = string:sub_string(S, L + 1, R + 1),
  Len = length(S0),
  Arr = lists:sort([L || X <- lists:seq(0, Len-1), L <- [string:sub_string(S0, Len-X, Len)]]),
  Qtd = length(lists:nth(1,Arr)),
  go(Len, 1, Arr, Qtd).


go(Len, I, Arr, Qtd) when I == Len -> Qtd;
go(Len, I, Arr, Qtd) ->
  S = lists:nth(I, Arr),
  go2(Len, I, Arr, Qtd, S, length(S),1),
  go(Len, I+1, Arr, Qtd).

go2(Len,I,Arr,Qtd,S,Slen,J) when J == Slen -> Qtd;
go2(Len,I,Arr,Qtd,S,Slen,J) ->

for (int i = 0; i < length - 1; ++i) {
int j = 0;
for (; j < arrayString[i].length(); ++j) {
if (!((arrayString[i].substring(0, j + 1)).equals((arrayString)[i + 1].substring(0, j + 1)))) {
break;
}
}
num_substring += arrayString[i + 1].length() - j;
}