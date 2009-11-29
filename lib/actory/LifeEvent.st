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
	|index pstate ppstate statehash|
	index := 0.
	statehash := Dictionary new.
        ppstate := (ss1 RandState: 'Course') state.
        statehash at: 0 put: ppstate.
        [index < 10]
		whileTrue: [
			|startstate|
			startstate := statehash at: ((statehash size)-1).       
			pstate := (ss1 RandState: 'Course') state.
			statehash at:(statehash size)  put: pstate.

			    index := index + 1.
			    self generateTran: aGuard then: aSideEffect.  
			    ].
!!

"============================================="
!LifeEvent methodsFor: 'accessing'!
generateTran: guard then: sideEffect startstate: astartState endstate: aendState
	|newTransition |
	(ss1 states size >0)
		ifTrue: [
			((astartState name s) ~ 'Life')
			ifTrue: [
			transitions add: 
		 	(Transition new
				state: astartState;
			 	if: guard;
			 	then: sideEffect;
			 	next: aendState ).
			]]
		ifFalse: [^false.]
!
student: aStudent
	|pstate|
	pstate := ss1 RandState: 'Life'.
	[pstate ~ 'End']
		whileTrue: [pstate := ss1 RandState: 'Life'].
	student := aStudent.
	student add:           (Transition new
                                state: ((ss1 startState) state) ;
                                if: (guard Rand);
                                then: (sideEffect Rand);
                                next: pstate state ).

	1 to: (transitions size) do: [:i |
	student add: (transitions at: i).]
!
setStudentState: aStudentState
	ss1 := aStudentState.
!
transitions
	^transitions.
!
transitions: trans
	1 to: (trans size) do:[:i|
	transitions add: (trans at: i).]. 
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
