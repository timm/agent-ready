!Reader class methods !
new 
    ^super new init  
!!
! Reader  methods !
init
	line := 0.
	self handler: Tag;
   	     commentChar: $#.
!
cantDo: this
	^self error: ('line ',line s,') cannot handle [',this,']')
!
commentChar: aChar
	commentChar := aChar
!
handler: aRootClass
	 handler := aRootClass
!
handlerOf: aString 
    ^(handler handlerOf: aString) ifNil: [^self cantDo: aString]
!
line: string for: this
    |klass|
    klass := self handlerOf: string.
    ^klass new  line: string for: this at: line
!
lines: aFileName for: this
       | cleanline |
	line := 0.
	aFileName fileLinesDo: [:words|
		words =~ '(.*)#(.*)' ifMatched: [:match|
		      cleanline := (match at: 1) ]
		      ifNotMatched: [cleanline:= words].
		line := line + 1.
		cleanline size > 1 ifTrue: [ 
			self line: cleanline for: this]] !
!!
