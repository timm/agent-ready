!LifeEvent class methodsFor: 'creation'!
new: name
	
	^(super new: name) init.
!!
"=============================================="
!LifeEvent methodsFor: 'creation'!
init 
	patience := 100.
	ss1 := StudentState new.
	guard := Guard new.
	sideEffect := SideEffect new.
	guardSideEffect := GuardSideEffect new.
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
	|timer index|
	timer := Delay forSeconds: (((Random next) * 5) rounded).
	index := 0.
        [(patience >0) & (index < 1)]
		whileTrue: [timer wait.
			    index := index + 1.
			    self generateTran: aGuard then: aSideEffect.  
			    ].
!!

"============================================="
!LifeEvent methodsFor: 'accessing'!
generateTran: guard then: sideEffect
	|newTransition|
	(ss1 states size >0)
		ifTrue: [
		student add: 
		 (Transition new
			 state: ss1 RandState;
			 if: guard;
			 then: sideEffect;
			 next: ss1 RandState).
			]
		ifFalse: [^false.]
!
student: aStudent
	student := aStudent.
!
setStudentState: aStudentState
	ss1 := aStudentState.
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
exam
	patience sqrt.
!
gradepublish: aGrade
	|grade|
	(aGrade >0)| (aGrade <80)
		ifTrue: [ patience := patience * (aGrade/100)].
	(aGrade >80) |(aGrade <100)
		ifTrue: [ patience := patience * (2- aGrade/100)].
!
student 	
	^student.
!
talks: x
	('Machine:[', id s , ']', x s) o
!!
