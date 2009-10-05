! Course class methodsFor: 'creation'!
new: name
	|r|
	r:= super new: name.
	self init.
	^r.
!!

"======================================"
! Course methodsFor: 'creation'!
init
	trans := Dictionary new.
!!
"======================"
! Course methodsFor: 'storing'!
worksIn: factory
	factory machine: self.
	self factory: factory.
	self checkandrun.
!!
"========================================"
! Course methodsFor: 'accessing'!
checkandrun
	trans size == 0
		ifTrue:  ['no course at all' o.]
		ifFlase: [self addtran.]. 
!
addtran
	1 to: (trans size) do: [:i|
		trans at: i oo.]
!!
		
