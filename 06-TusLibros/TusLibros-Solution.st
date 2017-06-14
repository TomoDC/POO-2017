!classDefinition: #CartTest category: #'TusLibros-Solution'!
TestCase subclass: #CartTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:37:59'!
setUp
	cart := Cart withCatalog: #(42 108).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:30:58'!
test01NewCartShouldBeEmpty
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:31:38'!
test02AfterAddingItemCartShouldNotBeEmpty
	cart addItem: 42.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:31:48'!
test03CartShouldContainAddedItem
	cart addItem: 42.
	self assert: (cart includes: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:31:51'!
test04CartShouldNotContainNotAddedItem
	self deny: (cart includes: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:01'!
test05CartHasAmountOneOfNewlyAddedItem
	cart addItem: 42.
	self assert: 1 equals: (cart amountOf: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:12'!
test06CartHasThatManyAmountOfItemAddedManyTimes
	cart addItem: 42.
	cart addItem: 42.
	cart addItem: 42.
	self assert: 3 equals: (cart amountOf: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:18'!
test07CartHasThatManyAmountOfItemAddedInBulk
	cart addItem: 42 withAmount: 3.
	self assert: 3 equals: (cart amountOf: 42).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:20'!
test08AddingZeroItemsToCartShouldFail
	self should: [cart addItem: 42 withAmount: 0] raise: Error - MessageNotUnderstood! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:26'!
test09AddingNonIntegerAmountOfItemsToCartShouldFail
	self should: [cart addItem: 42 withAmount: 2.5] raise: Error - MessageNotUnderstood! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:31'!
test10ListOfItemsInCartShouldIncludeItemsAdded
	| bag |
	cart addItem: 42.
	cart addItem: 108 withAmount: 3.
	bag := cart contents.
	self assert: #(42 108) equals: bag contents keys.
	self assert: 1 equals: (bag occurrencesOf: 42).
	self assert: 3 equals: (bag occurrencesOf: 108).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:37:27'!
test11AddingItemToCartNotInCatalogShouldFail
	self should: [cart addItem: 800]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: cart class notInCatalogErrorMessageText equals: anError messageText.
			self assert: (cart amountOf: 800) isZero.
		]! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:26:06'!
addItem: anItem
	self addItem: anItem withAmount: 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:45:33'!
addItem: anItem withAmount: anInteger
	anInteger isZero ifTrue: [self error: 'amount must be non zero'].
	anInteger isInteger ifFalse: [self error: 'amount must be integer'].
	(self isValid: anItem) ifFalse: [self error: self class notInCatalogErrorMessageText].
	items add: anItem withOccurrences: anInteger.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:31:35'!
amountOf: anItem 
	^items occurrencesOf: anItem! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:06:24'!
contents
	^items copy! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:05:25'!
includes: anItem 
	^items includes: anItem! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:27:11'!
initialize
	items := Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:38:58'!
initializeWithCatalog: aCollection 
	catalog := aCollection! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:27:20'!
isEmpty
	^items isEmpty! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:46:18'!
isValid: anItem
	^catalog includes: anItem! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:41:21'!
notInCatalogErrorMessageText
	^'item is not in catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:49:14'!
withCatalog: aCollection
	^self new initializeWithCatalog: aCollection! !
