! Task class methodsFor: 'creation' !
new: taskname
	^super new init: taskname
!!

"============================================"
! Task methodsFor: 'creation' !
init: taskname
	name := taskname.
	cost := 0.
	timeneeded := 0.
	timestart := 0.
	timetocompletion := 0.
	peopleNum := 0
!!

"============================================"
! Task methodsFor: 'accessing' !
name
	^name
!
cost
	^cost
!
timeneeded
	^timeneeded
!
timestart
	^timestart
!
timetocompletion
	^timetocompletion
!
peopleNum
	^peopleNum
!!

"============================================"
! Task methodsFor: 'setting' !
cost: c
	cost := c
!
timeneeded: tn
	timeneeded := tn
!
timestart: ts
	timestart := ts
!
timetocompletion: ttc
	timetocompletion := ttc
!!

"============================================"
! Task methodsFor: 'operation' !
workdone
	(timetocompletion < 0)
	ifFalse: [timetocompletion := timetocompletion - peopleNum.
		(peopleNum = 0) ifFalse: [App say: (self name),' needs ',(timetocompletion/peopleNum) printString]]
!
moreWorkers
	peopleNum := peopleNum + 1
!
releaseWorkers
	peopleNum := 1
!!

