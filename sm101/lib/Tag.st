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
!!
! TagHeight class methods !
handles
	 ^'^\s*height\s+(\d+)\s*$'
!!

! TagHeight methods !
line: string for: graph at: line
	graph height: string asWords second asInteger.
	"if we expect a float, use Float readFrom: self"
!!

! TagLabel class methods !
handles
	 ^'^\s*label\s+'
!!

! TagLabel methods !
line: string for: graph at: line
	graph label: (string replacingRegex: '^\s*label\s+' with: '')
!!

! TagBottomT class methods !
handles
	 ^'^\s*bottom\s+ticks\s+(\d+\s*)+\s*$'
!!

! TagBottomT methods !
line: string for: graph at: line
	graph bottomT: (string replacingRegex: '^\s*bottom\s+ticks\s+' with: '') asWords
!!

! TagLeftT class methods !
handles
	 ^'^\s*left\s+ticks\s+(\d+\s*)+\s*$'
!!

! TagLeftT methods !
line: string for: graph at: line
	graph leftT: (string replacingRegex: '^\s*left\s+ticks\s+' with: '') asWords
!!

! TagRange class methods !
handles
	 ^'^\s*range\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$'
!!

! TagRange methods !
line: string for: graph at: line
	|buff|
	buff := (string replacingRegex: '^\s*range\s+' with: '') asWords.
	graph xrange: (buff at:1) asInteger max: (buff at:3) asInteger.
	graph yrange: (buff at:2) asInteger max: (buff at:4) asInteger
!!

! TagDataPt class methods !
handles
	 ^'^\s*(\d+)\s+(\d+)\s*.*\s*$'
!!

! TagDataPt methods !
line: string for: graph at: line
	|buff|
	buff := string asWords.
	graph graphpoints: ((buff at:1) asInteger @ (buff at:2) asInteger).
	((buff size) < 3)
		ifTrue: [graph graphsymbols: '*']
		ifFalse: [graph graphsymbols: (buff at:3)].
!!

! TagMb class methods !
handles
	 ^'^\s*mb\s+(\d+)\s+(\d+)\s+.*\s*$'
!!

! TagMb methods !
line: string for: graph at: line
	|buff|
	buff := (string replacingRegex: '^\s*mb\s+' with: '') asWords.
!!

! TagTagTag class methods !
handles
	 ^'^\s*tags\s+'
!!

! TagTagTag methods !
line: string for: graph at: line
	graph tags: (string replacingRegex: '^\s*tags\s+' with: '') asWords.	
!!

! TagComment class methods !
handles
	 ^'^\s*#\s+'
!!

! TagComment methods !
line: string for: graph at: line
!!
