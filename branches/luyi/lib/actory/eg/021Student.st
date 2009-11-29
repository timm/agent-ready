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
learner := Learning new: flogger.
ptable := learner ptable.
runstable := learner runstable.
runtemp := Dictionary new.
learner constransdic.
transDic := learner transDic.
"======================init Learning part====================================="
100 timesRepeat:[
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
			ifTrue:[runtemp at:(key id) put: ((runtemp at: (key id)) + value).].
				].
		].
	 ].
runstable at: (runstable size) put: (Dictionary from: (runtemp associations)) . 
f1 reload.
cs1 reload.
s1 reload.
].

"========================mining part ======================"
alpha := 0.8.
flogger rest. 
flogger best.
learner resultmatrix.
(learner average) oo.
learner findbestTrans.
learner biasedcourseTrans oo.
learner biasedlifeTrans oo.

sle transitions: (learner biasedlifeTrans).
ce1 transitions: (learner biasedcourseTrans).

flogger2 := FactoryLogger new.
flogger2 settrans: (sle transitions).
flogger2 settrans: (ce1 transitions).
learner2 := Learning new: flogger2.
biasedptable := learner2 ptable.
biasedruntemp := Dictionary new.
biasedrunstable := learner2 runstable.
learner2 constransdic.
transDic := learner2 transDic.
100 timesRepeat:[
App reset; asynchronousOff.
s1 setLifeEvent: sle.
cs1 setEvent: ce1.
s1 take: cs1.
s1 worksIn: f1.
f1 flogger: flogger2. 
flogger2 trans do: [:each|biasedruntemp at: (each id) put: 0.].
f1 run.
biasedptable at: (biasedrunstable size) put: (f1 student happiness).
f1 machines contents do:
         [:machine| machine transitions keysAndValuesDo:
                [:key :value|
                ((value logger) counter) contents
                 keysAndValuesDo: [:key :value |
                (biasedruntemp includesKey: (key id))
                        ifTrue:[biasedruntemp at:(key id) put: ((biasedruntemp at: (key id)) + value).].
                                ].
                ].
         ].
biasedrunstable at: (biasedrunstable size) put: (Dictionary from: (biasedruntemp associations)) . 
f1 reload.
cs1 reload.
s1 reload.
].


flogger2 rest.
flogger2 best.
learner2 resultmatrix.
(learner2 average) oo.
learner2 findbestTrans.
learner2 biasedcourseTrans oo.
learner2 biasedlifeTrans oo.
learner resultmatrix.
(learner average) oo.
learner2 resultmatrix.
(learner2 average) oo.
!
