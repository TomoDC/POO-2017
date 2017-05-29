!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro otroUnMetro dosMetros cienCentimetros thousandMillimeter halfMeter zeroMeter factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:01:34'!
test01OneMeterShouldBeEqualToOneMeter
	
	self assert: unMetro equals: otroUnMetro! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:05:39'!
test02MetersAddCorrectly

	self assert: (unMetro + unMetro) equals: dosMetros! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:04:02'!
test03MetersEquivalentToCentimeters

	self assert: unMetro equals: cienCentimetros
	
	
	! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:05:44'!
test04CentimetersEquivalentToMeters
	
	self assert: cienCentimetros equals: unMetro
	
	
	! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:05:30'!
test05CentimetersEqualToThemselves
	
	self assert: cienCentimetros equals: cienCentimetros
	
	
	! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:06:10'!
test06CentimetersEquivalentToMillimeters
	
	self assert: cienCentimetros equals: thousandMillimeter! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:15:02'!
test07DistancesAreSubtractedCorrectly

	self assert: dosMetros - cienCentimetros equals: thousandMillimeter.
	self assert: cienCentimetros - unMetro equals: zeroMeter.
	self assert: thousandMillimeter - cienCentimetros equals: zeroMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:15:47'!
test08MetersAreMultipliedByNumbersCorrectly

	self assert: unMetro * 2 equals: dosMetros ! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:17:33'!
test09NumbersAreMultipliedByDistancesCorrectly
	self assert: 2 * unMetro equals: dosMetros.
	self assert: 2 * cienCentimetros equals: dosMetros.
	self assert: 2 * thousandMillimeter equals: dosMetros.! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:19:26'!
test10DistancesAreDividedCorrectly
	self assert: unMetro / 2 equals: halfMeter.
	self assert: cienCentimetros / 2 equals: halfMeter.
	self assert: thousandMillimeter / 2 equals: halfMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/23/2017 21:27:11'!
test11DistancesAreAddedCorrectly
	self assert: unMetro + cienCentimetros equals: dosMetros.
	self assert: unMetro + thousandMillimeter equals: dosMetros.
	self assert: cienCentimetros + unMetro equals: dosMetros.
	self assert: thousandMillimeter + unMetro equals: dosMetros.! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/25/2017 01:33:17'!
test12DistanceFactoryAnswersMessages
	"habría que ver que devuelven lo que queremos?"
	factory minusOneMeter.
	factory oneCentimeter.
	factory oneHundredCentimeters.
	factory oneMeter.
	factory twoHundredCentimeters.
	factory twoMeters.
	factory zeroMeters.! !


!DistanceTest methodsFor: 'setUp' stamp: 'FG 5/25/2017 01:20:45'!
setUp

	factory := DistanceFactory new.
	unMetro := Meter amount: 1.
	otroUnMetro := Meter amount: 1.
	dosMetros := Meter amount: 2.
	cienCentimetros := Centimeter amount: 100.
	thousandMillimeter := Millimeter amount: 1000.
	halfMeter := Meter amount: (1 / 2).
	zeroMeter := Meter amount: 0.! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'converting' stamp: 'FG 5/23/2017 20:06:11'!
asCentimeter
	self subclassResponsibility ! !

!Distance methodsFor: 'converting' stamp: 'FG 5/23/2017 20:05:52'!
asMeter
	self subclassResponsibility ! !

!Distance methodsFor: 'converting' stamp: 'FG 5/23/2017 20:06:16'!
asMillimeter
	self subclassResponsibility ! !


!Distance methodsFor: 'arithmetic' stamp: 'FG 5/23/2017 21:28:34'!
* aNumber
	^self class amount: (self amount * aNumber)! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 5/23/2017 21:30:31'!
+ aDistance
	^self class amount: (self amount + (self class from: aDistance) amount)! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 5/23/2017 21:32:17'!
- aDistance 
	^self class amount: (self amount - (self class from: aDistance) amount)! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 5/23/2017 21:29:18'!
/ aNumber
	^self class amount: (self amount / aNumber)! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 5/23/2017 21:18:06'!
adaptToNumber: aNumber andSend: aSymbol 
	
	"Operation must be commutative"
	^self perform: aSymbol with: aNumber! !


!Distance methodsFor: 'comparing' stamp: 'FG 5/23/2017 21:33:03'!
= aDistance 
	^self amount = (self class from: aDistance) amount! !


!Distance methodsFor: 'accessing' stamp: 'T 5/29/2017 18:25:21'!
amount
	self subclassResponsibility ! !


!Distance methodsFor: 'initialization' stamp: 'T 5/29/2017 18:26:27'!
initializeWithAmount: anAmount
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'as yet unclassified' stamp: 'FG 5/23/2017 21:20:20'!
from: aDistance
	self subclassResponsibility ! !


!classDefinition: #Centimeter category: #'Distance-Solution'!
Distance subclass: #Centimeter
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Centimeter methodsFor: 'converting' stamp: 'FG 5/23/2017 19:48:21'!
asCentimeter
	^self! !

!Centimeter methodsFor: 'converting' stamp: 'FG 5/23/2017 19:54:19'!
asMeter
	^Meter amount: (amount / 100)! !

!Centimeter methodsFor: 'converting' stamp: 'FG 5/23/2017 21:12:58'!
asMillimeter
	^Millimeter amount: (amount * 10)! !


!Centimeter methodsFor: 'initialization' stamp: 'FG 5/23/2017 19:34:34'!
initializeWithAmount: anAmount
	amount := anAmount! !


!Centimeter methodsFor: 'accessing' stamp: 'FG 5/23/2017 19:45:52'!
amount
	^amount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Centimeter class' category: #'Distance-Solution'!
Centimeter class
	instanceVariableNames: ''!

!Centimeter class methodsFor: 'as yet unclassified' stamp: 'FG 5/23/2017 19:34:14'!
amount: anAmount 
	^self new initializeWithAmount: anAmount! !

!Centimeter class methodsFor: 'as yet unclassified' stamp: 'FG 5/23/2017 21:31:22'!
from: aDistance
	^aDistance asCentimeter! !


!classDefinition: #Meter category: #'Distance-Solution'!
Distance subclass: #Meter
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Meter methodsFor: 'converting' stamp: 'FG 5/23/2017 19:44:18'!
asCentimeter
	^Centimeter amount: (amount * 100)! !

!Meter methodsFor: 'converting' stamp: 'FG 5/23/2017 19:42:13'!
asMeter
	^self! !

!Meter methodsFor: 'converting' stamp: 'FG 5/23/2017 21:14:09'!
asMillimeter
	^Millimeter amount: (amount * 1000)! !


!Meter methodsFor: 'initialization' stamp: 'FG 5/23/2017 19:33:10'!
initializeWithAmount: anAmount
	amount := anAmount! !


!Meter methodsFor: 'accessing' stamp: 'FG 5/23/2017 19:46:03'!
amount

	^ amount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Meter class' category: #'Distance-Solution'!
Meter class
	instanceVariableNames: ''!

!Meter class methodsFor: 'as yet unclassified' stamp: 'FG 5/23/2017 19:32:50'!
amount: anAmount
	^self new initializeWithAmount: anAmount! !

!Meter class methodsFor: 'as yet unclassified' stamp: 'FG 5/23/2017 21:31:05'!
from: aDistance
	^aDistance asMeter! !


!classDefinition: #Millimeter category: #'Distance-Solution'!
Distance subclass: #Millimeter
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Millimeter methodsFor: 'converting' stamp: 'FG 5/23/2017 19:54:05'!
asCentimeter
	^Centimeter amount: (amount / 10)! !

!Millimeter methodsFor: 'converting' stamp: 'FG 5/23/2017 20:00:46'!
asMeter
	^Meter amount: (amount / 1000)! !

!Millimeter methodsFor: 'converting' stamp: 'T 5/29/2017 17:15:12'!
asMillimeter
	^self! !


!Millimeter methodsFor: 'initialization' stamp: 'FG 5/23/2017 19:51:21'!
initializeWithAmount: anAmount 
	amount := anAmount! !


!Millimeter methodsFor: 'accessing' stamp: 'FG 5/23/2017 21:13:15'!
amount
	^amount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Millimeter class' category: #'Distance-Solution'!
Millimeter class
	instanceVariableNames: ''!

!Millimeter class methodsFor: 'as yet unclassified' stamp: 'FG 5/23/2017 19:51:01'!
amount: anAmount
	^self new initializeWithAmount: anAmount! !

!Millimeter class methodsFor: 'as yet unclassified' stamp: 'FG 5/23/2017 21:31:16'!
from: aDistance
	^aDistance asMillimeter! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 5/25/2017 01:17:25'!
minusOneMeter

	^Meter amount: -1! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 5/25/2017 01:18:41'!
oneCentimeter

	^Centimeter amount: 1! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 5/25/2017 01:19:00'!
oneHundredCentimeters

	^Centimeter amount: 100! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 5/25/2017 01:19:11'!
oneMeter

	^Meter amount: 1! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 5/25/2017 01:19:27'!
twoHundredCentimeters

	^Centimeter amount: 200! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 5/25/2017 01:20:05'!
twoMeters

	^Meter amount: 2! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 5/25/2017 01:20:16'!
zeroMeters

	^Meter amount: 0! !
