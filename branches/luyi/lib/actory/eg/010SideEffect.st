s1 := SideEffect new.
((s1 Rand value) isNil ) ifTrue: ['happy' oo] ifFalse: ['unhappy' oo].
