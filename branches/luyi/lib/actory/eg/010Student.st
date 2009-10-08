App reset; asynchronousOff.
s1 := Student new: 'luyi'.
sle :=s1 getLifeEvent. 
'get Guard Object' oo.
guardone := sle getGuard.
guardone add: [The machine patience >50].
guardone add: [The machine patience >100].
guardone add: [The machine patience >12].
sideEffect1 := sle getSideEffect.
sideEffect1 add: [The machine football].
sideEffect1 add: [The machine lottory: (((Random next)*100) rounded)].
sle inspect.
s1 take: (Course new: 'cs556').
s1 inspect.
f1 := Factory new: 'test'.
s1 worksIn: f1.
f1 run.
!
