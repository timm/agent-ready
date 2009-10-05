!Guard class methodsFor: 'creation'!
new
 	^super new.
!
Rand  
	((Random next) > 0.5)
		ifTrue:  [^True.]
		ifFalse: [^False.]
!!
