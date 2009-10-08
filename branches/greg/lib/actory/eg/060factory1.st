|f|
('%Gathering Support, Presenting to Committee,Voting in Committee,Presenting to the Floor,',
		'Voting on the Floor,Committing a Scandal,Calling a Filibuster, Suspended for a Filibuster,',
		'Investigating a Colleague,Presenting to the President,Total Transitions,',
		'Democrat Percentage, Republican Percentage, Overall Score') oo.
5 timesRepeat: [
	App reset: Random next  maxLoops:250; asynchronousOff.
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
