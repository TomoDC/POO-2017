!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro otroUnMetro dosMetros cienCentimetros thousandMillimeter halfMeter zeroMeter factory diezKilometros unKilometro milMetros tresMetros'
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

!DistanceTest methodsFor: 'testing' stamp: 'T 5/30/2017 01:31:27'!
test12DistancesAreComparedWithGreaterThanCorrectly
	self assert: diezKilometros > unMetro.
	self assert: diezKilometros > unKilometro.
	self assert: diezKilometros > cienCentimetros.
	self assert: diezKilometros > thousandMillimeter.
	self assert: dosMetros > thousandMillimeter.
	self assert: cienCentimetros > halfMeter.
	self assert: thousandMillimeter > halfMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'T 5/30/2017 01:45:13'!
test13DistancesAreComparedWithLessThanCorrectly
	self assert: unMetro < diezKilometros.
	self assert: cienCentimetros < diezKilometros.
	self assert: thousandMillimeter < diezKilometros.
	self assert: unKilometro < diezKilometros .! !

!DistanceTest methodsFor: 'testing' stamp: 'T 5/30/2017 01:51:31'!
test14DistancesAreComparedWithGreaterOrEqualThanCorrectly
	self assert: diezKilometros >= unMetro.
	self assert: milMetros >= unKilometro.
	self assert: unKilometro >= milMetros.
	self assert: dosMetros >= thousandMillimeter.
	self assert: cienCentimetros >= halfMeter.
	self assert: cienCentimetros >= cienCentimetros.
	self assert: thousandMillimeter >= halfMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'T 5/30/2017 01:53:07'!
test15DistancesAreComparedWithLessOrEqualThanCorrectly
	self assert: unMetro <= diezKilometros.
	self assert: cienCentimetros <= diezKilometros.
	self assert: thousandMillimeter <= diezKilometros.
	self assert: unKilometro <= diezKilometros .
	self assert: unMetro <= cienCentimetros.
	self assert: milMetros <= unKilometro.! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/30/2017 18:47:11'!
test16DistanceIntervalsKnowTheirBounds
	| interval |
	interval := unMetro to: tresMetros.
	self assert: (interval first) equals: unMetro.
	self assert: (interval last) equals: tresMetros.! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/30/2017 18:47:36'!
test17DistanceIntervalsKnowTheirStep
	| interval |
	interval := unMetro to: tresMetros by: unMetro.
	self assert: (interval step) equals: unMetro.! !

!DistanceTest methodsFor: 'testing' stamp: 'FG 5/30/2017 18:51:09'!
test18DistanceIntervalsCanBeIterated
	| i meterInterval numberInterval |
	meterInterval := unMetro to: tresMetros by: unMetro.
	numberInterval := 1 to: 3 by: 1.
	i := 1.
	meterInterval do: [ :aDistance |
		self assert: (aDistance amount) equals: (numberInterval at: i).
		i := i + 1.
	].! !


!DistanceTest methodsFor: 'setUp' stamp: 'FG 5/30/2017 18:39:37'!
setUp

	factory := DistanceFactory new.
	unMetro := Meter amount: 1.
	otroUnMetro := Meter amount: 1.
	dosMetros := Meter amount: 2.
	cienCentimetros := Centimeter amount: 100.
	thousandMillimeter := Millimeter amount: 1000.
	halfMeter := Meter amount: (1 / 2).
	zeroMeter := Meter amount: 0.
	diezKilometros  := Kilometer amount: 10.
	unKilometro := Kilometer amount: 1.
	milMetros  := Meter amount: 1000.
	tresMetros := Meter amount: 3.! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'converting' stamp: 'FG 5/23/2017 20:06:11'!
asCentimeter
	self subclassResponsibility ! !

!Distance methodsFor: 'converting' stamp: 'T 5/30/2017 01:41:34'!
asKilometer
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


!Distance methodsFor: 'comparing' stamp: 'T 5/30/2017 01:45:52'!
< aDistance 
	^self amount < (self class from: aDistance) amount! !

!Distance methodsFor: 'comparing' stamp: 'T 5/30/2017 01:53:43'!
<= aDistance 
	^self amount <= (self class from: aDistance) amount! !

!Distance methodsFor: 'comparing' stamp: 'FG 5/23/2017 21:33:03'!
= aDistance 
	^self amount = (self class from: aDistance) amount! !

!Distance methodsFor: 'comparing' stamp: 'T 5/30/2017 01:26:01'!
> aDistance 
	^self amount > (self class from: aDistance) amount! !

!Distance methodsFor: 'comparing' stamp: 'T 5/30/2017 01:48:50'!
>= aDistance 
	^self amount >= (self class from: aDistance) amount! !


!Distance methodsFor: 'accessing' stamp: 'T 5/29/2017 18:25:21'!
amount
	self subclassResponsibility ! !


!Distance methodsFor: 'initialization' stamp: 'T 5/29/2017 18:26:27'!
initializeWithAmount: anAmount
	self subclassResponsibility ! !


!Distance methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:40:50'!
to: aDistance
	^DistanceInterval from: self to: (self class from: aDistance) by: (self class amount: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:48:23'!
to: aLastDistance by: aStepDistance 
	^DistanceInterval from: self to: (self class from: aLastDistance) by: (self class from: aStepDistance )! !

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

!Centimeter methodsFor: 'converting' stamp: 'T 5/30/2017 01:36:21'!
asKilometer
	^Kilometer amount: (amount / 100000).! !

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

!Centimeter class methodsFor: 'instance creation' stamp: 'FG 5/23/2017 19:34:14'!
amount: anAmount 
	^self new initializeWithAmount: anAmount! !


!Centimeter class methodsFor: 'converting' stamp: 'FG 5/23/2017 21:31:22'!
from: aDistance
	^aDistance asCentimeter! !


!classDefinition: #Kilometer category: #'Distance-Solution'!
Distance subclass: #Kilometer
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Kilometer methodsFor: 'initialization' stamp: 'T 5/30/2017 01:20:09'!
initializeWithAmount: anAmount
	amount := anAmount! !


!Kilometer methodsFor: 'accessing' stamp: 'T 5/30/2017 01:26:34'!
amount
	^amount ! !


!Kilometer methodsFor: 'converting' stamp: 'T 5/30/2017 01:40:36'!
asCentimeter
	^Centimeter amount: (amount * 100000).! !

!Kilometer methodsFor: 'converting' stamp: 'T 5/30/2017 01:32:47'!
asKilometer
	^self! !

!Kilometer methodsFor: 'converting' stamp: 'T 5/30/2017 01:39:54'!
asMeter
	^Meter amount: (amount * 1000).! !

!Kilometer methodsFor: 'converting' stamp: 'T 5/30/2017 01:41:01'!
asMillimeter
	^Millimeter amount: (amount * 1000000).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Kilometer class' category: #'Distance-Solution'!
Kilometer class
	instanceVariableNames: ''!

!Kilometer class methodsFor: 'instance creation' stamp: 'T 5/30/2017 01:19:29'!
amount: anAmount
	^self new initializeWithAmount: anAmount! !


!Kilometer class methodsFor: 'converting' stamp: 'T 5/30/2017 01:27:23'!
from: aDistance
	^aDistance asKilometer.! !


!classDefinition: #Meter category: #'Distance-Solution'!
Distance subclass: #Meter
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Meter methodsFor: 'converting' stamp: 'FG 5/23/2017 19:44:18'!
asCentimeter
	^Centimeter amount: (amount * 100)! !

!Meter methodsFor: 'converting' stamp: 'T 5/30/2017 01:29:46'!
asKilometer
	^Kilometer amount: (amount / 1000)! !

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

!Meter class methodsFor: 'instance creation' stamp: 'FG 5/23/2017 19:32:50'!
amount: anAmount
	^self new initializeWithAmount: anAmount! !


!Meter class methodsFor: 'converting' stamp: 'FG 5/23/2017 21:31:05'!
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

!Millimeter methodsFor: 'converting' stamp: 'T 5/30/2017 01:37:32'!
asKilometer
	^Kilometer amount: (amount / 1000000).! !

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

!Millimeter class methodsFor: 'instance creation' stamp: 'FG 5/23/2017 19:51:01'!
amount: anAmount
	^self new initializeWithAmount: anAmount! !


!Millimeter class methodsFor: 'converting' stamp: 'FG 5/23/2017 21:31:16'!
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


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
Object subclass: #DistanceInterval
	instanceVariableNames: 'first last step'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:53:01'!
do: aBlockClosure 
	(self first amount) to: (self last amount) by: (self step amount) do: [ :anAmount |
		aBlockClosure value: (self first class amount: anAmount)
	].! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:43:41'!
first
	^first! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:43:23'!
initializeWithFirst: aFirstDistance last: aLastDistance step: aStepDistance 
	first := aFirstDistance.
	last := aLastDistance.
	step := aStepDistance.! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:43:50'!
last
	^last! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:48:32'!
step
	^step! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:42:49'!
from: aFirstDistance to: aLastDistance by: aStepDistance 
	^self new initializeWithFirst: aFirstDistance last: aLastDistance step: aStepDistance.! !
