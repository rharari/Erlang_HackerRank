%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% The grid search
%%% @end
%%% https://www.hackerrank.com/challenges/the-grid-search
%%%-------------------------------------------------------------------
-module(e3b).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  X1 = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [Ts|Z] = X1,
  start(binary_to_integer(Ts), Z).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.

start(0, _) -> true;
start(T, [Rs, Cs|Z]) ->
     {S,Z1} = readMatrix(binary_to_integer(Rs), Z, ""),
     Z2 = goFind(S, binary_to_integer(Cs), Z1),
     start(T - 1, Z2).

goFind(S, C0, [Rs,Cs|Z]) ->
  {[K1|Keys], Z1} = readKeys(binary_to_integer(Rs), Z, []),
  case re:run(S, K1, [global]) of
    nomatch -> io:format("NO~n");
    {match, [Idx]} -> io:format("~s~n", [findIdx(S, Idx, Keys, C0 + 1, binary_to_integer(Cs))]),
  end,

  %io:format("~s~n", [find(S, Keys, C0 + 1, binary_to_integer(Cs))]),
  Z1.

findIdx(S, [], Keys, C0, C1) -> "YES";
findIdx(S, [H|T], Keys, C0, C1) ->
  {S0, _} = H,
  findSubstring(S, S0, Keys, C0, C1);

  [H|T] = Keys,
  Idx = string:str(S, H),
  case Idx of
    0 -> "NO";
    _ ->
      case findTokens(string:sub_string(S, Idx + C0), T, C0) of
        true -> "YES";
        false -> find(string:sub_string(S, Idx + 1), Keys, C0, C1)
      end
  end.

findSubstring(S, S0, [H|T], C0, C1) ->


findTokens(S, [H|T], C0) ->
  case string:str(S, H) of
    1 ->
      case T == [] of
        true -> true;
        false -> findTokens(string:sub_string(S, C0 + 1), T, C0)
      end;
    _ -> false
  end.

goFind_Old(S, C0, [Rs,Cs|Z]) ->
    {Keys, Z1} = readKeys(binary_to_integer(Rs), Z, []),
    io:format("~s~n", [find(S, Keys, C0 + 1, binary_to_integer(Cs))]),
    Z1.

readKeys(0, T, Acc) -> {Acc, T};
readKeys(R, [H|T], Acc) -> readKeys(R - 1, T, Acc ++ [binary_to_list(H)]).

readMatrix(0, T, Acc) -> {Acc, T};
readMatrix(R, [H|T], Acc) -> readMatrix(R - 1, T, Acc ++ binary_to_list(H) ++ "*").

find(S, Keys, C0, C1) ->
    [H|T] = Keys,
    Idx = string:str(S, H),
    case Idx of
      0 -> "NO";
      _ ->
        case findTokens(string:sub_string(S, Idx + C0), T, C0) of
          true -> "YES";
          false -> find(string:sub_string(S, Idx + 1), Keys, C0, C1)
        end
    end.

findTokens(S, [H|T], C0) ->
    case string:str(S, H) of
      1 ->
        case T == [] of
          true -> true;
          false -> findTokens(string:sub_string(S, C0 + 1), T, C0)
        end;
      _ -> false
    end.
