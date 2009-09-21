! Machines class methods !
new: machines
	^self new: machines on: Random new.
!
new: machines on: r
	^super new init: machines on: r
!!

! Machines methods !
init: machines on: r
	rand := r.
	All := machines.
!!
