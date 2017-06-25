!classDefinition: #TusLibrosModelTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosModelTest
	instanceVariableNames: 'cart cashier emptyCart cartWithItems aCashier aCreditCard anExpirationMonthOfYear anUnlistedItem aDummyMerchantProcessor listOfPrices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosModelTest methodsFor: 'test credit card' stamp: 'FG 6/25/2017 17:01:24'!
test14CreditCardShouldKnowWhenItIsExpired
	self deny: (aCreditCard isExpiredAt: anExpirationMonthOfYear previous).
	self deny: (aCreditCard isExpiredAt: anExpirationMonthOfYear).
	self assert: (aCreditCard isExpiredAt: anExpirationMonthOfYear next).! !


!TusLibrosModelTest methodsFor: 'test merchant processor' stamp: 'FG 6/25/2017 18:12:49'!
test17CashierCheckoutShouldFailWhenMerchantProcessorFails
	| aCashierWithMP aFailingMP |
	aFailingMP := MerchantProcessorStub withDebitClosure: [:anAmt :aCC | self error: MerchantProcessor outOfFundsErrorMessage].
	aCashierWithMP := Cashier withPrices: listOfPrices merchantProcessor: aFailingMP.
	self should: [
		aCashierWithMP checkout: cartWithItems from: aCreditCard on: anExpirationMonthOfYear.
	] raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: MerchantProcessor outOfFundsErrorMessage equals: anError messageText.
		self assert: aCashierWithMP sales isEmpty.
	].! !


!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:30:58'!
test01NewCartShouldBeEmpty
	self assert: cart isEmpty.! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:31:38'!
test02AfterAddingItemCartShouldNotBeEmpty
	cart addItem: 42.
	self deny: cart isEmpty.! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:31:48'!
test03CartShouldContainAddedItem
	cart addItem: 42.
	self assert: (cart includes: 42).! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:31:51'!
test04CartShouldNotContainNotAddedItem
	self deny: (cart includes: 42).! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:32:01'!
test05CartHasAmountOneOfNewlyAddedItem
	cart addItem: 42.
	self assert: 1 equals: (cart amountOf: 42).! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:32:12'!
test06CartHasThatManyAmountOfItemAddedManyTimes
	cart addItem: 42.
	cart addItem: 42.
	cart addItem: 42.
	self assert: 3 equals: (cart amountOf: 42).! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:32:18'!
test07CartHasThatManyAmountOfItemAddedInBulk
	cart addItem: 42 withAmount: 3.
	self assert: 3 equals: (cart amountOf: 42).! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:32:20'!
test08AddingZeroItemsToCartShouldFail
	self should: [cart addItem: 42 withAmount: 0] raise: Error - MessageNotUnderstood! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:32:26'!
test09AddingNonIntegerAmountOfItemsToCartShouldFail
	self should: [cart addItem: 42 withAmount: 2.5] raise: Error - MessageNotUnderstood! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:32:31'!
test10ListOfItemsInCartShouldIncludeItemsAdded
	| bag |
	cart addItem: 42.
	cart addItem: 108 withAmount: 3.
	bag := cart contents.
	self assert: #(42 108) equals: bag contents keys.
	self assert: 1 equals: (bag occurrencesOf: 42).
	self assert: 3 equals: (bag occurrencesOf: 108).! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/13/2017 21:37:27'!
test11AddingItemToCartNotInCatalogShouldFail
	self should: [cart addItem: 800]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: cart class notInCatalogErrorMessageText equals: anError messageText.
			self assert: (cart amountOf: 800) isZero.
		]! !

!TusLibrosModelTest methodsFor: 'test cart' stamp: 'FG 6/25/2017 19:24:24'!
test18CartShouldNotBeUsableAfterCheckout
	| amount item |
	item := 42.
	amount := cartWithItems amountOf: item.
	
	aCashier checkout: cartWithItems from: aCreditCard on: anExpirationMonthOfYear.

	self should: [
		cartWithItems addItem: item.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: cartWithItems class alreadyCheckedOutErrorMessage equals: anError messageText.
		self assert: amount equals: (cartWithItems amountOf: item).
	].! !


!TusLibrosModelTest methodsFor: 'test cashier' stamp: 'FG 6/25/2017 17:24:30'!
test12CashierCheckingOutAnEmptyCartShouldFail
	self should: [aCashier checkout: emptyCart from: aCreditCard on: anExpirationMonthOfYear]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: aCashier class emptyCartCheckoutErrorMessageText equals: anError messageText.
			self assert: aCashier sales isEmpty.
		]! !

!TusLibrosModelTest methodsFor: 'test cashier' stamp: 'FG 6/25/2017 17:24:46'!
test13CashierReturnsATicketWithTheTotalWhenCheckingOut
	| ticket |
	ticket := aCashier checkout: cartWithItems from: aCreditCard on: anExpirationMonthOfYear.
	self assert: 75 equals: ticket .! !

!TusLibrosModelTest methodsFor: 'test cashier' stamp: 'FG 6/25/2017 17:26:43'!
test15CashierShouldFailToCheckoutUnlistedItems
	cart addItem: anUnlistedItem.
	self should: [
		aCashier checkout: cart from: aCreditCard on: anExpirationMonthOfYear.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: aCashier class unlistedItemErrorMessage equals: anError messageText.
		aCashier sales isEmpty.
	].! !

!TusLibrosModelTest methodsFor: 'test cashier' stamp: 'FG 6/25/2017 17:20:35'!
test16CashierShouldFailToCheckoutWithExpiredCreditCard
	self should: [
		aCashier checkout: cartWithItems from: aCreditCard on: (anExpirationMonthOfYear next).
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: aCashier class expiredCreditCardErrorMessageText equals: anError messageText.
		aCashier sales isEmpty.
	].! !



!TusLibrosModelTest methodsFor: 'setup' stamp: 'FG 6/25/2017 18:30:08'!
setUp
	| aName aNumber |
	cart := Cart withCatalog: #(42 108 9000).
	cartWithItems  := Cart withCatalog: #(42 108 29).
	cartWithItems addItem: 42.
	cartWithItems addItem: 108.
	cartWithItems addItem: 29 withAmount: 2.
	listOfPrices := Dictionary newFromPairs: #(42 10 108 5 29 30).
	
	aDummyMerchantProcessor := MerchantProcessorStub withDebitClosure: [:anAmt :aCC].
	
	aCashier := Cashier withPrices: listOfPrices merchantProcessor: aDummyMerchantProcessor.
	emptyCart := Cart new.
	
	aName := 'Barack Obama'.
	aNumber := '4070304012345678'.
	anExpirationMonthOfYear := GregorianMonthOfYear juneOf: (GregorianYear number: 2020).
	aCreditCard := CreditCard withOwner: aName number: aNumber expiration: anExpirationMonthOfYear.
	
	anUnlistedItem := 9000.! !


!classDefinition: #TusLibrosServiceTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosServiceTest
	instanceVariableNames: 'service aClientId aPassword cartStore aCartId anISBN catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosServiceTest methodsFor: 'testing' stamp: 'FG 6/25/2017 19:52:51'!
test1ServiceShouldCreateAnEmptyCart
	| idCart |
	idCart := service createCartFor: aClientId password: aPassword.
	self assert: (service listCart: idCart) isEmpty.! !

!TusLibrosServiceTest methodsFor: 'testing' stamp: 'FG 6/25/2017 20:08:04'!
test2ServiceShouldListAddedItem
	| aBag anAmount |
	anAmount := 3.
	service addToCart: aCartId isbn: anISBN quantity: anAmount.
	aBag := service listCart: aCartId.
	self assert: anAmount equals: (aBag occurrencesOf: anISBN).! !


!TusLibrosServiceTest methodsFor: 'setup' stamp: 'FG 6/25/2017 20:02:42'!
setUp
	cartStore := FakeStore new.
	catalog := #(42 108 93).
	service := TusLibrosService withCartStore: cartStore catalog: catalog.

	aCartId := service createCartFor: aClientId password: aPassword.

	anISBN := 42.! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog checkedOut'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:26:06'!
addItem: anItem
	self addItem: anItem withAmount: 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:15:30'!
addItem: anItem withAmount: anInteger
	anInteger isZero ifTrue: [self error: 'amount must be non zero'].
	anInteger isInteger ifFalse: [self error: 'amount must be integer'].
	(self isValid: anItem) ifFalse: [self error: self class notInCatalogErrorMessageText].
	checkedOut ifTrue: [self error: self class alreadyCheckedOutErrorMessage].
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

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:13:48'!
initialize
	items := Bag new.
	checkedOut := false.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:38:58'!
initializeWithCatalog: aCollection 
	catalog := aCollection! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/12/2017 19:27:20'!
isEmpty
	^items isEmpty! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:46:18'!
isValid: anItem
	^catalog includes: anItem! !

!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:13:10'!
markCheckedOut
	checkedOut := true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:24:00'!
alreadyCheckedOutErrorMessage
	^'cart has already been checked out'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:41:21'!
notInCatalogErrorMessageText
	^'item is not in catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'FG 6/13/2017 21:49:14'!
withCatalog: aCollection
	^self new initializeWithCatalog: aCollection! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'listOfSales listOfPrices merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:23:24'!
checkout: aCart from: aCreditCard on: aGregorianMonthOfYear 
	| total |
	aCart contents isEmpty ifTrue: [self error: self class emptyCartCheckoutErrorMessageText].
	(aCreditCard isExpiredAt: aGregorianMonthOfYear) ifTrue: [self error: self class expiredCreditCardErrorMessageText].
	total := aCart contents collect: [:anItem |
		listOfPrices at: anItem ifAbsent: [self error: self class unlistedItemErrorMessage.]
	] andFold: [:a :b | a + b].
	merchantProcessor debit: total from: aCreditCard.
	listOfSales add: total.
	aCart markCheckedOut.
	^total! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'T 6/22/2017 13:43:53'!
initialize
	listOfSales := Set new.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:51:32'!
initializeWithPrices: aListOfPrices merchantProcessor: aMerchantProcessor.
	listOfPrices := aListOfPrices.
	merchantProcessor := aMerchantProcessor.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:10:30'!
sales
	^ listOfSales! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:15:10'!
emptyCartCheckoutErrorMessageText
	^'cannot check out an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:14:59'!
expiredCreditCardErrorMessageText
	^'credit card is expired'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:27:15'!
unlistedItemErrorMessage
	^'cannot checkout unlisted item'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:53:09'!
withPrices: aListOfPrices merchantProcessor: aMerchantProcessor
	^self new initializeWithPrices: aListOfPrices merchantProcessor: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationMonthOfYear owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 18:31:55'!
initializeWithOwner: aName number: aNumber expiration: aGregorianMonthOfYear
	owner := aName.
	number := aNumber.
	expirationMonthOfYear := aGregorianMonthOfYear.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:05:05'!
isExpiredAt: aGregorianMonthOfYear 
	^aGregorianMonthOfYear > expirationMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 18:30:36'!
withOwner: aName number: aNumber expiration: aGregorianMonthOfYear 
	^self new initializeWithOwner: aName number: aNumber expiration: aGregorianMonthOfYear! !


!classDefinition: #FakeStore category: #'TusLibros-Solution'!
Object subclass: #FakeStore
	instanceVariableNames: 'nextId dictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!FakeStore methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:50:31'!
add: anObject 
	| id |
	id := nextId.
	nextId := nextId + 1.
	dictionary at: id put: anObject.
	^id! !

!FakeStore methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:52:37'!
at: id
	^dictionary at: id! !

!FakeStore methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:51:00'!
initialize
	nextId := 0.
	dictionary := Dictionary new.! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:46:07'!
debit: anAmount from: aCreditCard
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'TusLibros-Solution'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 18:12:21'!
outOfFundsErrorMessage
	^'card is out of funds'! !


!classDefinition: #MerchantProcessorStub category: #'TusLibros-Solution'!
MerchantProcessor subclass: #MerchantProcessorStub
	instanceVariableNames: 'debitClosure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessorStub methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:53:45'!
debit: anAmount from: aCreditCard 
	^debitClosure value: anAmount value: aCreditCard! !

!MerchantProcessorStub methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 17:50:30'!
initializeWithDebitClosure: aBlockClosure 
	debitClosure := aBlockClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorStub class' category: #'TusLibros-Solution'!
MerchantProcessorStub class
	instanceVariableNames: ''!

!MerchantProcessorStub class methodsFor: 'class initialization' stamp: 'FG 6/25/2017 17:47:54'!
withDebitClosure: aBlockClosure 
	^self new initializeWithDebitClosure: aBlockClosure.! !


!classDefinition: #TusLibrosService category: #'TusLibros-Solution'!
Object subclass: #TusLibrosService
	instanceVariableNames: 'cartStore catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosService methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 20:01:11'!
addToCart: aCartId isbn: anISBN quantity: anAmount 
	| cart |
	cart := cartStore at: aCartId.
	cart addItem: anISBN withAmount: anAmount.! !

!TusLibrosService methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:45:49'!
createCartFor: aClientId password: aPassword 
	^cartStore add: (Cart withCatalog: catalog).! !

!TusLibrosService methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 20:03:01'!
initializeWithCartStore: aStore catalog: aCatalog
	cartStore := aStore.
	catalog := aCatalog.! !

!TusLibrosService methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 19:52:13'!
listCart: aCartId 
	^(cartStore at: aCartId) contents.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosService class' category: #'TusLibros-Solution'!
TusLibrosService class
	instanceVariableNames: ''!

!TusLibrosService class methodsFor: 'as yet unclassified' stamp: 'FG 6/25/2017 20:03:29'!
withCartStore: aStore catalog: aCatalog
	^self new initializeWithCartStore: aStore catalog: aCatalog! !
