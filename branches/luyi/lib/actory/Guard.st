!Guard class methodsFor: 'creation'!
new
 	^super new init.
!!
!Guard methodsFor: 'accessing'!
init
	guards := Dictionary new. 
	guards at: 0 put: [true].
!
Rand  
	|index|
	index := (Random next * ((guards size)-1)) rounded.
	^(guards at: index).
!
add: aGuard
	guards at: (guards size) put: aGuard.
!!
