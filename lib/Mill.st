! Mill methods !
init 
	all := Stagger new.
!
reset
	all do:[:machine | machine reset]
!
add: machine
	all add: machine
!
do: aBlock
	all contents size oo.
	all do: [:machine| aBlock value: machine]
!
start
	self do: [:machine| machine start].
!
step
	| more |
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
	"Important: must be tail recursive."
	App tick.
	self step ifTrue: [self walk].
!
run
	App reset.
	self reset; start; walk
!!
