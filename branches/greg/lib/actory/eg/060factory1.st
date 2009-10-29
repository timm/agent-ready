|f|

App resetAny; asynchronousOff; silent.
f := Factory new: 'f1'.
President worksIn: f.
Historian worksIn: f.

100 timesRepeat: [
	Senator worksIn: f.
].


5 timesRepeat: [
	App resetAny.
	App resetAny.
	f run.
].
!
