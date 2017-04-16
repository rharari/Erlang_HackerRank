%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Sep 2016 8:16 PM
%%%-------------------------------------------------------------------
-module(e7).
-author("ricardo.harari@gmail.com").
-compile(export_all).

main() -> { ok, [N]} = io:fread("", "~d"), printResult(0, triangle(N)).

printResult(_, []) -> ok;
printResult(0, [H|T]) -> printResult(H, T);
printResult(L, [H|T]) -> D = H - L, io:format("~p ", [D rem 1000000007]), printResult(D, T).

triangle(N) when N == 2 -> [1, 2];
triangle(N) when N == 3 -> [1, 4, 6];
triangle(N) -> genTriangle([1,4,6], 3, N).

genTriangle(T, NT, N) when NT == N -> T;
genTriangle(T, NT, N) -> T2 = calcTriangle(T, NT, 2, [1]), genTriangle(T2, NT + 1, N).

calcTriangle(T, NT, I, T2) when I > NT -> T2 ++ [lists:nth(I-1,T2) + lists:nth(I-1,T)];
calcTriangle(T, NT, I, T2) -> calcTriangle(T, NT, I + 1, T2 ++ [lists:nth(I, T) + (NT) * lists:nth(I - 1, T)]).

stirling() ->
  N = 10,
  First = (N) * (N-1),
  [First],
  {calc(6, 1), calc(6, 2), calc(6, 3), calc(6, 4), calc(6, 5)}.

stirlingFactorial(N) ->
  math:sqrt(2 * math:pi() * N) * math:pow(N/2.718281828, N).
  %%sqrt(2 π N).(N/e)Nsqrt(2 π N).(N/e)N

stirlingLogFactorial(N) ->
  (N + 0.5) * math:log(N) - N + math:log(2*math:pi())/2.


calc(NN, KK) when NN < KK -> 0;
calc(NN, KK) when NN > 0 andalso KK == 0 -> 0;
calc(NN, KK) when NN == KK -> 1;
calc(NN, KK) -> KK * calc(NN-1, KK) + calc(NN-1, KK-1).

%%
%%class Stirling {
%%  static int nextRecursion(int nn, int kk) {
%%if (nn < kk)            return 0;
%%if (nn >  0 && kk == 0) return 0;
%%if (nn == kk)           return 1;
%%return kk * Stirling.nextRecursion(nn-1, kk   ) +
%%Stirling.nextRecursion(nn-1, kk -1);
%%}
%%}
%%
%%

%%  for (int i = 2; i <= k; ++i) //i=2, not 1
%%for(int j = 1; j <= maxj; ++j)
%%arr[j] += i*arr[j-1];



f(N) -> fact(N,1).

fact(1,T) -> T;
fact(N,T) -> fact(N-1,N*T).
