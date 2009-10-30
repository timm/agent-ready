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
	archives:=Array new:1000.
	session:=1.
!
reset
	log:=Dictionary new.
	score :=0.
	transitions:=0.
!
learnReset
	log:=Dictionary new.
	score :=0.
	transitions:=0.
	archives:=Array new:1000.
	session:=1.
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
	|senators dem rep st output|
	dem:=0.
	rep:=0.
	
	App say: ('There were a total of ',senators s,' senators attempting to pass bills today').
	The factory machines contents do: [:machine |
		(machine party = 0) ifTrue:[dem:=dem+1] ifFalse:[rep:=rep+1].
	].
	App say: ('Of these, ',dem s,' were Democrats and ',rep s,' were Republicans').
	App say: ('They passed a total of ',(The oracle rsuccess+The oracle dsuccess) s,' bills.'). 
	App say: ('Democrats passed ',((The oracle score:0)*100) s,' percent of these, and Republicans passed ',
		((The oracle score:1)*100) s,' percent. This resulted in an overall score of ',The oracle score s).
	
	output:=('Session ',(session s),':').
	
	1 to: 28 do: [:x|
		st:=('s',(x s)).
		(log includesKey: st) ifTrue:[log at: st put: (self percentage: (log at: st))] ifFalse:[log at: st put:0].
		output:=(output,(log at: st) s,',').
	].
	output:=(output,transitions s,',',(The oracle score s)).
	output oo.

	log at: 'score' put: (The oracle score asFloat).
	log at: 'session' put: session.
	log at: 'transitions' put: transitions.
	archives at: session put: log.
	session:=session+1.
!
percentage: aNumber
	|percent|
	percent:= ((aNumber/transitions) asFloat*100) rounded.

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
!!
"============================================"
! Historian methodsFor: 'printing' !
talks: x
    App say: ('Historian:[', id s, '] ', x s).
!!
