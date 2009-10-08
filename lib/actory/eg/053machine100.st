|f|
App reset; asynchronousOff.
f := Factory new: 'f1'.
App verbose.
President worksIn: f.
Historian worksIn: f.

100 timesRepeat:[
	Senator worksIn: f.
].

f run.
!
