%%%-------------------------------------------------------------------

%%%-------------------------------------------------------------------
-module(t6).
-author("rharari").
-export([maximum_sum/1]).

maximum_sum([]) -> true;
maximum_sum(Lst) ->
  {Acc2, MaxValue, Max} = do_calc(Lst, 0, 0, 0, lists:nth(1, Lst), 0),
  {NewAcc1, NewAcc2} = check_positives(Max, Acc2, MaxValue),
  io:format("~p ~p", [NewAcc1, NewAcc2]).

check_positives(_, Acc2, MaxValue) when Acc2 =< 0 -> {MaxValue, MaxValue};
check_positives(Acc1, Acc2, _) -> {Acc1, Acc2}.

do_calc([], _, _, Acc2, MaxValue, Max) -> {Acc2, MaxValue, Max};

do_calc([H|T], Acc1, Acc1Tmp, Acc2, MaxValue, Max) when H > 0 ->
  NewAcc1 = Acc1 + H,
  X0 = Acc1Tmp + NewAcc1,
  NewMax = check_max(X0, Max),
  do_calc(T, NewAcc1, Acc1Tmp, Acc2 + H, MaxValue, NewMax);

do_calc([H|T], Acc1, Acc1Tmp, Acc2, MaxValue, Max) ->
  NewAcc1Tmp = Acc1Tmp + H,
  NewMaxValue = check_max(H, MaxValue),
  X0 = NewAcc1Tmp + Acc1,
  {NewAcc1T, NewAcc1} = checkX0(X0, NewAcc1Tmp, Acc1),
  do_calc(T, NewAcc1, NewAcc1T, Acc2, NewMaxValue, Max).

checkX0(X0, _, _) when X0 =< 0 -> {0,0};
checkX0(_, A, B) -> {A,B}.

check_max(A, B) when A > B -> A;
check_max(_, B) -> B.
