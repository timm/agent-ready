! Factory class methodsFor: 'creation' !
new
	self error: 'should not create Factories without nameStrings'
!
new: nameString
	^super new init: nameString
!!

"==============================================="
! Factory methodsFor: 'creation' !
  
init: aString 
	machines := Stagger new.
	name := aString.
	suspended:=false.
	pressure:=0.25.
!
go: state1 to: state2                          
	^self go: state1 to: state2 if: [true] then: [true] 
!
go: state1 to: state2 if: gaurd                
	^self go: state1 to: state2 if: gaurd  then: [true] 
!
go: state1 to: state2 then: sideEffect         
	^self go: state1 to: state2 if: [true] then: sideEffect 
!
go: state1 to: state2 then: sideEffect if: gaurd 
	^self go: state1 to: state2 if: gaurd then: sideEffect 
!
go: state1 to: state2 if: gaurd then: sideEffect
	self transition:
		(Transition new
			state:  state1 state;
			if:     gaurd;   
			then:   sideEffect;
			next:   state2 state)
!! 

"==============================================="
! Factory methodsFor: 'storing' !
machine: machine
	current := machine.
	machines add: machine.
	machine factory: self.
!
newMachine: name
	self machine: (Machine new: name).
!
transition: trans
	current add: trans
!
oracle: machine
	current := machine.
	oracle := machine.
	machine factory: self.
!
historian: machine
	current := machine.
	historian := machine.
	machine factory: self.
!
suspended: s
	suspended:=s.
!
suspendee: s
	suspendee:=s.
!
pressure: p
	pressure:=p.
!!
"==============================================="
! Factory methodsFor: 'printing' !
printOn: aStream
	super printOn: aStream.
	name printOn: aStream
!!

"==============================================="
! Factory methodsFor: 'enumerating' !
do: aBlock
	machines do: [:machine| aBlock value: machine]
!!

"==============================================="
! Factory methodsFor: 'accessing' !
machines
	^machines
!
oracle
	^oracle
!
historian
	^historian
!
suspended
	^suspended
!
suspendee
	^suspendee
!
pressure
	^pressure
!!

"==============================================="
! Factory methodsFor: 'simulation' !
reset
	suspended:=false.
	pressure:=0.25.
	historian reset.
	oracle reset.
	machines contents do:[:machine | machine reset]
!
report
	App say: ''.
	App say: ('Terminated at tick ', Clock s).
	App say: ('Final patience ', Patience s).
	The historian report.
!
run
	self reset; start; walk; report.
!
start
	machines contents do: [:machine| machine start].
!
step
	| more |
	App tick.
	more := false.
	self do: [:machine|
	  machine step 
		ifTrue: [
			more := true.
            Asynchronousp 
		   	   ifTrue: [^true]]].
	^more
!
walk
	App patience: self patience.
	[true] whileTrue: [
		App clock > self tooMuch 
			ifTrue:[ ^true].
		self step 
			ifTrue:  [App patience: self patience]
			ifFalse: [App impatient 
						ifTrue: [^true]]].
!!

"==============================================="
! Factory methodsFor: 'constants' !
patience
	^250
!
tooMuch
	^500
!!
