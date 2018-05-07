%%%-------------------------------------------------------------------
%%% @author Ricardo A Harari - ricardo.harari@gmail.com
%%% @copyright MIT License
%%% @doc
%%% @end
%%% Created : 4. Jan 2018 3:27 PM
%%%-------------------------------------------------------------------
-module(p2a).
-author("ricardo.harari@gmail.com").
-export([main/0]).

%% API
-export([]).

main() ->
  A = binary:split(getFile(), [<<"\n">>, <<" ">>], [global]),
  Lst = [binary_to_integer(C) || C <- A],
  sort({Lst, 0}).
% count_inv([1,6,3,2,4,5]).

sort({[], C}) -> {[], 0};
sort({[Pivot|T], C}) ->
  L = ([ X || X <- T, X =< Pivot]),
  R = lists:reverse([ X || X <- T, X > Pivot]),
  {L1, C1} = sort({L, length(L)}),
  {L2, C2} = sort({R, length(R)}),
  {L1 ++ [Pivot] ++ L2, C1 + C2 + C}.

getFile() -> {ok, F} = file:read_file("qicksort.txt"), F.