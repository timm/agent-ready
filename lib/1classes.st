#Manager     isa: Object with: 'workers roles seed rand' shares: 'Last'.
#Role        isa: Object with: 'name eman from to fromCard toCard froms tos'.
#Range       isa: Object with: 'min max'.
#Reader 	 isa: Object with: 'line array handler commentChar'.
#Graph       isa: Object with: 'label matrix height width ox oy xrange yrange'. 
					"XXX does Graph need anymore attributes?"
#Tag         isa: Object.
#TagWidth    isa: Tag.
#TagError    isa: Tag.

"XXX define subclasses of Tag to handle every tag"

"XXX Note that 'Tags' should run by calling 'tag'
the right number of times"
!
