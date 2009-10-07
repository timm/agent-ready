!Student class methodsFor: 'creation'!
new: name
	^super new: name init. 
!!
!Student methodsFor: 'creation'!
init
	courses   := Dictionary new.
	happiness := 100.
	lifeEvent := LifeEvent new: name.
	lifeEvent student: self.
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
take: aCourse 
	(self lookup: (aCourse name))
	ifFalse:[
		courses at: (courses size) put: aCourse.
		aCourse assignStudent: self.
		self check: aCourse.	
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
				[happiness := happiness - 5. ]
			ifFalse:
				[happiness := happiness - 10.]
			]
		]
!!
