%%%-------------------------------------------------------------------
%%% @author Ricardo A Harari - ricardo.harari@gmail.com
%%% @copyright MIT License
%%% @doc
%%% Compute the number of inversions in the file given, where the ith row of the file indicates the ith entry of an array.
%%% result -> 2407905288
%%% @end
%%% Created : 30. Dec 2017 8:01 AM
%%%-------------------------------------------------------------------
-module(week2_p1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

%% API
-export([]).

main() ->
  A = binary:split(getFile(), [<<"\n">>, <<" ">>], [global]),
  Lst = [binary_to_integer(C) || C <- A],
  count_inv(Lst).
  % count_inv([1,6,3,2,4,5]).

count_inv([]) -> 0;
count_inv(Lst) ->
  N = length(Lst),
  case (N =< 1) of
    true -> 0;
    false ->
        {L1, L2} = lists:split(trunc(N/2), Lst),
        C1 = count_inv(L1),
        C2 = count_inv(L2),
        C1 + C2 + merge_count_splitinv(L1, L2, 0)
  end.

merge_count_splitinv([], _, C) -> C;
merge_count_splitinv(_, [], C) -> C;
merge_count_splitinv(L1, L2, C) ->
  [A|L1a] = L1, [B|L2a] = L2,
  case (A > B) of
    true -> merge_count_splitinv(L1, L2a, C + length(L1));
    false -> merge_count_splitinv(L1a, L2, C)
  end.


getFile() -> {ok, F} = file:read_file("array.txt"), F.