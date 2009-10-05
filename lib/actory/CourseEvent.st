!CourseEvent class methodsFor: 'creation'!
new: name
	|r|
	r:=  super new.
	^r
!!
"=============================================="
!CourseEvent methodsFor: 'timer'!
	|timer|
	timer := Delay forSecond: ((Random new) next) * 5.
        The machine 
!!
	
