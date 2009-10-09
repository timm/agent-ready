App reset; asynchronousOff.
cs1 := Course new: 'testcourse'.
'get courseEvent' oo.
ce1 := cs1 getSelfEvents.
'inspect what lives in the courseevent' oo.
ce1 inspect.
'get Student state' oo.
ss := ce1 getStudentState.
ss add: #running.
ss add: #start.
ss inspect.
'get Guard Object' oo.
guardone := ce1 getGuard.
'add several guard into this object' oo.
guardone add: [The machine patience > 50].
guardone add: [The machine patience > 20].
guardone inspect.
'get SideEffect Object' oo.
sideEffect1 := ce1 getSideEffect.
'add several sideEffect into this object' oo.
sideEffect1 add: [The machine exam].
sideEffect1 add: [The machine gradepublish: (((Random next )*100) rounded)].
cs1 worksIn: The factory.
ce1 run

