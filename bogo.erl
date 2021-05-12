-module(bogo).
-import(lists, [nth/2]).
-import(rand, [uniform/0]).
-export([bogo/1, start/0]).

head([]) -> [];
head([H | _]) -> H.

tail([]) -> [];
tail([_ | T]) -> T.

issorted([]) -> true;
issorted([_ | T]) when T == [] -> true;
issorted([H | T]) ->
  case (H =< head(T)) of
    true -> issorted(T);
    false -> false
  end.

setnth(1, [_|T], New) -> [New|T];
setnth(I, [H|T], New) -> [H|setnth(I-1, T, New)].

swap([], _, _) -> [];
swap(List, I, J) ->
  StepBeforeRetval = setnth(J, List, nth(I, List)),
  setnth(I, StepBeforeRetval, nth(J, List)).

btwnOneAndX(X) ->
  ceil(uniform()*X).

shuffle_recur(List, 0) ->
  List;
shuffle_recur(List, I) ->
  shuffle_recur(swap(List, btwnOneAndX(length(List)), btwnOneAndX(length(List))), I-1).

shuffle([]) ->
  [];
shuffle(List) ->
  shuffle_recur(List, length(List)).

bogo(List) ->
  case (issorted(List)) of
    true -> List;
    false -> bogo(shuffle(List))
  end.

start() ->
  bogo([1]).
