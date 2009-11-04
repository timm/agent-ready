App reset; asynchronousOff.

"========================Creating Life Event ================="
sle := LifeEvent new: 'luyilifeevent'.
guardone := sle getGuard.
guardone add: [The machine patience >50].
guardone add: [The machine patience > 20].
guardone add: [The machine happiness >10].
sideEffect1 := sle getSideEffect.
sideEffect1 add: [The machine football].
sideEffect1 add: [The machine lottory: (((Random next)*100) rounded)].
ss1 := sle getStudentState.
ss1 add: #running.
ss1 add: #start.

sle run.

"======================Creating Course Event =================="
ce1 := CourseEvent new: 'cs556Event'.
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

"======================Creating Student, Course, and Factory ============"
cs1 := Course new: 'cs556'.
s1  := Student new: 'luyi'.
f1 := Factory new: 'test'.
flogger := FactoryLogger new.
flogger settrans: (sle transitions).
flogger settrans: (ce1 transitions).

"======================init Learning part====================================="
100 timesRepeat:[
App reset; asynchronousOff.
s1 setLifeEvent: sle.
cs1 setEvent: ce1.

s1 take: cs1.
s1 worksIn: f1.
f1 flogger: flogger. 
' check all transitions in factory ' oo.
f1 machines contents do: [:machine| machine ptrans do:[:tran|tran id o. ' ' o.].].

"+++++++++++++++++++++++ Learning Part +++++++++++++++++++++++++++++++++"
f1 run.
f1 reload.
cs1 reload.
s1 reload.
].
flogger logger inspect.
flogger rest. 
flogger best.
flogger restDic inspect.
flogger bestDic inspect.

ptable := Dictionary new.

'total transitions: ' s oo.

flogger trans do: [:each| each id o. ' ' o. ptable at: (each id) put: 0.].
' ' oo.
ptable oo.
'fire transitions: ' s oo. 
" values is an value, each is an orderedcollection, peach  is a bag, paeach is transition "

flogger logger values do: [:each| each do:[:peach|peach do: [:paeach|
	 paeach id o.
	 ' ' o.
	(ptable includesKey: (paeach id))	
	 ifTrue: [ptable at: (paeach id) put: ((ptable at:(paeach id))+1).].
	 ].]. ' ' oo].
ptable o.
!
