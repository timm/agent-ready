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

! TagLable class methods !
handels
	^'^\s*label\s+(\d+)\s*$'
!!

! TagLabel methods !
line: string for: graph at: line
	graph splot ((graph width + ox - size: string)/2) with: string.
!!

! TagBottom class methods !
handels 
        ^'^\s*bottom\s*ticks(\s\d+)*\s*$'
!!

! TagBottom methods !
line: string for: graph at: line
	fline := string asWords.
        3 to: (fline size) do: [:x|
		graph plot: (Point x: (x asInteger) y:0) with '|'. 
!!

! TagLeft class methods !
handels
        ^'^\s*left\s*ticks(\s\d+)*\s*$'
!!

! TagLeft methods !
line: string for: graph at: line
        fline := string asWords.    
        3 to: (fline size) do: [:x|
                graph plot: (Point x: 0 y:(x asInteger)) with '-'.
!!

! TagRange class methods !
handels
	^'^\s*range(\s\d+)*\s*$'
!!

! TagRange methods !
line: string for: graph at: line
        fline := string asWords.    
	xmin := fline at: 2.
	ymin := fline at: 3.
	xmax := fline at: 4.
        ymax := fline at: 5. 
!!

! TagHeight class methods !
handels
        ^'^\s*height\s*(\d+)\s*$'
!!

! TagHeight methods !
line: string for: graph at: line
	graph height: string asWords second  asInteger.

!!

! TagData class methods !
handels
        ^'^(\s*\d+)*\s\*$'
!!

! TagData methods !
line: string for: graph at: line
        fline := string asWords.
	bpoint := Point x:((fline at: 1) asInteger) y:((fline at: 2) asInteger).
	bsymbol := fline at: 3.
	graph plot: bpoint with: bsymbol. 
!!


