#Manager     isa: Object with: 'workers roles seed rand' shares: 'Last'.
#Role        isa: Object with: 'name eman from to fromCard toCard froms tos'.
#Range       isa: Object with: 'min max'.
#Reader 	 isa: Object with: 'line array handler commentChar'.
#Graph       isa: Object with: 'label matrix height width ox oy xrange yrange bottomT leftT'. 
					"XXX does Graph need anymore attributes?"
#Tag         isa: Object.
#GraphTag    isa: Tag.
#TagWidth    isa: GraphTag.
#TagHeight   isa: GraphTag.
#TagLabel    isa: GraphTag.
#TagBottomT  isa: GraphTag.
#TagLeftT    isa: GraphTag.
#TagRange    isa: GraphTag.
#TagError    isa: GraphTag.

(#Status     isa: Object shares: 'Asynchronousp Trace') selfInits.

#Cycle       isa: Status with: 'list pointer rand'.
#Machines    isa: Status with: 'rand time aSychnronous time' shares: 'All'.
#Machine     isa: Status with: 'id owner states current default transitions'.
(#Transition isa: Status with: 'state if then next') isPublic; selfInits.
#State       isa: Status with: 'name'.
#ErrorState  isa: State.
#LoopState   isa: State.
#EndState    isa: State.
#NormalState isa: State.

#Random 	 isa: Stream with: 'seed'  shares: 'TheRandom'.

"XXX define subclasses of Tag to handle every tag"

"XXX Note that 'Tags' should run by calling 'tag'
the right number of times"
!
