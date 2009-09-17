! Machine class methods !
new: id with: machines
	^super new init: id with: machines
!
! Machine methods !
init: name with: machines	
	id := name.
	owner := machines.
	transitions := Dictionary new.
	states := Dictionary new.
!
error: message
	^super error: ('Machine[,'id s,']: ', message) 
! 
add: transition
	|state|
	state := transition state.
	state m: self.
	default ifNil: [default := state].
	transitions at: state
				ifAbsent: [states at: state put: Cycle new.  ].
	(transitions at: state) add: transition.
!
state: aSymbol
	transitions at: aSymbol 
			   ifAbsent: [^self error: ('Missing state: [', aSymbol s)]
!
step: ifNoStep
	current ifNil: [current:= default].
	(self state: current) do: [:transition |
		transition ready ifTrue: [^current := transition fire]].
	^ifNoStep value.	
!
!
