|f|

App resetAny; asynchronousOff; silent.
f := Factory new: 'f1'.
PresidentKEYS worksIn: f.
Historian worksIn: f.

100 timesRepeat: [
	Senator worksIn: f.
].


1 to: 800 do: [:x|
	App resetAny.
	App resetAny.
	f run.
		
	((x\\100) = 0)
		ifTrue:['Rebiasing' oo. f oracle learn].
].
!
