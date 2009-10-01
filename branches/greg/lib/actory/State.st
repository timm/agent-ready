! State class methodsFor: 'coercing' !
from: aSymbol
	^(self nameToClass: aSymbol) new: aSymbol.
!
nameToClass: aSymbol
	aSymbol s ~ 'X$' ifTrue: [^ErrorState].
	aSymbol s ~ 'L$' ifTrue: [^LoopState].
	aSymbol s ~ 'F$' ifTrue: [^EndState].
	aSymbol s ~ 'HaHa$' ifTrue: [^Happy].
	aSymbol s ~ 'S$'    ifTrue: [^Scandal].
	aSymbol s ~ 'G$'	ifTrue: [^Selling].
	aSymbol s ~ 'V$'	ifTrue: [^Voting].
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
	'that''s all folks!' oo
!!

! Happy methods !
onEntry
	'ha ha ha ha ha' noo.
!
onStay
	'still laughing' oo.	
!
onExit
	'the fun stops here' oo.
!!

!Scandal methods !
onEntry	
	The machine naughty.
!!

!Selling methods!
onEntry
	|vote senators rand1 position count|
	The machine talks:'gathering support'.
	senators:= ((The factory) machines contents) size.
	count:=1.

	The factory machines contents do:[:machine |
		(machine id=(The machine id))
			ifTrue:[position:=count].
		count:=count+1.].

	rand1:=(((App random next)*senators) rounded).
	(rand1=0) ifTrue: [rand1:=1].
	(rand1=position) 
		ifTrue: [ (rand1=1)
				ifTrue:[rand1:=rand1+1]
				ifFalse:[rand1:=rand1-1].].

	vote := (((The factory) machines contents at: rand1) polled: The machine).

	(vote)
		ifTrue:[ 
			The machine billSupport: (((The machine billSupport)+(1/senators)) asFloat).]. 
!
onStay
	self onEntry.
!!

!Voting methods!
onEntry
	|vote rand1 senators position count committeeMembers support|
	senators:= ((The factory) machines contents) size.
	count:=1.
	committeeMembers:=0.
	support:=0.

	The factory machines contents do:[:machine |
		(machine id=(The machine id))
			ifTrue:[position:=count].
		count:=count+1.].

	"Is this a comittee vote or a full senate vote?"
	(The machine billPassed=0)
		ifTrue:[
			The factory machines contents do: [:machine |
				(machine committee = The machine billCommittee)
					ifTrue:[committeeMembers:=committeeMembers+1.
						machine talks:'In attendance for committee vote.'].
			].
			The factory machines contents do: [:machine |
				(machine committee=The machine billCommittee)
					ifTrue:[
						vote:=machine polled: (The machine).
						(vote) ifTrue: [support:= support + ((1/committeeMembers) asFloat).].
					].
			].

			(support >= (3/5 asFloat))
				ifTrue: [
					'The bill passes the committee.' oo.
					The machine billPassed: 1.
					The machine billSupport: 0.]
				ifFalse: [
					'The bill failed to pass the committee.' oo].
		]. 
!!
