!classDefinition: #CartCashierTest category: #'TusLibros-Solution'!
TestCase subclass: #CartCashierTest
	instanceVariableNames: 'cart cashier emptyCart cartWithItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 16:54:08'!
setUp
	| listOfPrices |
	cart := Cart withCatalog: #(42 108).
	cartWithItems  := Cart withCatalog: #(42 108 29).
	cartWithItems addItem: 42.
	cartWithItems addItem: 108.
	cartWithItems addItem: 29 withAmount: 2.
	listOfPrices := Dictionary newFromPairs: #(42 10 108 5 29 30).
	cashier := Cashier withListOfPrices: listOfPrices.
	emptyCart := Cart new.! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:30:58'!
test01NewCartShouldBeEmpty
	self assert: cart isEmpty.! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:31:38'!
test02AfterAddingItemCartShouldNotBeEmpty
	cart addItem: 42.
	self deny: cart isEmpty.! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:31:48'!
test03CartShouldContainAddedItem
	cart addItem: 42.
	self assert: (cart includes: 42).! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:31:51'!
test04CartShouldNotContainNotAddedItem
	self deny: (cart includes: 42).! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:01'!
test05CartHasAmountOneOfNewlyAddedItem
	cart addItem: 42.
	self assert: 1 equals: (cart amountOf: 42).! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:12'!
test06CartHasThatManyAmountOfItemAddedManyTimes
	cart addItem: 42.
	cart addItem: 42.
	cart addItem: 42.
	self assert: 3 equals: (cart amountOf: 42).! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:18'!
test07CartHasThatManyAmountOfItemAddedInBulk
	cart addItem: 42 withAmount: 3.
	self assert: 3 equals: (cart amountOf: 42).! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:20'!
test08AddingZeroItemsToCartShouldFail
	self should: [cart addItem: 42 withAmount: 0] raise: Error - MessageNotUnderstood! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:26'!
test09AddingNonIntegerAmountOfItemsToCartShouldFail
	self should: [cart addItem: 42 withAmount: 2.5] raise: Error - MessageNotUnderstood! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:32:31'!
test10ListOfItemsInCartShouldIncludeItemsAdded
	| bag |
	cart addItem: 42.
	cart addItem: 108 withAmount: 3.
	bag := cart contents.
	self assert: #(42 108) equals: bag contents keys.
	self assert: 1 equals: (bag occurrencesOf: 42).
	self assert: 3 equals: (bag occurrencesOf: 108).! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:37:27'!
test11AddingItemToCartNotInCatalogShouldFail
	self should: [cart addItem: 800]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: cart class notInCatalogErrorMessageText equals: anError messageText.
			self assert: (cart amountOf: 800) isZero.
		]! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 12:53:23'!
test12CashierCheckingOutAnEmptyCartShouldFail
	self should: [cashier checkOut: emptyCart]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: cashier class emptyCartCheckOutErrorMessageText equals: anError messageText.
			self assert: cashier listOfSales isEmpty.
		]! !

!CartCashierTest methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 16:55:19'!
test13CashierReturnsATicketWithTheTotalWhenCheckingOut
	| ticket |
	ticket := cashier checkOut: cartWithItems.
	self assert: 75 equals: ticket .! !


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


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'listOfSales listOfPrices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 16:42:31'!
checkOut: aCart 
	| total |
	aCart contents isEmpty ifTrue:[self error: self class emptyCartCheckOutErrorMessageText].
	total := 0.
	aCart contents do:[:anItem | total := total + (listOfPrices at: anItem)].
	listOfSales add: total.
	^total! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 13:43:53'!
initialize
	listOfSales := Set new.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 16:55:56'!
initializeWith: aListOfPrices
	listOfPrices := aListOfPrices.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 13:01:57'!
listOfSales
	^ listOfSales! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 13:01:13'!
emptyCartCheckOutErrorMessageText
	^'Cant check out an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 16:25:46'!
withListOfPrices: aListOfPrices
	^self new initializeWith: aListOfPrices.! !
