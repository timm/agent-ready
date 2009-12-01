! Historian class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory historian: (self new: 'historian').
    App say: 'This session is being recorded.'.
!!

"============================================"
! Historian methodsFor: 'creation' !
init
	log:=Dictionary new.
	score :=0.
	transitions:=0.
	archives:=Array new:10000.
	session:=1.
	subtotals:=Dictionary new.
!
reset
	log:=Dictionary new.
	score :=0.
	transitions:=0.
	subtotals:=Dictionary new.
!
learnReset
	log:=Dictionary new.
	score :=0.
	transitions:=0.
	archives:=Array new:10000.
	session:=1.
	subtotals:=Dictionary new.
!

"============================================"
! Historian methodsFor: 'operations' !
record: what
	(log includesKey: what)
		ifTrue:[log at:what put:((log at:what)+1)]
		ifFalse:[log at: what put:1].

	transitions:=transitions+1.
!
replace: newLog
	log:=newLog
!
report
	|senators dem rep st output temp|
	dem:=0.
	rep:=0.
	subtotals at:'1' put:100.
	subtotals at:'2' put:100.
	temp:=0.
	3 to:13 do:[:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[temp:=temp+(log at:st)].
	].
	subtotals at:'3' put:temp.
	temp:=0.
	14 to:24 do:[:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[temp:=temp+(log at:st)].
	].
	subtotals at:'4' put:temp.
	temp:=0.
	25 to:35 do:[:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[temp:=temp+(log at:st)].
	].
	subtotals at:'5' put:temp.
	temp:=0.
	36 to:42 do:[:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[temp:=temp+(log at:st)].
	].
	subtotals at:'6' put:temp.
	temp:=0.
	43 to:51 do:[:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[temp:=temp+(log at:st)].
	].
	subtotals at:'7' put:temp.
	temp:=0.
	52 to:58 do:[:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[temp:=temp+(log at:st)].
	].
	subtotals at:'8' put:temp.
	temp:=0.
	59 to:67 do:[:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[temp:=temp+(log at:st)].
	].
	subtotals at:'9' put:temp.
	temp:=0.
	68 to:76 do:[:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[temp:=temp+(log at:st)].
	].
	subtotals at:'10' put:temp.

	App say: ('There were a total of ',senators s,' senators attempting to pass bills today').
	The factory machines contents do: [:machine |
		(machine party = 0) ifTrue:[dem:=dem+1] ifFalse:[rep:=rep+1].
	].
	App say: ('Of these, ',dem s,' were Democrats and ',rep s,' were Republicans').
	App say: ('They passed a total of ',(The oracle rsuccess+The oracle dsuccess) s,' bills.'). 
	App say: ('Democrats passed ',((The oracle score:0)*100) s,' percent of these, and Republicans passed ',
		((The oracle score:1)*100) s,' percent. This resulted in an overall score of ',The oracle scoreSupport s).
	
	output:=('Session ',(session s),':').
	
	1 to: 76 do: [:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[log at: st put: (self percentage: (log at: st) with:x)] ifFalse:[log at: st put:0].
		output:=(output,(log at: st) s,',').
	].
	output:=(output,transitions s,',',(((The oracle score*100) rounded) s),',',(The oracle scoreSupport s)).
	output oo.

	log at: 'score' put: (The oracle scoreSupport asFloat).
	log at: 'session' put: session.
	log at: 'transitions' put: transitions.
	archives at: session put: log.
	session:=session+1.
!
reportStats
	|scores mean std log temp|
	scores:= SortedCollection new.
	mean:= 0.
	std:=0.

	1 to: session-1 do:[:x|
		log:=self archives at:x.
		scores add: (log at:'score') asFloat.
	].

	('Median = ',(scores at: 10) s) oo. 
	scores do:[:x|
		mean:= mean+x.
	].
	
	mean:=(mean/scores size) asFloat.
	('Mean = ',mean s) oo.

	scores do:[:x|
		temp:= (x-mean) asFloat.
		temp:=(temp abs) raisedTo:2.
		std:=std+temp.		
	].

	std:=(std/scores size) asFloat.
	std:= std raisedTo:0.5.
	('Std.Dev= ',std s) oo.
!
percentage: aNumber with: aState
	|percent subt|
	(aState<14) ifTrue:[subt:=(subtotals at:'3')]
		ifFalse:[(aState<25) ifTrue:[subt:=(subtotals at:'4')]
			ifFalse:[(aState<36) ifTrue:[subt:=(subtotals at:'5')]
				ifFalse:[(aState<43) ifTrue:[subt:=(subtotals at:'6')]
					ifFalse:[(aState<52) ifTrue:[subt:=(subtotals at:'7')]
						ifFalse:[(aState<59) ifTrue:[subt:=(subtotals at:'8')]
							ifFalse:[(aState<68) ifTrue:[subt:=(subtotals at:'9')]
								ifFalse:[subt:=(subtotals at:'10')].].].].].].].
	percent:= ((aNumber/subt) asFloat*100) rounded.

	(aState=1 or:[aState=2]) ifTrue:[percent:=100].

	^percent
!
dominance
	|who|
	(The machine party = 0)
		ifTrue: [who:=1] ifFalse: [who:=0].

	(The oracle dsuccess = 0 or:[The oracle rsuccess = 0])
		ifTrue:[^false].
	
	((The oracle score:who) > 0.75)
		ifTrue:[The factory suspended: true.
			The factory suspendee: The machine party.
			^true]
		ifFalse:[^false].
!
reportBiases
	The factory biases associationsDo:[:entry|
		('[',(entry key) s,',',(entry value) s,']') oo.
	].
!!

"============================================"
! Historian methodsFor: 'accessing'!
log
	^log
!
archives
	^archives
!
score: s
	score:=s
!
score
	^score
!
session: s
	session:=s.
!
session
	^session
!
transitions
	^transitions
!
transitions: t
	transitions:=t.
!
subtotals:s
	subtotals:=s.
!
subtotals
	^subtotals
!!
"============================================"
! Historian methodsFor: 'printing' !
talks: x
    App say: ('Historian:[', id s, '] ', x s).
!!
