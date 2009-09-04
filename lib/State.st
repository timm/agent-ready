! State class methods !
nameToClass: aSymbol
	aSymbol s ~ 'X$' ifTrue: [^ErrorState].
	aSymbol s ~ 'L$' ifTrue: [^LoopState].
	aSymbol s ~ 'F$' ifTrue: [^EndState].
	^NormalState
!
from: aSymbol
	^(self nameToClass: aSymbol) new: aSymbol.
!
new: aSymbol
	^super new init: aSymbol
!!
! State methods !
= aState
	name = aState name
!
init: aSymbol
	name := aSymbol.
	self reset.
	id := App nextId.
!
reset
	visits := 0
!
printOn: aStream
	aStream nextPutAll: self class name;
			nextPut: $(.
	id printOn: aStream.
	aStream	nextPutAll: ': ';
			nextPutAll: name; 
			nextPut: $)
!
onStay
	^nil
!
onEntry
	visits := visits + 1.
	self tooManyLoops
!
onExit
	^nil
!
start
	self onEntry.
!
stopped
	^false
!	
tooManyLoops
	visits > App tooManyLoops
		 ifTrue: [self error: 'too many loops']
!!
! LoopState !
tooManyLoops
	^nil
!!
! EndState methods !
stopped
	^true
!
onEntry
	'that''s all folks!' oo
!!
