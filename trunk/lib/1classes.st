#Manager     isa: Object with: 'workers roles seed rand' shares: 'Last'.
#Role        isa: Object with: 'name eman from to fromCard toCard froms tos'.
#Range       isa: Object with: 'min max'.
#Reader 	 isa: Object with: 'line array handler commentChar'.
#Graph       isa: Object with: 'label matrix height width ox oy xrange yrange'. 
					"XXX does Graph need anymore attributes?"
#Tag         isa: Object.
#GraphTag    isa: Tag.
#TagWidth    isa: GraphTag.
#TagError    isa: GraphTag.

#Cycle       isa: Object with: 'list pointer rand'.
#Machines    isa: Object with: 'rand time aSychnronous time' shares: 'All'.
#Machine     isa: Object with: 'states current defaultState'.
#Transition  isa: Object with: 'state if then next'.
#State       isa: Object with: 'name'.
#ErrorState  isa: State.
#LoopState   isa: State.
#EndState    isa: State.
#NormalState isa: State.

"XXX define subclasses of Tag to handle every tag"

"XXX Note that 'Tags' should run by calling 'tag'
the right number of times"
!
