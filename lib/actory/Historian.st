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
	|senators|
	senators:= The factory machines contents size.
	('There were a total of ',senators s,' senators attempting to pass bills today') oo.
	('They passed a total of ',The oracle success s,' bills, resulting in an overall score of ',The oracle score s) oo.
	'' oo.
	'%Gathering Support, Presenting to Committee,Voting in Committee,Presenting to the Floor,Voting on the Floor,Committing a Scandal,Presenting to the President,Total Transitions,Overall Score' oo. 
	((log at:'one') s,',',(log at:'two') s,',',(log at:'three') s,',',(log at:'four') s,',',(log at:'five') s,',',(log at:'six') s,',',(log at:'seven') s,',',transitions s,',',The oracle score s) oo.
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
