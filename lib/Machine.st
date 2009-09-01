! Machine class methods !
new: machines
	^super new init: machines
!!
! Machine methods !
init: machines
	partOf := machines	
	machines all add: self.
	id          := App nextId.
	starts      := Bag new.
	stops       := Bag new.
	transitions := Dictionary new.
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
                                      put: Cycle new].
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
steps
	self candidates do: [:candidate |
		candidate ready 
			ifTrue: [current onExit.
					 current := candidate fire.
					 current onEntry.
					 ^true]].
	^false
!!
