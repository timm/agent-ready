!LifeEvent class methodsFor: 'creation'!
new: aName
	
	^(super new) init: aName.
!!
"=============================================="
!LifeEvent methodsFor: 'creation'!
init: aName
	name := aName.
	patience := 100.
	ss1 := StudentState new.
	guard := Guard new.
	sideEffect := SideEffect new.
	guardSideEffect := GuardSideEffect new.
	transitions := OrderedCollection new.
!!
"=============================================="
!LifeEvent methodsFor: 'timer'!
run
	self run: (guard Rand) effect: (sideEffect Rand).
!
run: aGuardSideEffect
	|pGuardSide pGuard pSide|
	pGuardSide := guardSideEffect Rand.
	pGuard := pGuardSide at:1.
	pSide  := pGuardSide at:2.
 	self run: pGuard effect: pSide. 
!
run: aGuard effect: aSideEffect
	|index|
	index := 0.
        [index < 10]
		whileTrue: [
			    index := index + 1.
			    self generateTran: aGuard then: aSideEffect.  
			    ].
!!

"============================================="
!LifeEvent methodsFor: 'accessing'!
generateTran: guard then: sideEffect
	|newTransition pstate|
	(ss1 states size >0)
		ifTrue: [
			pstate := ss1 RandState.
			((pstate name s) ~ 'Life')
			ifTrue: [
			transitions add: 
		 	(Transition new
				state: pstate;
			 	if: guard;
			 	then: sideEffect;
			 	next: ss1 RandState).
			]]
		ifFalse: [^false.]
!
student: aStudent
	student := aStudent.
	student add:           (Transition new
                                state: ss1 startState;
                                if: (guard Rand);
                                then: (sideEffect Rand);
                                next: ss1 RandState).

	1 to: (transitions size) do: [:i |
	student add: (transitions at: i).]
!
setStudentState: aStudentState
	ss1 := aStudentState.
!
transitions
	^transitions.
!
setGuard: aGuard
	guard := aGuard.
! 
setSideEffect: aSideEffect
	sideEffect := aSideEffect.
!
setGuardSideEffect: aGuardSideEffect
	guardSideEffect := aGuardSideEffect.
!
getStudentState
	^ss1
!
getGuard
	^guard.
!
getSideEffect
	^sideEffect.
!
getGuardSideEffect
	^guardSideEffect.
!
patience
	^patience.
!
setPatience: aPatience
	patience := aPatience.
!
football
	|phappiness|
	'watch football hahahaha' oo.
 	patience := (patience sqrt) rounded.
	student setPatience: patience.
	student patience oo.
	phappiness := student happiness.
	student happiness: (phappiness * 1.2) rounded.
	'student happiness changes to ' o.
	student happiness oo.
!
lottory: aGrade
	|grade phappiness|
	phappiness := student happiness.
	(aGrade >0)| (aGrade <80)
		ifTrue: [
			'lose lottory ' o.
			phappiness := (phappiness * (aGrade/100)) rounded.
			patience := patience - 5.
			patience oo.	
			student happiness: phappiness.
			student setPatience: patience.
			].
		
	(aGrade >80) |(aGrade <100)
		ifTrue: [ 
			'win lottory' o.	
			phappiness := (phappiness * ((aGrade/100) sqrt)) rounded.
			patience := patience - 15.
			patience oo.
			student happiness: phappiness.
			student setPatience: patience.
			].
!
student 
 	^student.
!
talks: x
	('Machine:[', id s , ']', x s) o
!!
