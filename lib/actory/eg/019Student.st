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
transDic := Dictionary new.
flogger trans do: [:each|transDic at: (each id) put: each.].
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

"==================running result matrix==================="
runstable keysAndValuesDo: [:key :value|
	|pvalue|
	'runs: ' o. key o. ' ' o.
	pvalue := value.
	(pvalue values ) asOrderedCollection o.
	' with happiness '  o.	
	(ptable at: key )oo.
	].

"==================frequency table ========================"
pfre := Dictionary new.
1 to: ((flogger trans) size) do:[:i|
	|id counts|
	id:= (flogger trans at: i) id.
	counts := 0.
	(runstable values) do: [:value|
	((value at: id ) = 0 )
		ifFalse: [counts := counts + 1].
	].
	pfre at: id put: counts.
	].
"==================best table ============================="
bestfre := Dictionary new.
itemno := 0.
flogger bestDic do:[:item|
		|itembag|
		itemno := itemno +1.
		itembag := Bag new.
		'happiness is ' o.
		(item at:1) oo.
		(item at: 2) do: [:pitem|
		pitem contents keys do:[:key|
		(transDic includesKey: (key id))
		ifTrue: [
		(key id) o. 
		itembag add: (key id).
		' ' o.
		].].].
		bestfre at: itemno put: (itembag asSortedCollection).
		' ' oo.].

bestfreDict := Dictionary new.
1 to: ((flogger trans) size) do:[:i|
        |id counts|
        id:= ((flogger trans) at: i) id. 
        counts := 0.
	bestfre values do: [:value|
	(value includes: id)
	ifTrue: [
		counts:= counts+1.
		].
	].
	bestfreDict at: id put: counts.
        ].  

"==========================rest frequency table ====================="
restfreDict := Dictionary new.

pfre keysAndValuesDo: [:key :value|
	restfreDict at: key put: ((pfre at: key)- (bestfreDict at:key))].

"========================b^2/b+r table =============================="

brvector := Dictionary new.
pfre keysAndValuesDo: [:key :value|
	|likeB likeR|
	likeB := ((bestfreDict at: key)/(flogger bestDic size)) * (1-alpha).
	likeR := ((restfreDict at: key)/(flogger restDic size)) * alpha.
	brvector at: key put: (likeB* likeB)/(likeB + likeR).
	((likeB = 0) & (likeR = 0))
	ifTrue: [brvector at: key put: 0]. ].
brvector oo.

biasedcourseTrans := OrderedCollection new.
biasedlifeTrans   := OrderedCollection new.
brvector keysAndValuesDo: [:key :value|
	|tran|
	(value > 0)
	ifTrue: [
	tran := (transDic at: key).
	((tran state name) ~ 'Course' )
		ifTrue: [ biasedcourseTrans add: tran.].
	((tran state name ) ~ 'Life' )
		ifTrue: [ biasedlifeTrans add: tran. ].
	].
	].
biasedcourseTrans oo.
biasedlifeTrans oo.
!
