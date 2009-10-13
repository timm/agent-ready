|wed|
App reset; asynchronousOn.
wed := (Wedding new: 'wedding').
wed guests: 1.
wed budget: 10000.
wed decoration cost: 500.
wed ceremony length: 30.
wed food options: 2.
wed food portions: 2.
wed addtasks: (wed decoration).
wed addtasks: (wed ceremony).
wed addtasks: (wed food).
Guest worksIn: wed.
wed run.
!
