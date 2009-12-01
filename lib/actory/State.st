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
	aSymbol s ~ 'P$'	ifTrue: [^Presenting].
	aSymbol s ~ 'H$'	ifTrue: [^Suspended].
	aSymbol s ~ 'I$'	ifTrue: [^Investigating].
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
	|vote|
	(The machine billProposed<2)
	ifTrue:[
		vote:=The oracle polled: The machine.
		(vote)
			ifTrue:[
				App say: 'The bill passes.'.
				(The machine party =0)
					ifTrue:[The oracle dsuccess: (The oracle dsuccess)+1]
					ifFalse:[The oracle rsuccess: (The oracle rsuccess)+1]
			]
			ifFalse:[App say: 'The bill is vetoed. Try again tomorrow.'].
	].

	The machine talks:'leaving for the day.'.
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

!Investigating methods !
onEntry
	|target|
	target:= ((App random next*The factory machines contents size) rounded).
	(target = 0) ifTrue:[target:=1].	
	target:= The factory machines contents at: target.

	(target caughtLikelihood > 0.75)
		ifTrue:[ App say: 'They exposed a dirty senator and were rewarded for it.'.
			The machine billSupport: (The machine billSupport sqrt).
			target caught]
		ifFalse:[ App say: 'They failed to catch anybody.'].
!!

!Scandal methods !
onEntry	
	The machine naughty.
!!

!Selling methods!
onEntry
	|vote senators rand1 position count|
	The machine talks:'gathering support'.
	The machine billSupport: (The machine billSupport raisedTo:0.75).
	"senators:= ((The factory) machines contents) size.
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
			The machine billSupport: (The machine billSupport raisedTo:0.5).]." 
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
						(machine id = The machine id)
							ifTrue:[ vote:=true.]
							ifFalse:[vote:=machine polled: (The machine).].
						(vote) ifTrue: [support:= support + ((1/committeeMembers) asFloat).].
					].
			].

			(support >= (3/5 asFloat))
				ifTrue: [
					App say: 'The bill passes the committee.'.
					The machine billPassed: 1.
					The machine billSupport: 0.]
				ifFalse: [
					App say: 'The bill failed to pass the committee.'.
					"Add a boost to support for the second time around"
					The machine billSupport: The machine billSupport sqrt].
		]
		"Full senate vote"
		ifFalse:[
			"Has it been presented more than twice today?"
			(The machine billProposed < 2)
				ifTrue:[
					The factory machines contents do: [:machine |
						(machine id = The machine id)
							ifTrue:[vote:=true.]
							ifFalse:[vote:=machine polled: (The machine).].
						(vote) ifTrue: [support:=support+((1/senators) asFloat).].
					].
					(support >= (3/5 asFloat))
						ifTrue:[
							App say: 'The bill passes in the senate.'.
							The machine billPassed: 2.]
						ifFalse:[
							App say:'The bill failed to pass in the senate.'.
							"Add a boost for the next time around."
							The machine billSupport: The machine billSupport sqrt.
							The machine billProposed: (The machine billProposed)+1.].
				].
		]. 
!!
! Presenting methods !
onEntry
	|prob1|
	The machine talks: 'gives a rousing speech.'.
	prob1:= App random next.
	(prob1 > 0.05)
		ifTrue:[The machine billSupport: (The machine billSupport sqrt). 
			App say:'The audience approves and applauds.']
		ifFalse:[The machine billSupport: (The machine billSupport raisedTo:0.75).
			App say:'The senators seem to not like your proposal.You only gain some support.'].
		
!
onStay
	|prob1|
	The machine talks: 'continues to speak in a desperate attempt to garner support.'.
	prob1:= App random next.
	(prob1 > 0.25)
		
ifTrue:[The machine billSupport: (The machine billSupport sqrt).
			App say:'You have the audience in the palm of your hand.']
		ifFalse:[The machine billSupport: (The machine billSupport raisedTo:0.75).
			App say:'The audience is not interested. Get out of there and preserve your dignity.'].
!!
! Suspended methods !
onEntry
	|closed|
	closed:=0.
	(The machine cloture = 0) ifTrue:[
		(The machine party = The factory suspendee)
			ifTrue:[ 
				(App random next + The factory pressure < 0.9)
					ifFalse: [The machine cloture:1.
							The machine talks:'votes for cloture.']				
			]	
			ifFalse:[ The machine cloture:1.
					The machine talks:'votes for cloture.'].
		
	].

	The factory pressure: The factory pressure sqrt.
	The factory machines contents do: [:machine |
		(machine cloture=1) ifTrue:[closed:=closed+1].
	].
	(closed > 59) 
		ifTrue:[The factory suspended:false.
			The factory machines contents do: [:machine|
				machine cloture:0.].
		].
!
onStay
	self onEntry.
!
onExit
	The factory pressure:0.1.
!!
