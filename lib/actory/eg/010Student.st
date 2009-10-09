App reset; asynchronousOff.
s1 := Student new: 'luyi'.
sle :=s1 getLifeEvent. 
'get Guard Object' oo.
guardone := sle getGuard.
guardone add: [The machine patience >50].
guardone add: [The machine patience > 20].
guardone add: [The machine happiness >10].
sideEffect1 := sle getSideEffect.
sideEffect1 add: [The machine football].
sideEffect1 add: [The machine lottory: (((Random next)*100) rounded)].
sle run.
cs1 := Course new: 'cs556'.
ce1 := cs1 getSelfEvents.
ss := ce1 getStudentState.
ss add: #running.
ss add: #start.
guardtwo := ce1 getGuard.
guardtwo add: [The machine patience >20].
guardtwo add: [The machine patience >30].
sideEffect21 := ce1 getSideEffect.
sideEffect21 add: [The machine exam].
sideEffect21 add: [The machine gradepublish: (((Random next )*100) rounded)].
ce1 run.
f1 := Factory new: 'test'.
s1 worksIn: f1.
s1 take: cs1.
f1 run.
!
