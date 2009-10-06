!CourseEvent class methodsFor: 'creation'!
new: name
	
	^(super new) init: name.
!!
"=============================================="
!CourseEvent methodsFor: 'creation'!
init: aString 
	name := aString.
	Patience := 100.
	ss1 := StudentState new.
	guard := Guard new.
	sideEffect := SideEffect new.
	self run.	
!!
"=============================================="
!CourseEvent methodsFor: 'timer'!
run
	self run: (guard rand) effect: (sideEffect rand).
!
run: aGuard effect: aSideEffect
	|timer index|
	timer := Delay forSecond: ((Random new) next) * 5.
	index := 0.
        [(self course) patience >0]
		whileTrue: [timer wait.
			    index := index + 1.
			    self generateTran: aGuard then: aSideEffect.  
			    ].
!!

"============================================="
!CourseEvent methodsFor: 'accessing'!
generateTran: guard then: sideEffect
	|newTransition|
	(ss1 states size >0)
		ifTrue: [
		newTransition := 
		 (Transition new
			 state: ss1 RandState;
			 if: guard;
			 then: sideEffect;
			 next: ss1 RandState)
			]
	course add: newTransition.
!
course: aCourse
	course := aCourse.
!
course 
 	^course.
!
talks: x
	('Machine:[', id s , ']', x s) o
!!
