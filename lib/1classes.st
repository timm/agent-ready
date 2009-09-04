#Range       isa: Object with: 'min max'.
#Reader 	 isa: Object with: 'line array handler commentChar'.
#Graph       isa: Object with: 'label matrix height width ox oy xrange yrange'. 
					"XXX does Graph need anymore attributes?"
#Tag         isa: Object.
#GraphTag    isa: Tag.
#TagWidth    isa: GraphTag.
#TagError    isa: GraphTag.

#App        isa:    Object 
            shares: 'Clock Rand Asynchronousp Trace Ids TooManyLoops' .

#Stagger     isa: App with: 'contents pointer'.
(#Mill    isa: App with: 'machines') inits. 
#Machine     isa: App with: 'container id current starts stops transitions'.
(#Transition isa: App with: 'contain state if then next') public; inits.
(#State      isa: App with: 'visits id name') public.
#ErrorState  isa: State.
#LoopState   isa: State.
#EndState    isa: State.
#NormalState isa: State.


"XXX define subclasses of Tag to handle every tag"

"XXX Note that 'Tags' should run by calling 'tag'
the right number of times"
!
