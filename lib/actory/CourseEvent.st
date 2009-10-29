!CourseEvent class methodsFor: 'creation'!
new: aName
	
	^(super new) init: aName.
!!
"=============================================="
!CourseEvent methodsFor: 'creation'!
init: aName
	name := aName.
	patience := 100.
	ss1 := StudentState new.
	guard := Guard new.
	sideEffect := SideEffect new.
	guardSideEffect := GuardSideEffect new.
!!
"=============================================="
!CourseEvent methodsFor: 'timer'!
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
        [index < 50]
		whileTrue: [
			    index := index + 1.
			    self generateTran: aGuard then: aSideEffect.  
			    ].
!!

"============================================="
!CourseEvent methodsFor: 'accessing'!
generateTran: guard then: sideEffect
	|newTransition pstate|
	(ss1 states size >0)
		ifTrue: [
		(course isNil)
			ifFalse:[
			pstate := ss1 RandState.
			((pstate name s ) ~ 'Course')
			ifTrue: [ 
			course add: 
		 	(Transition new
				state: pstate;
			 	if: guard;
			 	then: sideEffect;
			 	next: ss1 RandState).
				^true.]]
			ifTrue: 
			[^false].
			]
		ifFalse: [^false.]
!
course: aCourse
	course := aCourse.
	(course isNil)
                ifFalse:[
                course add:
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
exam
	patience := (patience sqrt) rounded.
	course setPatience: patience.
	'take exam' oo.
	patience oo.
!
gradepublish: aGrade
	|grade|
       'getting grade:' o.
		aGrade oo.
	(aGrade >0)| (aGrade <80)
		ifTrue: [ patience := ((patience * ((aGrade/100) sqrt)) rounded)].
	(aGrade >80) |(aGrade <100)
		ifTrue: [ patience := ((patience * (aGrade/100) ) rounded)].
	course setPatience: patience.
	'grade published with patience: ' o.
	patience oo.
!
course 
 	^course.
!
talks: x
	('Machine:[', id s , ']', x s) o
!!
