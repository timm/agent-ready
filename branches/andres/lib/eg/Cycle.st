| d r s |
d := #(#aa #bb #cc #dd #ee) asOrderedCollection.
r := Random seed: 113.
s := Space new: d  on: r.
20 timesRepeat: [
	s do: [:i| (i s, ' ')o]. '' oo
]
!
