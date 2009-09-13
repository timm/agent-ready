#Manager     isa: Object with: 'workers roles seed rand' shares: 'Last'.
#Role        isa: Object with: 'name eman from to fromCard toCard froms tos'.
#Range       isa: Object with: 'min max'.
#Reader 	 isa: Object with: 'line array handler commentChar'.
#Graph       isa: Object with: 'dataPoints label matrix mb height width ox oy tags xrange yrange xTicks yTicks'. 
#Tag         isa: Object.
#GraphTag    isa: Tag.
#TagBottom   isa: GraphTag.
#TagComment  isa: GraphTag.
#TagData     isa: GraphTag.
#TagError    isa: GraphTag.
#TagHeight   isa: GraphTag.
#TagLabel    isa: GraphTag.
#TagLeft     isa: GraphTag.
#TagMb	     isa: GraphTag.
#TagRange    isa: GraphTag.
#TagTag	     isa: GraphTag.
#TagTags     isa: GraphTag.
#TagWidth    isa: GraphTag.

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

!
