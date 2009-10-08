App reset; asynchronousOff.
f1 := Factory new: 'courseFactory'.
cs1 := Course new: 'testcourse'.
'get courseEvent' oo.
ce1 := cs1 getSelfEvents.
'inspect what lives in the courseevent' oo.
ce1 inspect.
'get Student state' oo.
ss := ce1 getStudentState.
ss inspect.
'get Guard Object' oo.
guardone := ce1 getGuard.
'add several guard into this object' oo.
guardone add: [The machine patience > 50].
guardone add: [The machine patience > 20].
guardinspect.
'get SideEffect Object' oo.
sideEffect1 := ce1 getSideEffect.
'add several sideEffect into this object' oo.
sideEffect1 add: [patience := patience - 10].
sideEffect1 add: [patience := patience - 5].
sideEffect1 add: [self exam].
sideEffect1 add: [self gradepublish: (((Random next )*100) rounded)].
'run randomly' oo.
ce1 run.
cs1 inspect.
ce1 inspect.
cs1 walksIn: f1.
'test machine func' oo.
cs1 step.
'inspect factory' oo.
f1 inspect.
f1 reset.
f1 start.
!
