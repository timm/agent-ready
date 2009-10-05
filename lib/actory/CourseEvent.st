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
	self run.	
!!
"=============================================="
!CourseEvent methodsFor: 'timer'!
run
	|timer index|
	timer := Delay forSecond: ((Random new) next) * 5.
	index := 0.
        (Patience >0)
		whileTrue: [timer wait.
			    index := index + 1.
			    generateTran: Guard Rand then: [The machine talk: index] .
			    ]
		
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
	The machine add newTransition.
!
talks: x
	('Machine:[', id s , ']', x s) o
!!
