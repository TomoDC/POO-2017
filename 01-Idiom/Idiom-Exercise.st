!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'FG 4/20/2017 21:05:15'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook duration |
	
	customerBook := CustomerBook  new.
	
	duration := self measureDurationInMilliseconds: [
		customerBook addCustomerNamed: 'John Lennon'.
	].
	
	self assert: duration < 50 
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'FG 4/20/2017 21:04:30'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney duration |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	duration := self measureDurationInMilliseconds: [
		customerBook removeCustomerNamed: paulMcCartney.
	].
	
	self assert: duration < 100 
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'FG 4/20/2017 21:54:10'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertException: [customerBook addCustomerNamed: ''] isOfType: Error and: [ :anError | 
			(anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage) & (customerBook isEmpty) ]. 
! !

!IdiomTest methodsFor: 'testing' stamp: 'FG 4/20/2017 21:36:29'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertException: [customerBook removeCustomerNamed: 'Paul McCartney'.] isOfType: NotFound and: [ :anError | 
		(customerBook numberOfCustomers = 1) & (customerBook includesCustomerNamed: johnLennon)]. 
! !


!IdiomTest methodsFor: 'as yet unclassified' stamp: 'FG 4/20/2017 21:49:38'!
assertException: aBlockClosure isOfType: anErrorClass and: aBlockClosure3 
	[ aBlockClosure value.
		self fail ]
	on: anErrorClass do: [ :anError | self assert: (aBlockClosure3 value: anError) ]! !

!IdiomTest methodsFor: 'as yet unclassified' stamp: 'FG 4/20/2017 21:04:00'!
measureDurationInMilliseconds: aBlockClosure 
	| millisecondsAfterRunning millisecondsBeforeRunning |
	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlockClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	^ millisecondsAfterRunning - millisecondsBeforeRunning! !


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
