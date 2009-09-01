! State class methods !
new: aSymbol
	^self new id: App nextId; name: aSymbol
!!
! State methods !
id: aNumber
	id := aNumber.
!
printOn: aStream
	aStream nextPutAll: self class name;
			nextPut: $(.
	id printOn: aStream.
	aStream	nextPutAll: ': ';
			nextPutAll: name; 
			nextPut: $)
!
onEntry
	^nil
!
onExit
	^nil
!!
! EndState methods !
onEntry
	'that''s all folks!' oo
!!
