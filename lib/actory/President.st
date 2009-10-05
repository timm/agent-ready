! President class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory oracle: (self new: 'president').
    'The president is on the floor.' oo.
!!

"============================================"
! President methodsFor: 'creation' !
init
    party := ((App random next)*2) rounded.
    success:=0.
!!

"============================================"
! President methodsFor: 'operations' !
polled: aPoller
	|openMindedness vote|
	openMindedness:=0.5.

	"Are they in the same political party?"
	(party=(aPoller party))
		ifTrue: [
			openMindedness := openMindedness + 0.33.]
		ifFalse: [
			openMindedness := openMindedness - 0.33.].

	"Trust factor"
	openMindedness := openMindedness + ((aPoller trust)*0.15).

	"Factor in current level of support"
	openMindedness := openMindedness + ((aPoller billSupport)*0.33).
	
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
	
	^((success/senators) asFloat)
!!
"============================================"
! President methodsFor: 'accessing'!
party
	^party
!
success: s
	success:=s.
!
success
	^success
!!
"============================================"
! President methodsFor: 'printing' !
talks: x
    ('President:[', id s, '] ', x s)o
!!
