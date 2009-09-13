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
        ^'^\s*range(\s*\d+)*\s*$'
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
! !
! TagHeight class methods !
handles
        ^'^\s*height\s*(\d+)\s*$'
!!

! TagHeight methods !
line: string for: graph at: line
	graph height: string asWords second asInteger.
	graph height: (graph height) width: (graph width)
!!

! TagIgnore class methods!
handles 
	^'^\s*\#'
!!

! TagIgnore methods!
line: string for: graph at: line
	
!!
! TagTag class methods !
handles 
	^'^\s*.*\s*tag.*(\s+\d+\s+.*)+\s*$'
!!
!TagTag methods!
line: string for: graph at: line
	|fline symbol ptag |
	fline  := string asWords.
	2 to: fline size by: 2 do: [:i| 
	symbol := (fline at: i) asInteger.
	ptag   := (fline at: i+1).
	graph tags at: symbol put: ptag.].
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
	 graph xrange add: trimx.
	 graph yrange add: trimy.
!!      


! TagLabel class methods !
handles
	^'^\s*label'
!!
! TagLabel methods !
line: string for: graph at: line
	graph label: (string replacingRegex: '^\s*label\s+' with: '').
!!
! TagMB class methods!
handles ^'^\s*mb'
!!

!TagMB methods!
line: string for: graph at: line
	|fline xpoint|
	fline := string asWords.
	(graph mb) at: 1 put: ((fline at: 2) asInteger).
	(graph mb) at: 2 put: ((fline at: 3) asInteger).
	(graph mb) at: 3 put:  (fline at:4).
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
	graph yrange add: ((fline at: x) asInteger).
	graph xindices add: (Point x:((fline at: x) asInteger) y:(graph oy)).  
	]
!!

! TagLeft class methods !
handles
        ^'^\s*left\s*ticks(\s*\d+)*\s*$'
!!

! TagLeft methods !
line: string for: graph at: line
	|fline ypoint|
        fline := string asWords.    
        3 to: (fline size) do: [:x|
		graph yrange add: (fline at: x) asInteger.
		graph yindices add: (Point x:(graph ox) y:((fline at: x) asInteger)).]
!!

