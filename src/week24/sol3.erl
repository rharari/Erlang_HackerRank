-module(sol3).
-author("ricardo.harari@gmail.com").

-export([main/0]).
-define(White, 0).
-define(Black, 1).
-define(Left, -1).
-define(Right, 1).
-define(Up, 1).
-define(Down, -1).

main() ->
  {ok, [G]} = io:fread("", "~d"),
  go(G).

go(0) -> {ok};
go(G) ->
  {ok, [W,B,M]} = io:fread("", "~d~d~d"),
  B1 = readBoard(?White, W, []),
  Board = {1, M, ?White, readBoard(?Black, B, B1)},
  Boards = queue:in(Board, queue:new()),
  startGame(Boards),
  go(G-1).

startGame(Queue) ->
  case queue:peek(Queue) of
    empty -> io:format("NO~n");
    {value, Item} ->
        try
          Q2 = process(Item),
          case queue:len(Queue) > 0 of
            true -> startGame(queue:join(queue:tail(Queue), Q2));
            false -> startGame(queue:join(Queue, Q2))
          end
        catch
          _:_ -> io:format("YES~n")
        end
  end.

process({CurrentMatch, M, Player, _}) when Player == ?Black andalso CurrentMatch == M -> queue:new();
process({CurrentMatch, M, Player, Board}) ->
  NQ = queue:to_list(scan(Player, Board, Board, queue:new(), CurrentMatch < M)),
  genQueue(nxtPlayer(Player), CurrentMatch + 1, M, NQ, queue:new()).

genQueue(_, _, _, [], Q) -> Q;
genQueue(Player, Match, M, [H|T], Q) ->
  genQueue(Player, Match, M, T, queue:in({Match, M, Player, H}, Q)).

nxtPlayer(0) -> 1;
nxtPlayer(1) -> 0.

scan( _, [], _, Queue, _) -> Queue;
scan( CurrentPlayer, [{ {_, _}, _, Player}|T], Board, Queue, Add) when CurrentPlayer =/= Player ->
  scan(CurrentPlayer, T, Board, Queue, Add);
scan(CurrentPlayer, [H|T], Board, Queue, Add) ->
  {{Row, Col}, Piece, Player} = H,
  NQ = processMvmt(Row, Col, Piece, Player, lists:delete(H, Board)),
  case Add of
    true -> scan(CurrentPlayer, T, Board, queue:join(Queue, NQ), Add);
    false -> scan(CurrentPlayer, T, Board, Queue, Add)
  end.

processMvmt(Row, Col, "Q", Player, Board) ->
  Q2 = mvmntHV(?Left, 0, Row - 1, Col, "Q", Player, Board, mvmntHV(?Right, 0, Row + 1, Col, "Q", Player, Board, queue:new())),
  Q4 = mvmntHV(0, ?Down, Row, Col - 1, "Q", Player, Board, mvmntHV(0, ?Up, Row, Col + 1, "Q", Player, Board, Q2)),
  Q6 = mvmntHV(?Left, ?Down, Row - 1, Col - 1, "Q", Player, Board, mvmntHV(?Right, ?Down, Row + 1, Col - 1, "Q", Player, Board, Q4)),
  mvmntHV(?Left, ?Up, Row - 1, Col + 1, "Q", Player, Board, mvmntHV(?Right, ?Up, Row + 1, Col + 1, "Q", Player, Board, Q6));

processMvmt(Row, Col, "B", Player, Board) ->
  Q6 = mvmntHV(?Left, ?Down, Row - 1, Col - 1, "B", Player, Board, mvmntHV(?Right, ?Down, Row + 1, Col - 1, "B", Player, Board, queue:new())),
  mvmntHV(?Left, ?Up, Row - 1, Col + 1, "B", Player, Board, mvmntHV(?Right, ?Up, Row + 1, Col + 1, "B", Player, Board, Q6));

processMvmt(Row, Col, "R", Player, Board) ->
  Q2 = mvmntHV(?Left, 0, Row - 1, Col, "R", Player, Board, mvmntHV(?Right, 0, Row + 1, Col, "R", Player, Board, queue:new())),
  mvmntHV(0, ?Down, Row, Col - 1, "R", Player, Board, mvmntHV(0, ?Up, Row, Col + 1, "R", Player, Board, Q2));

processMvmt(Row, Col, "N", Player, Board) ->
  Q2 = mvmnt1(Row + 1, Col + 2, "N", Player, Board, mvmnt1(Row + 1, Col - 2, "N", Player, Board, queue:new())),
  Q4 = mvmnt1(Row + 2, Col + 1, "N", Player, Board, mvmnt1(Row + 2, Col - 1, "N", Player, Board, Q2)),
  Q6 = mvmnt1(Row - 1, Col + 2, "N", Player, Board, mvmnt1(Row - 1, Col - 2, "N", Player, Board, Q4)),
  mvmnt1(Row - 2, Col + 1, "N", Player, Board, mvmnt1(Row - 2, Col - 1, "N", Player, Board, Q6)).

mvmnt1(R, C, _, _, _, Queue) when R > 4 orelse R < 1 orelse C > 4 orelse C < 1 -> Queue;
mvmnt1(R, C, P, Player, Board, Queue) ->
  case lists:keyfind({R, C}, 1, Queue) of
    false -> queue:in(Board ++ [{{R, C}, P, Player}], Queue);
    {{_,_}, Pn, P2} -> checkResult(P2, Player, Queue, Pn, Board, R, C, P)
  end.

mvmntHV(_, _, R, C, _, _, _, Queue) when R > 4 orelse R < 1 orelse C > 4 orelse C < 1 -> Queue;
mvmntHV(DirH, DirV, R, C, P, Player, Board, Queue) ->
  case lists:keyfind({R, C}, 1, Queue) of
    false -> mvmntHV(DirH, DirV, R + DirH, C + DirV, P, Player, Board, queue:in(Board ++ [{{R, C}, P, Player}], Queue) );
    {{_,_}, Pn, P2} -> checkResult(P2, Player, Queue, Pn, Board, R, C, P)
  end.

checkResult(P2, Player, Queue, Pn, Board, R, C, P) ->
  case P2 == Player of
    true -> Queue;
    false ->
      case checkCheckMate(Pn, P2) of
        {ok} -> queue:in(Board ++ [{{R, C}, P, Player}], Queue);
        {error} -> Queue
      end
  end.

checkCheckMate("Q", ?Black) -> throw("ok");
checkCheckMate("Q", ?White) -> {error};
checkCheckMate(_, _) -> {ok}.

readBoard(_, 0, Board) -> Board;
readBoard(Player, C, Board) ->  {ok, [Piece, Row, Col]} = io:fread("", "~s~s~d"),
                                readBoard(Player, C -1, Board ++ formatReg(Piece, Player, Row, Col)).

formatReg(Piece, Player, "A", Col) -> [{ {1, Col}, Piece, Player}];
formatReg(Piece, Player, "B", Col) -> [{ {2, Col}, Piece, Player}];
formatReg(Piece, Player, "C", Col) -> [{ {3, Col}, Piece, Player}];
formatReg(Piece, Player, "D", Col) -> [{ {4, Col}, Piece, Player}].