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

! TagRange class methods !
handles
        ^'^\s*range(\s\d+)*\s*$'
!!

! TagRange methods !
line: string for: graph at: line
        |fline|
        fline := string asWords.
        graph xrange min: ((fline at: 2) asInteger).
        graph yrange min: ((fline at: 3) asInteger).
        graph xrange max: ((fline at: 4) asInteger).
        graph yrange max: ((fline at: 5) asInteger).
! !


! TagWidth class methods !
handles
	 ^'^\s*width\s+(\d+)\s*$'
!!

! TagWidth methods !
line: string for: graph at: line
	graph width: string asWords second asInteger.
	"if we expect a float, use Float readFrom: self"
	graph height == 0
		ifFalse: [ graph height: (graph height) width: (graph width)]
! !
! TagHeight class methods !
handles
        ^'^\s*height\s*(\d+)\s*$'
!!

! TagHeight methods !
line: string for: graph at: line
	graph height: string asWords second asInteger.
	graph width ==0
		ifFalse: [graph height: (graph height) width: (graph width)]
!!

! TagData class methods !
 handles
         ^'^(\s*\d+)*\s.*$'
!!
! TagData methods !
 line: string for: graph at: line
         |fline trimx trimy bpoint bsymbol bmatrix|
         fline := string asWords.
         trimx := (fline at: 1) asInteger.
         trimy := (fline at: 2) asInteger.
         bsymbol := fline at: 3.
         graph rawdata at: (Point x:trimx y:trimy) put: bsymbol.
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
	graph xindices add: (Point x:((fline at: x) asInteger) y:(graph oy)).  
	"xpoint := graph xscale: ."
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
		"ypoint := graph yscale:"
		graph yindices add: (Point x:(graph ox) y:((fline at: x) asInteger)).]
!!

