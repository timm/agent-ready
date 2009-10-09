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
	timer := Delay forSeconds: (((Random next) ) rounded).
	index := 0.
        [(patience >0) & (index < 50)]
		whileTrue: [timer wait.
			    index := index + 1.
			    index oo.
			    self generateTran: aGuard then: aSideEffect.  
			    ].
!!

"============================================="
!LifeEvent methodsFor: 'accessing'!
generateTran: guard then: sideEffect
	|newTransition|
	(ss1 states size >0)
		ifTrue: [
		(student isNil)
			ifFalse:[
			student add: 
		 	(Transition new
				state: ss1 RandState;
			 	if: guard;
			 	then: sideEffect;
			 	next: ss1 RandState).
				^true.]
			ifTrue: 
			[^false].
			]
		ifFalse: [^false.]
!
student: aStudent
	student := aStudent.
	(student isNil)
                ifFalse:[
                student add:
                (Transition new
                                state: ss1 startState;
                                if: (guard Rand);
                                then: (sideEffect Rand);
                                next: ss1 RandState).].

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
!
football
	|phappiness|
	patience sqrt.
	phappiness := student happiness.
	student happiness: phappiness * 1.2.
!
lottory: aGrade
	|grade phappiness|
	phappiness := student happiness.
	(aGrade >0)| (aGrade <80)
		ifTrue: [
			phappiness := phappiness * (aGrade/100).
			patience := patience - 5.	
			student happiness: phappiness.
			].
		
	(aGrade >80) |(aGrade <100)
		ifTrue: [ 
			phappiness := phappiness * (2- aGrade/100).
			patience := patience - 15.
			student happiness: phappiness.
			].
!
student 
 	^student.
!
talks: x
	('Machine:[', id s , ']', x s) o
!!
