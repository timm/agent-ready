|f|

5 timesRepeat: [
	App reset: (Random next*Random next*100) maxLoops:250; asynchronousOff.
	f := Factory new: 'f1'.
	App silent.
	President worksIn: f.
	Historian worksIn: f.

	100 timesRepeat: [
		Senator worksIn: f.
	].
	f run.
].
!
