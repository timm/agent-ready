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
!!

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
	|senators dem rep|
	dem:=0.
	rep:=0.
	"Oh god, this code is a mess. I'll find a more efficient way of doing this later."
	(log includesKey: 's2') ifFalse:[log at: 's2' put:0].
	(log includesKey: 's3') ifFalse:[log at: 's3' put:0].
	(log includesKey: 's4') ifFalse:[log at: 's4' put:0].
	(log includesKey: 's6') ifFalse:[log at: 's6' put:0].
	(log includesKey: 's7') ifFalse:[log at: 's7' put:0].
	(log includesKey: 's8') ifFalse:[log at: 's8' put:0].
	(log includesKey: 's9') ifFalse:[log at: 's9' put:0].
	(log includesKey: 's10') ifFalse:[log at: 's10' put:0].
	(log includesKey: 's11') ifFalse:[log at: 's11' put:0].
	(log includesKey: 's12') ifFalse:[log at: 's12' put:0].
	(log includesKey: 's13') ifFalse:[log at: 's13' put:0].
	(log includesKey: 's14') ifFalse:[log at: 's14' put:0].
	(log includesKey: 's15') ifFalse:[log at: 's15' put:0].
	(log includesKey: 's16') ifFalse:[log at: 's16' put:0].
	(log includesKey: 's17') ifFalse:[log at: 's17' put:0].
	(log includesKey: 's18') ifFalse:[log at: 's18' put:0].
	(log includesKey: 's19') ifFalse:[log at: 's19' put:0].
	(log includesKey: 's20') ifFalse:[log at: 's20' put:0].
	(log includesKey: 's21') ifFalse:[log at: 's21' put:0].
	(log includesKey: 's22') ifFalse:[log at: 's22' put:0].
	(log includesKey: 's23') ifFalse:[log at: 's23' put:0].
	(log includesKey: 's24') ifFalse:[log at: 's24' put:0].
	(log includesKey: 's25') ifFalse:[log at: 's25' put:0].
	(log includesKey: 's26') ifFalse:[log at: 's26' put:0].
	(log includesKey: 's27') ifFalse:[log at: 's27' put:0].
	(log includesKey: 's28') ifFalse:[log at: 's28' put:0].
	(log includesKey: 's29') ifFalse:[log at: 's29' put:0].

	senators:= The factory machines contents size.
	App say: ('There were a total of ',senators s,' senators attempting to pass bills today').
	The factory machines contents do: [:machine |
		(machine party = 0) ifTrue:[dem:=dem+1] ifFalse:[rep:=rep+1].
	].
	App say: ('Of these, ',dem s,' were Democrats and ',rep s,' were Republicans').
	App say: ('They passed a total of ',(The oracle rsuccess+The oracle dsuccess) s,' bills.'). 
	App say: ('Democrats passed ',((The oracle score:0)*100) s,' percent of these, and Republicans passed ',
		((The oracle score:1)*100) s,' percent. This resulted in an overall score of ',The oracle score s).
	('Session',(session s),': ',(log at:'s1') s,',',(log at:'s2') s,',',(log at:'s3') s,',',(log at:'s4') s,
		',',(log at:'s6') s,',',(log at:'s7') s,',',(log at:'s8') s,
		',',(log at:'s9') s,',',(log at:'s12') s,',',(log at:'s10') s,',',(log at:'s11') s,
		',',(log at:'s12') s,',',(log at:'s13') s,',',(log at:'s14') s,',',(log at:'s15') s,
		',',(log at:'s16') s,',',(log at:'s17') s,',',(log at:'s18') s,',',(log at:'s19') s,
		',',(log at:'s20') s,',',(log at:'s21') s,',',(log at:'s22') s,',',(log at:'s23') s,
		',',(log at:'s24') s,',',(log at:'s25') s,',',(log at:'s26') s,',',(log at:'s27') s,
		',',(log at:'s28') s,',',(log at:'s29') s,
		',',transitions s,',',(The oracle score s)) oo.
	archives at: session put: log.
	session:=session+1.
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
