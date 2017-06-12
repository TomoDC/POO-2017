!classDefinition: #CartTest category: #'TusLibros-Solution'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:13:12'!
test01NewCartShouldBeEmpty
	| cart |
	cart := Cart new.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:16:35'!
test02AfterAddingItemCartShouldNotBeEmpty
	| cart |
	cart := Cart new.
	cart addItem: 42.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:24:07'!
test03CartShouldContainAddedItem
	| cart |
	cart := Cart new.
	cart addItem: 42.
	self assert: (cart contains: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:24:02'!
test04CartShouldNotContainNotAddedItem
	| cart |
	cart := Cart new.
	self deny: (cart contains: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:38:00'!
test05CartHasAmountOneOfNewlyAddedItem
	| cart |
	cart := Cart new.
	cart addItem: 42.
	self assert: 1 equals: (cart amountOf: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:38:39'!
test06CartHasThatManyAmountOfItemAddedManyTimes
	| cart |
	cart := Cart new.
	cart addItem: 42.
	cart addItem: 42.
	cart addItem: 42.
	self assert: 3 equals: (cart amountOf: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:39:48'!
test07CartHasThatManyAmountOfItemAddedInBulk
	| cart |
	cart := Cart new.
	cart addItem: 42 withAmount: 3.
	self assert: 3 equals: (cart amountOf: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:49:23'!
test08AddingZeroItemsToCartShouldFail
	| cart |
	cart := Cart new.
	self should: [cart addItem: 42 withAmount: 0] raise: Error - MessageNotUnderstood! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:50:10'!
test09AddingNonIntegerAmountOfItemsToCartShouldFail
	| cart |
	cart := Cart new.
	self should: [cart addItem: 42 withAmount: 2.5] raise: Error - MessageNotUnderstood! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:56:00'!
test10ListOfItemsInCartShouldIncludeItemsAdded
	| cart |
	cart := Cart new.
	cart addItem: 42.
	cart addItem: 108 withAmount: 3.
	self assert: #(42 108) equals: cart listItems.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 20:01:34'!
test11CartShouldNotContainRemovedItem
	| cart |
	cart := Cart new.
	cart addItem: 42.
	cart removeItem: 42.
	self deny: (cart contains: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 20:06:07'!
test12RemovingFromCartANotAddedItemShouldFail
	| cart |
	cart := Cart new.
	self should: [cart removeItem: 42] raise: Error - MessageNotUnderstood.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 20:08:33'!
test13RemovingFromCartAnItemShouldHaveAmountOneLess
	| cart |
	cart := Cart new.
	cart addItem: 42 withAmount: 3.
	cart removeItem: 42.
	self assert: 2 equals: (cart amountOf: 42).! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'empty items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:26:54'!
addItem: anItem
	items add: anItem.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:51:10'!
addItem: anItem withAmount: anInteger
	anInteger isZero ifTrue: [self error: 'amount must be non zero'].
	anInteger isInteger ifFalse: [self error: 'amount must be integer'].
	items add: anItem withOccurrences: anInteger.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:31:35'!
amountOf: anItem 
	^items occurrencesOf: anItem! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:28:06'!
contains: anItem 
	^items includes: anItem! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:27:11'!
initialize
	items := Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:27:20'!
isEmpty
	^items isEmpty! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 20:01:20'!
removeItem: anItem 
	items remove: anItem.! !


!Cart methodsFor: 'class membership' stamp: 'FG 6/12/2017 19:58:52'!
listItems
	^items contents keys! !
