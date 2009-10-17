! State class methodsFor: 'coercing' !
from: aSymbol
	^(self nameToClass: aSymbol) new: aSymbol.
!
nameToClass: aSymbol
	aSymbol s ~ 'X$' ifTrue: [^ErrorState].
	aSymbol s ~ 'L$' ifTrue: [^LoopState].
	aSymbol s ~ 'F$' ifTrue: [^EndState].
	aSymbol s ~ 'HaHa$' ifTrue: [^Happy].
	aSymbol s ~ 'H$' ifTrue: [^Happy].
	aSymbol s ~ 'B$' ifTrue: [^Busy].
	aSymbol s ~ 'BH$' ifTrue: [^BusyNeedHelp].
	aSymbol s ~ 'I$' ifTrue: [^Idle].
	^NormalState
!!

"============================================"
! State class methodsFor: 'creation' !
new: aSymbol
	^super new init: aSymbol
!!

"============================================"
! State methodsFor: 'creation' !
init: aSymbol
	name := aSymbol.
	self reset.
	id := App nextId.
	froms := tos := 0
!
oneMoreFrom
	froms := froms + 1.
!
oneMoreTo
	tos := tos + 1.
!!

"============================================"
! State methodsFor: 'comparing' !
= aState
	^name = aState name
!!

"============================================"
! State methodsFor: 'accessing' !
factory
	^container factory
!
machine: aMachine
	container := aMachine
!
machine
	^container
!!

"============================================"
! State methodsFor: 'simulation' !
onEntry
	visits := visits + 1.
	self tooManyLoops
!
onExit
	^nil
!
onStay
	^nil
!
reset
	visits := 0
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

"============================================"
! State methodsFor: 'printing' !
printOn: aStream
	aStream nextPutAll: self class name;
			nextPut: $(.
	aStream	nextPutAll: name;
			nextPut: $#.
	id printOn: aStream. 
	aStream	nextPut: $)
!

"============================================"
! LoopState methods !
tooManyLoops
	^false
!!

! EndState methods !
stopped
	^true
!
onEntry
	App say: (The machine name,'happiness: ',((The machine happiness) printString))
!!

! Idle methods !
onEntry
	' Time to relax ' noo.
!
onStay
	' Got time to kill ' noo.	
!
onExit
	' Good I was starting to get bored ' oo.
!!

! Busy methods !
onEntry
	' There are things to do! ' noo.
!
onStay
	' Still not done ' noo.	
!
onExit
	' Finally done with that ' oo.
!!

! BusyNeedHelp methods !
onEntry
	' Gonna need help here! ' noo.
!
onStay
	' Working as a team! ' noo.	
!
onExit
	' Thanks I can handle it from here ' oo.
!!

! Happy methods !
onEntry
	' Sweet! ' noo.
!
onStay
	' Enjoying my time ' noo.	
!
onExit
	' Everything must end sometime ' oo.
!!
"============================================"



