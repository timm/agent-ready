!CourseFactory class methodsFor: 'creation'!
new 
	self error: 'should not create Factories without nameStrings'
!
new: nameString
	^super new: nameString
!!

"========================================"
"course already taken can be looked up"
!
lookup: aString
	self machines contents do: [:machine|
		(aString == (machine name))
			ifTrue:  [^true]
			ifFalse: [^false]
!!
 
