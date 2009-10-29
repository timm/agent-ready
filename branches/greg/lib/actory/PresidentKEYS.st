! PresidentKEYS class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory oracle: (self new: 'president').
    App say: 'The president is on the floor.'.
    'Oracle type: KEYS' oo.
!!

"============================================"
! PresidentKEYS methodsFor: 'creation' !
init
	(App random next > 0.5) ifTrue:[party:=0] ifFalse:[party:=1].
    	dsuccess:=0.
	rsuccess:=0.
!
reset
	dsuccess:=0.
	rsuccess:=0.
!!

"============================================"
! PresidentKEYS methodsFor: 'operations' !
learn
	|sessions archives clog ctransitions|
	sessions:= The historian session.

	1 to: sessions-1 do: [:c|
		clog:=The historian archives at:c.
		ctransitions:=clog at:'transitions'.
		('Session ', (c s),': ',(ctransitions s)) oo. 
	].
!
polled: aPoller
	|openMindedness vote|
	openMindedness:=0.75.

	"Are they in the same political party?"
	(party=(aPoller party))
		ifTrue: [
			openMindedness := openMindedness sqrt]
		ifFalse: [
			openMindedness := openMindedness raisedTo:2].
	"Trust factor"
	openMindedness := openMindedness raisedTo:(0.75+(1-aPoller trust)).

	"Factor in current level of support"
	openMindedness := openMindedness raisedTo:(0.75+(1-aPoller billSupport)). 
	
	(App random next < openMindedness)
		ifTrue: [
			self talks:'says yes'.
			vote:=true.]
		ifFalse: [
			self talks:'says no'.
			vote:=false.].
	^vote.

!
score
	|senators|
	senators:= The factory machines contents size.
	
	^((dsuccess+rsuccess)/senators) asFloat
!
score: mode
	(mode=0)
		ifTrue:[^(dsuccess/(rsuccess+dsuccess)) asFloat]
		ifFalse:[^(rsuccess/(rsuccess+dsuccess)) asFloat].
!!
"============================================"
! PresidentKEYS methodsFor: 'accessing'!
party
	^party
!
dsuccess: s
	dsuccess:=s.
!
dsuccess
	^dsuccess
!
rsuccess: s
	rsuccess:=s.
!
rsuccess
	^rsuccess
!!
"============================================"
! PresidentKEYS methodsFor: 'printing' !
talks: x
    App say: ('President:[', id s, '] ', x s).
!!
