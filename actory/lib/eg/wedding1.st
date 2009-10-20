|wed|
App reset; asynchronousOn; verbose.
wed := Wedding new: 'wedding'.
wed guests: 1.
wed cff: 1.
wed bp: 1.
wed budget: 10000.
wed time: 90.
wed decoration cost: 500.
wed decoration timetocompletion: 100.
wed ceremony length: 30.
wed food options: 1.
wed food portions: 2.
wed addtasks: (wed decoration).
wed addtasks: (wed ceremony).
wed addtasks: (wed food).
(wed guests) timesRepeat: [Guest worksIn: wed].
(wed cff) timesRepeat: [CFF worksIn: wed].
(wed bp) timesRepeat: [BP worksIn: wed].
wed run.
wed finalrating
!
