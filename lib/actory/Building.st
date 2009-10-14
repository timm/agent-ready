!Building class methodsFor: 'creation'!
new
	self error: 'Should not create Building without Name'
!
new: nameString
     ^super new: nameString
!!

"-----------------------------"
!Building methodsFor: 'creation' !

init: aString
      totalSensorCost := 0.
      totalDetection := 0.
      detectionCycles := 0.0000000000000000000000001.
      ^super init: aString
!!

"------------------------------"
!Building methodsFor: 'storing' !

professor: aProfessor
    self machine: aProfessor.
    self addSensorCost.
!

floor: aFloor
    self machine: aFloor.
!!

"-----------------------------"
!Building methodsFor: 'operation' !

addSensorCost
    totalSensorCost := totalSensorCost + 100
!

addDetection
    totalDetection := totalDetection + 1
!

addDetectionCycle
    detectionCycles := detectionCycles + 1
!


report
    ('The total cost of installing sensors around the building is: ', totalSensorCost s) oo.
    ('The average detection rate for this configuration is: ', (totalDetection / detectionCycles) s) oo.
!!



"-----------------------------"
!Building methodsFor: 'accessing' !
professors
    ^self machines contents select: [:m| m class = Professor]
!

getProfessor: aProfessorId
    ^(self professors detect: [:p| p id = aProfessorId])
!

floors
    ^self machines contents select: [:m| m class = Floor]
!

getFloor: aFloor
    ^(self floors detect: [:f| f name = aFloor]).
!


roomsIn: aFloor
    ^(self getFloor: aFloor) rooms
!

roomsIn: aFloor thatAre: aType
    ^(self roomsIn: aFloor) select: [:r| r type = aType].
!

randomRoomIn: aFloor thatIs: aType
    | rnd rType |
    rnd := (App random next * ((self roomsIn: aFloor thatAre: aType) size)) rounded.
    rType := OrderedCollection new.
    1 to: (self roomsIn: aFloor) size do: [:r|
    	 (((self roomsIn: aFloor) at: r) type = aType) ifTrue: [rType addLast: r]].
    ^rType at: rnd.
!!
