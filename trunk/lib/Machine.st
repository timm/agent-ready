! Machine class methods !
new: machines
	^super new init: machines
!!
! Machine methods !
reset
	transitions do: [:transition|
		transition reset]
!
init: machines
	partOf := machines.
	machines add: self.
	id          := App nextId.
	starts      := Bag new.
	stops       := Bag new.
	transitions := Dictionary new.
!
continue
	^current continue
!
start
	current start
!
error: message
	^super error: ('Machine[,'id s,']: ', message) 
! 
add: transition
	|state currentSymbol|
	transition machine: self.
	current       := transition state.
	currentSymbol := current name.
	starts add: currentSymbol.
	stops  add: currentSymbol.
	transitions at: currentSymbol
				ifAbsent: [transitions at: currentSymbol
                                      put: Stagger new].
	(transitions at: currentSymbol) add: transition.

!
current
	^current
!
transitions
	^transitions
!
candidates
	^self candidates:  current 
!
candidates: aState
     ^transitions at: aState name
	    ifAbsent: [
           self error: ('Missing state: [', aState printString)].
!
step
	self stopped ifTrue: [^false].
	self candidates do: [:candidate |
		candidate ready 
			ifTrue: [
				current := candidate fire.
				current = candidate next
					ifTrue:  [current onStay]
					ifFalse: [current onExit.
							  current := candidate next.
							  current onEntry].
				^true]].
	^false
!
stopped
	^current stopped
!!
