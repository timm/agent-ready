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
ptable := Dictionary new.
runstable := Dictionary new.
runtemp := Dictionary new.
"======================init Learning part====================================="
10 timesRepeat:[
App reset; asynchronousOff.
s1 setLifeEvent: sle.
cs1 setEvent: ce1.
s1 take: cs1.
s1 worksIn: f1.
f1 flogger: flogger. 
flogger trans do: [:each|runtemp at: (each id) put: 0.].
"+++++++++++++++++++++++ Learning Part +++++++++++++++++++++++++++++++++"
f1 run.
ptable at: (runstable size) put: (f1 student happiness).
f1 machines contents do:
	 [:machine| machine transitions keysAndValuesDo:
		[:key :value|
		((value logger) counter) contents
		 keysAndValuesDo: [:key :value |
		(runtemp includesKey: (key id))
			ifTrue:[runtemp at:(key id) put: value.].
				].
		].
	 ].
runstable at: (runstable size) put: (runtemp values) asOrderedCollection.
f1 reload.
cs1 reload.
s1 reload.
].
flogger rest. 
flogger best.

flogger bestDic oo.
flogger bestDic do:[:item|
		'happiness is ' o.
		(item at:1) oo.
		(item at: 2) do: [:pitem|
		pitem contents keys do:[:key|
		(key id) o. 
		' ' o.
		].]
		. ' ' oo.].

flogger trans do: [:tran|(tran id) o. ' ' o.]. 
' ' oo.

runstable keysAndValuesDo: [:key :value|
	'runs: ' o. key o. ' ' o.
	value o.
	' with happiness '  o.	
	(ptable at: key )oo.
	].

patiencesorder := (ptable values asSortedCollection).
patiencesorder oo.

alpha := 0.2.
best := (alpha * (patiencesorder size)) floor.
best oo.
runsrowno := (ptable keyAtValue: (patiencesorder last)) oo.


!

