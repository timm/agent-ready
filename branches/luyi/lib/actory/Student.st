!Student class methodsFor: 'creation'!
new: name
	^(super new: name) init. 
!!
!Student methodsFor: 'creation'!
init
	courses   := Dictionary new.
	happiness := 100.
	lifeEvent := LifeEvent new: name.
	lifeEvent student: self.
	patience  := 100.
!
lookup: aString
	(courses includesKey: aString)
		ifTrue: [
			'this course already taken' oo.
			^true.
			]
		ifFalse:
			[
			'didnot learn this course before' oo.
			^false.
			].
			
!
worksIn: aFactory
	aFactory machine: self.
	self factory: aFactory.
	(courses size = 0)
		ifFalse:
		[ 0 to: ((courses size)-1) do:[:i|
			(courses at: i) worksIn: aFactory.]
		]
			
!
take: aCourse 
	(self lookup: (aCourse name))
	ifFalse:[
		courses at: (courses size) put: aCourse.
		aCourse assignStudent: self.
		self check: aCourse.	
		(self factory isNil)
			ifFalse: [aCourse worksIn: (self factory).]
		].
!
check: aCourse
	"if the course has prerequisite course, check if learned"
	|precourses|
	precourses := aCourse getPrerequisite.
	(precourses size = 0)
		ifFalse:[
			precourses keysDo: [:key |
			(self lookup: key)
			ifTrue:
				[happiness := happiness + 5. ]
			ifFalse:
				[happiness := happiness - 10.]
			]
		]
!
exam
	happiness := happiness - 5.
!
gradepublish: aNumber
	(aNumber > 70)
		ifTrue:
			[happiness := happiness + 10]
		ifFalse:
			[happiness := happiness - 5] 
!
football
	lifeEvent football.
!
lottory: aNumber
	lifeEvent lottory: aNumber.
!
happiness
	^happiness.
!
happiness: aNumber
	happiness := aNumber.
!
getLifeEvent
	^lifeEvent.
!
course 
	^courses.
!
patience 
	^patience.
!
setPatience: aPatience
	patience := aPatience. 
!!
