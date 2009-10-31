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
	|index|
	index := 0.
        [index < 5]
		whileTrue: [
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
