"XXX find an implement any empty methods in the following"
!Tag class methods!
handles
	 ^'someImpossibBle STRing'
!
handlerOf: line
	   self allSubclasses do: [:class|	
	   		line ~ class handles  ifTrue: [^class]].
       ^nil "XXX once TagError is running, get rid of this return" 
!!
!Tag class methods !
handles
	^'^\s*\[.+\]\s*$'
!
line: string for: this at: line
	this block: (Behavior evaluate: string )
!!
! TagWidth class methods !
handles
	 ^'^\s*width\s+(\d+)\s*$'
!!

! TagWidth methods !
line: string for: graph at: line
	graph width: string asWords second asInteger.
	"if we expect a float, use Float readFrom: self"
! !

! TagRange class methods !
handles
	^'^\s*range(\s\d+)*\s*$'
!!

! TagRange methods !
line: string for: graph at: line
	|fline|
        fline := string asWords.
	graph xrange min: (fline at: 2).
    	graph yrange min: (fline at: 3).
	graph xrange max: (fline at: 4).
        graph yrange max: (fline at: 5).        
! !

! TagHeight class methods !
handles
        ^'^\s*height\s*(\d+)\s*$'
!!

! TagHeight methods !
line: string for: graph at: line
	graph height: string asWords second  asInteger.
	"graph resize."
	"graph frame."
!!

! TagLable class methods !
handles
	^'^\s*label\s+(\d+)\s*$'
!!

! TagLabel methods !
line: string for: graph at: line
	|label fstream|
	fstream := WriteStream on: ''. 
	label := string asWords.
	2 to: label size do: [:i|
	label at:i printOn: fstream.
	]
	graph label: (fstream content)
!!

! TagBottom class methods !
handles 
        ^'^\s*bottom\s*ticks(\s\d+)*\s*$'
!!

! TagBottom methods !
line: string for: graph at: line
	|fline xpoint|
	fline := string asWords.
        3 to: (fline size) do: [:x|
	xpoint := graph xscale: (x asInteger).	
	graph xindices add: (Point x:xpoint y:(graph oy)).
	]
!!

! TagLeft class methods !
handles
        ^'^\s*left\s*ticks(\s\d+)*\s*$'
!!

! TagLeft methods !
line: string for: graph at: line
	|fline ypoint|
        fline := string asWords.    
        3 to: (fline size) do: [:x|
		ypoint := graph yscale: (x asInteger).
		graph yindices add: (Point x:(graph ox) y:ypoint).]
!!

! TagData class methods !
handles
        ^'^(\s*\d+)*\s.*$'
!!

! TagData methods !
line: string for: graph at: line
	|fline trimx trimy bpoint bsymbol| 
        fline := string asWords.
	trimx := graph xscale: ((fline at: 1) asInteger).
	trimy := graph yscale: ((fline at: 2) asInteger). 
	bpoint := (Point x:trimx y:trimy).
	bsymbol := fline at: 3.
	graph plot: bpoint with: bsymbol. 
	graph draw
!!
