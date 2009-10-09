App reset; asynchronousOff.
s1 := Student new: 'luyi'.
sle :=s1 getLifeEvent.
'get Guard Object' oo.
guardone := sle getGuard.
guardone add: [The machine patience >50].
guardone add: [The machine patience >100].
guardone add: [The machine patience >12].
guardone add: [The machine patience > 20].
guardone add: [The machine happiness >10].
sideEffect1 := sle getSideEffect.
sideEffect1 add: [The machine football].
sideEffect1 add: [The machine lottory: (((Random next)*100) rounded).].
sle inspect.
sle run.
f1 := Factory new: 'testFactory'.
s1 worksIn: f1.
f1 run.
