! Historian class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory historian: (self new: 'historian').
    'This session is being recorded.' oo.
!!

"============================================"
! Historian methodsFor: 'creation' !
init
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
	(log includesKey: 'two') ifFalse:[log at: 'two' put:0].
	(log includesKey: 'three') ifFalse:[log at: 'three' put:0].
	(log includesKey: 'four') ifFalse:[log at: 'four' put:0].
	(log includesKey: 'five') ifFalse:[log at: 'five' put:0].
	(log includesKey: 'siz') ifFalse:[log at: 'six' put:0].
	(log includesKey: 'seven') ifFalse:[log at: 'seven' put:0].
	(log includesKey: 'eight') ifFalse:[log at: 'eight' put:0].
	(log includesKey: 'nine') ifFalse:[log at: 'nine' put:0].
	(log includesKey: 'ten') ifFalse:[log at: 'ten' put:0].

	senators:= The factory machines contents size.
	('There were a total of ',senators s,' senators attempting to pass bills today') oo.
	The factory machines contents do: [:machine |
		(machine party = 0) ifTrue:[dem:=dem+1] ifFalse:[rep:=rep+1].
	].
	('Of these, ',dem s,' were Democrats and ',rep s,' were Republicans') oo.
	('They passed a total of ',The oracle success s,' bills, resulting in an overall score of ',The oracle score s) oo.
	'' oo.
	'%Gathering Support, Presenting to Committee,Voting in Committee,Presenting to the Floor,Voting on the Floor,Committing a Scandal,Calling a Filibuster, Suspended for a Filibuster,Investigating a Colleague,Presenting to the President,Total Transitions,Overall Score' oo. 
	((log at:'one') s,',',(log at:'two') s,',',(log at:'three') s,',',(log at:'four') s,',',(log at:'five') s,',',(log at:'six') s,',',(log at:'seven') s,',',(log at:'eight') s,',',(log at:'nine') s,',',(log at:'ten') s,',',transitions s,',',The oracle score s) oo.
!
dominance
	|enemies support who|
	enemies:=0.
	support:=0.
	(The machine party = 0)
		ifTrue: [who:=1] ifFalse: [who:=0].

	The factory machines contents do: [:machine |
		(machine party = who)
			ifFalse:[
				support:=support+(machine billSupport).
				enemies:=enemies+1.].
	].

	support:= (support/enemies) asFloat.
	(support>0.85)
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
score: s
	score:=s
!
score
	^score
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
    ('Historian:[', id s, '] ', x s)o
!!
