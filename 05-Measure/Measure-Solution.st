!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'converting' stamp: 'FG 6/8/2017 17:23:57'!
convertTo: aUnit 
	self unit = aUnit ifTrue: [^self] ifFalse: [
		^self class amount: (self amount * (self unit factorTo: aUnit)) unit: aUnit
	].! !

!Measure methodsFor: 'converting' stamp: 'FG 6/1/2017 19:29:56'!
initializeWithAmount: aNumber unit: aUnit
	amount := aNumber.
	unit := aUnit.! !


!Measure methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:23:00'!
* aNumber
	^self unit amount: (self amount * aNumber)! !

!Measure methodsFor: 'arithmetic' stamp: 'FG 6/6/2017 20:10:26'!
+ aDistance
	(self unit base = aDistance unit base) ifTrue: [
		^self unit amount: (self amount + (aDistance convertTo: self unit) amount)
	] ifFalse: [
		^CompoundMeasure of: {self . aDistance}
	]! !

!Measure methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 19:55:14'!
- aDistance 
	^self + (aDistance negated)! !

!Measure methodsFor: 'arithmetic' stamp: 'FG 6/8/2017 17:30:10'!
/ aDividend
	(aDividend isKindOf: Number) ifTrue: [
		^self unit amount: (self amount / aDividend )]
	ifFalse: [
		^self class amount: self amount unit: self unit / aDividend ]
! !

!Measure methodsFor: 'arithmetic' stamp: 'FG 5/23/2017 21:18:06'!
adaptToNumber: aNumber andSend: aSymbol 
	
	"Operation must be commutative"
	^self perform: aSymbol with: aNumber! !

!Measure methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:46:27'!
hash
	^(self amount * self unit factorToBase) hash! !

!Measure methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:36:08'!
isZero
	^self amount isZero! !

!Measure methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:23:21'!
negated
	^self unit amount: (self amount negated)! !


!Measure methodsFor: 'comparing' stamp: 'FG 6/1/2017 19:51:52'!
< aDistance 
	^self amount < (aDistance convertTo: (self unit)) amount! !

!Measure methodsFor: 'comparing' stamp: 'FG 6/8/2017 17:28:40'!
= aDistance 
	^(aDistance isKindOf: self class) and: [
		self amount = 0 & aDistance amount = 0 | ((self unit compatibleWith: aDistance unit) and: [self amount = (aDistance convertTo: (self unit)) amount])
	].! !


!Measure methodsFor: 'accessing' stamp: 'FG 6/1/2017 19:51:21'!
amount
	^amount! !

!Measure methodsFor: 'accessing' stamp: 'FG 6/1/2017 19:25:48'!
unit
	^unit! !


!Measure methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:57:43'!
to: aDistance
	^MeasureInterval from: self to: (aDistance convertTo: self unit) by: (self unit amount: 1)! !

!Measure methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:57:39'!
to: aLastDistance by: aStepDistance 
	^MeasureInterval from: self to: (aLastDistance convertTo: self unit) by: (aStepDistance convertTo: self unit)! !


!Measure methodsFor: 'printing' stamp: 'FG 6/8/2017 17:59:34'!
printOn: aStream
	self amount printOn: aStream.
	aStream nextPutAll: ' '.
	self unit printOn: aStream.
	self amount > 1 ifTrue: [aStream nextPutAll: 's'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 17:28:51'!
amount: aNumber unit: aUnit
	^(self new initializeWithAmount: aNumber unit: aUnit)! !


!classDefinition: #MeasureInterval category: #'Measure-Solution'!
SequenceableCollection subclass: #MeasureInterval
	instanceVariableNames: 'first last step'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 21:00:42'!
at: index
	^first + ((index - 1) * step)! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:34:15'!
by
	^self step! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:33:53'!
from
	^self first! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:48:37'!
initializeWithFirst: aFirstDistance last: aLastDistance step: aStepDistance 
	first := aFirstDistance.
	last := aLastDistance convertTo: first unit.
	step := aStepDistance convertTo: first unit.! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 21:07:32'!
size
	^1 + (((last amount - first amount) abs) / (step amount abs))! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:48:32'!
step
	^step! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:34:03'!
to
	^self last! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureInterval class' category: #'Measure-Solution'!
MeasureInterval class
	instanceVariableNames: ''!

!MeasureInterval class methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:42:49'!
from: aFirstDistance to: aLastDistance by: aStepDistance 
	^self new initializeWithFirst: aFirstDistance last: aLastDistance step: aStepDistance.! !


!classDefinition: #CatedraDistanceTest category: #'Measure-Solution'!
TestCase subclass: #CatedraDistanceTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CatedraDistanceTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/18/2011 15:04'!
test01ObjectsRepresentingSameDistanceShouldBeEqual

	self assert: self oneMeter = self oneMeter.
	self assert: self oneHundredCentimeters = self oneHundredCentimeters.
	

! !

!CatedraDistanceTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/18/2011 16:50'!
test02DiferentDistancesShouldNotBeEqual

	self deny: self oneMeter = self twoMeters.
	self deny: self twoMeters = self oneMeter! !

!CatedraDistanceTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/18/2011 16:50'!
test03SameDistanceExpressWithDifferentUnitsShouldBeEqual

	self assert: self oneMeter = self oneHundredCentimeters.
	self assert: self twoMeters = self twoHundredCentimeters.

! !

!CatedraDistanceTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/19/2011 10:28'!
test04EqualsShouldBeCommutative

	self assert: (self oneMeter = self oneHundredCentimeters and: [ self oneHundredCentimeters = self oneMeter ]).
	self assert: (self twoMeters = self twoHundredCentimeters and:  [ self twoHundredCentimeters = self twoMeters ]).

! !


!CatedraDistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'FG 6/1/2017 20:39:29'!
test05UnitStringRepresentationShouldBeHumanReadable

	self assert: self meter printString = 'meter'.
	self assert: self centimeter printString = 'centimeter'.
	self assert: self decimeter printString = 'decimeter'.
	self assert: self millimeter printString = 'millimeter'.
	self assert: self decameter printString = 'decameter'.
	self assert: self hectometer printString = 'hectometer'.
	self assert: self kilometer printString = 'kilometer'.	! !

!CatedraDistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HAW 5/31/2017 11:17:17'!
test06DistanceStringRepresentationShouldBeHumanReadable

	self assert: self oneMeter printString = '1 meter'.
	self assert: self twoMeters printString = '2 meters'.
	self assert: self oneHundredCentimeters printString = '100 centimeters'.
	
! !

!CatedraDistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HernanWilkinson 4/19/2011 10:26'!
test07aDistanceAmountShouldBeTheExpectedAmount

	self assert: self oneMeter amount = 1.
	self assert: self twoMeters amount = 2.
	self assert: self oneHundredCentimeters amount = 100.
	self assert: self twoHundredCentimeters amount = 200.
! !

!CatedraDistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test07bDistanceUnitShouldBeTheExpectedUnit

	self assert: self oneMeter unit = self meter.
	self assert: self twoMeters unit = self meter.
	self assert: self oneHundredCentimeters unit = self centimeter.
	self assert: self twoHundredCentimeters unit = self centimeter.! !

!CatedraDistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HAW 5/31/2017 11:12:16'!
test07cDifferentDistanceUnitsShouldBeDifferent

	| units unitsSet |
	
	units := self distanceUnits.
	unitsSet := units asSet.
	
	self assert: units size equals: unitsSet size.
	self assert: (unitsSet includesAllOf: units).! !

!CatedraDistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test07dDistancesCanBeConvertedToDifferentUnits

	"A partir de los test de igualdad, se deben haber dado cuenta que debemos poder
	convertir distancias a distintas unidades... y que ademas dos distancias de distintas unidades
	pueden ser iguales... Por lo tanto Â¿por quÃ© no hacer esta caracteristica de las distancias explicita?
	Veran que luego se torna muy util
	
	Respecto de como esta escrito el test, para no tener que escribir los assert para oneMeter y oneHundredCentimeters 
	creo un array y lo recorro... Â¿Se podria escribir menos aun en este test?
	
	Y por quÃ© se asserta sobre el amount y luego la unidad y no directametne sobre la distancia completa. ej:
	self assert: (aDistance converTo: self meter) = self oneMeter
	"
	
	(Array with: self oneMeter with: self oneHundredCentimeters) do: [ :aDistance |
		self assert: (aDistance convertTo: self meter) amount = 1.
		self assert: (aDistance convertTo: self meter) unit = self meter.
		
		self assert: (aDistance convertTo: self decimeter) amount = 10.
		self assert: (aDistance convertTo: self decimeter) unit = self decimeter.
		
		self assert: (aDistance convertTo: self centimeter) amount = 100.
		self assert: (aDistance convertTo: self centimeter) unit = self centimeter.
		
		self assert: (aDistance convertTo: self millimeter) amount = 1000.
		self assert: (aDistance convertTo: self millimeter) unit = self millimeter.
	
		self assert: (aDistance convertTo: self decameter) amount = (1/10).
		self assert: (aDistance convertTo: self decameter) unit = self decameter.
		
		self assert: (aDistance convertTo: self hectometer) amount = (1/100).
		self assert: (aDistance convertTo: self hectometer) unit = self hectometer.
	
		self assert: (aDistance convertTo: self kilometer) amount = (1/1000).
		self assert: (aDistance convertTo: self kilometer) unit = self kilometer ]! !


!CatedraDistanceTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test08aComparingDistancesWithOtherObjectsShouldReturnFalse

	"El igual no debe generar ningun tipo de error por mas que se comparen objetos
	de distintos tipos
	Fijense como se crea una instancia de Object sin ningun tipo de problema... Â¿quÃ© representa?"

	self deny: self oneMeter = Object new.
	self deny: Object new = self oneMeter! !

!CatedraDistanceTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test08bDistancesThatAreEqualShouldReturnTheSameHash

	"Debido a como funcionan los diccionarios, cuando dos objetos son iguales deben
	tener es mismo hash. La inversa no es verdad"
	
	self assert: self oneMeter hash=self oneMeter hash.
	self assert: self oneMeter hash=self oneHundredCentimeters hash.

	
	
! !

!CatedraDistanceTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test08cCopiesOfTheSameDistanceShouldBeEqual

	"Dos objetos que ocupan distintas posiciones de memoria pero representan
	la misma entidad de la realidad, deben devolver true cuando se los compara por igual, puesto
	que representan la misma entidad de la realidad.
	Por lo tanto, el mensaje #= significa 'Â¿representan el mismo ente de la realidad?'
	mientras que el mensaje #== significa Â¿ocupan la misma posicion de memoria?"

	| originalOneMeter copiedOneMeter |

	"Al objeto oneMeter lo copio para asegurarme de tener uno oneMeter en otra posicion de memoria"

	originalOneMeter := self oneMeter.
	copiedOneMeter := originalOneMeter copy.

	"Me aseguro que ocupen distinta posicion de memoria"
	self deny: originalOneMeter == copiedOneMeter.

	"Ahora me aseguro que sean iguales"
	self assert: originalOneMeter = copiedOneMeter! !


!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:34'!
test09AddingDistancesOfSameUnitShouldReturnADistanceRepresentingTheAddingDistances

	self assert: (self oneMeter + self oneMeter) = self twoMeters

! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:34'!
test10AddingDistancesOfDifferentUnitShouldReturnADistanceRepresentingTheAddingDistances

	self assert: (self oneMeter + self oneHundredCentimeters) = self twoMeters.
	self assert: (self oneMeter + self oneHundredCentimeters) = self twoHundredCentimeters.

! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:35'!
test11AddingDistancesIsCommutative

	self assert: (self oneMeter + self twoMeters)=(self twoMeters + self oneMeter)


! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:35'!
test12AddingDistancesIsAssociative

	self assert: 
		((self oneMeter + self oneMeter) + self twoMeters) = 
		(self oneMeter + (self oneMeter + self twoMeters))


! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:41'!
test12aAddingDistancesKeepsDistanceInmutability

	| oneMeter |
	
	oneMeter := self oneMeter.
	oneMeter + oneMeter.
	
	self assert: oneMeter = self oneMeter.
	


! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:36'!
test13aNegatingADistanceNegatesItsAmount

	self assert: self oneMeter negated = self minusOneMeter.
	
! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:36'!
test13bNegatingADistanceIsReflective

	self assert: self oneMeter negated negated=self oneMeter.
	
! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:38'!
test14SubtractingDistancesOfSameUnitShouldReturnADistanceRepresentingTheSubtractedDistances

	self assert: (self twoMeters - self oneMeter) = self oneMeter.
	self assert: (self oneMeter - self oneMeter) = self zeroMeters.
	self assert: (self oneMeter - self twoMeters) = self oneMeter negated
	

	! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:40'!
test15SubtractingDistancesOfDifferentUnitShouldReturnADistanceRepresentingTheSubtractedDistances

	self assert: (self twoMeters - self oneHundredCentimeters) = self oneMeter.
	self assert: (self oneMeter - self oneHundredCentimeters) = self zeroMeters.
	self assert: (self oneHundredCentimeters - self twoMeters) = self oneMeter negated
	

	! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:40'!
test16SubtractingDistancesIsAssociative

	self assert: 
		((self twoMeters - self oneMeter) - self oneMeter) = 
		(self twoMeters - (self oneMeter + self oneMeter)).

	

	! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:41'!
test16aSubtractingDistancesKeepsDistanceInmutability

	| oneMeter |
	
	oneMeter := self oneMeter.
	oneMeter - oneMeter.
	
	self assert: oneMeter = self oneMeter.
	


! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:45'!
test17aDistancesCanBeMultiplyByAnInteger

	self assert: self oneMeter * 1 = self oneMeter.
	self assert: self oneMeter * 2 = self twoMeters.
	self assert: self oneMeter * 0 = self zeroMeters.
! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HAW 5/31/2017 11:16:54'!
test17bDistancesCanBeMultiplyByAFraction

	self assert: (self oneMeter * (2/3)) amount = (2/3).
	self assert: (self twoMeters * (2/3)) amount = (2 * (2/3)).
! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HAW 5/31/2017 11:17:22'!
test17cDistancesCanBeMultiplyByAFloat

	self assert: (self oneMeter * 2.5) amount = 2.5.
	self assert: (self twoMeters * 2.5) amount = (2 * 2.5).
! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:47'!
test18MultiplicationKeepsDistanceInmutability

	| oneMeter |
	
	oneMeter := self oneMeter.
	oneMeter * 2.
	
	self assert: oneMeter = self oneMeter.
	


! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:48'!
test19aDistancesCanBeDividedByAnInteger

	self assert: (self oneMeter / 1) = self oneMeter.
	self assert: (self twoMeters / 2) = self oneMeter.


! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/21/2011 17:24'!
test19bDistancesCanBeDividedByAFraction

	self assert: (self twoMeters / (1/3)) amount = 6.




! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:49'!
test19cDistancesCanBeDividedByAFloat

	self assert: (self twoMeters / 2.5) amount = (2/2.5).




! !

!CatedraDistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:49'!
test20DivisionKeepsDistanceInmutability

	| oneMeter |
	
	oneMeter := self oneMeter.
	oneMeter / 2.
	
	self assert: oneMeter = self oneMeter.
	


! !


!CatedraDistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HAW 5/31/2017 11:19:04'!
test21DistancesProvideATotalOrder

	self assert: (self distanceExamples allSatisfy: [ :aDistance | aDistance < (aDistance + self oneMeter)])

! !

!CatedraDistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HAW 5/31/2017 11:19:09'!
test22DistancesCanBeComparedWithGreaterThan

	self assert: (self distanceExamples allSatisfy: [ :aDistance | (aDistance + self oneMeter) > aDistance ])
! !

!CatedraDistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HAW 5/31/2017 11:19:16'!
test23DistancesCanBeComparedWithLessThanOrEqual

	self assert: (self distanceExamples allSatisfy: [ :aDistance | aDistance <= aDistance and: [aDistance <= (aDistance + self oneMeter)]])

	
! !

!CatedraDistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HAW 5/31/2017 11:19:20'!
test24DistancesCanBeComparedWithGreaterThanOrEqual

	self assert: (self distanceExamples allSatisfy: [ :aDistance | aDistance >= aDistance and: [(aDistance + self oneMeter) >= aDistance]])
! !

!CatedraDistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:13'!
test25MaxReturnsTheMaximumBetweenTwoDistances

	self assert: (self twoMeters max: self oneMeter) = self twoMeters.
	self assert: (self oneMeter max: self twoMeters) = self twoMeters.

	self assert: (self twoMeters max: self oneHundredCentimeters) = self twoMeters.
	self assert: (self oneHundredCentimeters max: self twoMeters) = self twoMeters.

	
! !

!CatedraDistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:14'!
test26MinReturnsTheMinimumBetweenTwoDistances

	self assert: (self twoMeters min: self oneMeter) = self oneMeter.
	self assert: (self oneMeter min: self twoMeters) = self oneMeter.

	self assert: (self twoMeters min: self oneHundredCentimeters) = self oneHundredCentimeters.
	self assert: (self oneHundredCentimeters min: self twoMeters) = self oneHundredCentimeters.

	
! !

!CatedraDistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:14'!
test27BetweenAndReturnsTrueIfADistanceIsBetweenOtherTwoDistances

	self assert: (self oneMeter between: self zeroMeters and: self twoMeters).
	self assert: (self oneHundredCentimeters between: self zeroMeters and: self twoMeters).
	
	self deny: (self twoMeters between: self zeroMeters and: self oneMeter).
	self deny: (self twoHundredCentimeters between: self zeroMeters and: self oneMeter).

! !


!CatedraDistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:16'!
test28IntervalOfDistancesCanBeCreatedBecauseTheyDefineATotalOrder

	self assert: (self oneMeter to: self twoMeters) from=self oneMeter.
	self assert: (self oneMeter to: self twoMeters) to=self twoMeters.
	self assert: (self oneMeter to: self twoMeters) by=self oneMeter.	

	self assert: (self oneHundredCentimeters to: self twoMeters) from=self oneMeter.
	self assert: (self oneHundredCentimeters to: self twoMeters) to=self twoMeters.
	self assert: (self oneHundredCentimeters to: self twoMeters) by=self oneCentimeter.	
	! !

!CatedraDistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:16'!
test29DistanceIntervalStepCanBeAnyDistance

	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) from=self zeroMeters.
	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) to=(self twoMeters * 2).
	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) by=self twoMeters.

	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) from=(self twoMeters * 2).
	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) to=self zeroMeters.
	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) by=self twoMeters negated

	! !

!CatedraDistanceTest methodsFor: '6 - Test interval protocol' stamp: 'FG 6/1/2017 20:50:21'!
test30DistanceIntervalSizeReturnsTheNumberOfDistancesOfTheInterval

	self assert: 5 equals: (self zeroMeters to: (self twoMeters * 2) ) size.
	self assert: 5 equals: ((self twoMeters * 2) to: self zeroMeters by: self oneMeter negated) size.
! !

!CatedraDistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:19'!
test31DistanceIntervalCanBeEnumeratedUsingDo

	| value |
	
	value := 1.
	(self oneMeter to: (self oneMeter * 10)) do: [ :aDistance |
		self assert: aDistance amount = value.
		value := value + 1 ].
	
	self assert: value = 11
! !

!CatedraDistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:27'!
test32DistanceIntervalCanBeEnumeratedWithSpecificStep

	| value initialDistance byDistance finalDistance |
	
	initialDistance := self oneMeter.
	byDistance := self twoMeters.
	finalDistance := initialDistance * 9.
	value := initialDistance amount.
		
	(initialDistance to: finalDistance by:  byDistance) do: [ :aDistance |
		self assert: aDistance amount = value.
		value := value + byDistance amount ].
	
	self assert:  value = (finalDistance amount + byDistance amount)
! !




!CatedraDistanceTest methodsFor: 'setup' stamp: 'FG 6/8/2017 18:59:05'!
setUp

	| factoryClass |
	
	factoryClass := Smalltalk classNamed: #MeasureFactory.
	self assert: factoryClass notNil description: 'No se entrego la clase DistanceFactory'.
	
	factory := factoryClass.! !


!CatedraDistanceTest methodsFor: 'Measure units' stamp: 'FG 6/6/2017 20:26:09'!
centimeter

	^Unit centimeter! !

!CatedraDistanceTest methodsFor: 'Measure units' stamp: 'FG 6/6/2017 20:26:14'!
decameter
	
	^Unit decameter! !

!CatedraDistanceTest methodsFor: 'Measure units' stamp: 'FG 6/6/2017 20:26:18'!
decimeter
	
	^Unit decimeter! !

!CatedraDistanceTest methodsFor: 'Measure units' stamp: 'HAW 5/31/2017 12:37:50'!
distanceUnits 

	"¿Quién se anima a explicar cómo funciona este método? 
	¿Por qué está hecho así? "
		
	| unitsCategory unitMessageNames |
	
	unitsCategory := self class organization categoryOfElement: thisContext method selector.
	unitMessageNames := (self class organization listAtCategoryNamed:  unitsCategory) reject: [ :aMessageName | aMessageName = thisContext method selector ].
	
	 ^ unitMessageNames collect: [ :aMessageName | self perform: aMessageName ]
	
! !

!CatedraDistanceTest methodsFor: 'Measure units' stamp: 'FG 6/6/2017 20:26:17'!
hectometer
	
	^Unit hectometer! !

!CatedraDistanceTest methodsFor: 'Measure units' stamp: 'FG 6/6/2017 20:26:15'!
kilometer
	
	^Unit kilometer! !

!CatedraDistanceTest methodsFor: 'Measure units' stamp: 'FG 6/6/2017 20:26:11'!
meter

	^Unit meter! !

!CatedraDistanceTest methodsFor: 'Measure units' stamp: 'FG 6/6/2017 20:26:13'!
millimeter
	
	^Unit millimeter! !


!CatedraDistanceTest methodsFor: 'Measure measures' stamp: 'HAW 5/31/2017 11:20:12'!
distanceExamples

	"¿Quién se anima a explicar cómo funciona este método? 
	¿Por qué está hecho así? "
		
	| distanceCategory distanceMessageNames |
	
	distanceCategory := self class organization categoryOfElement: thisContext method selector.
	distanceMessageNames := (self class organization listAtCategoryNamed:  distanceCategory) reject: [ :aMessageName | aMessageName = thisContext method selector ].
	
	 ^ distanceMessageNames collect: [ :aMessageName | self perform: aMessageName ]
	
! !

!CatedraDistanceTest methodsFor: 'Measure measures' stamp: 'HAW 5/31/2017 11:03:32'!
minusOneMeter 
	
	^factory minusOneMeter! !

!CatedraDistanceTest methodsFor: 'Measure measures' stamp: 'HAW 5/31/2017 11:03:45'!
oneCentimeter
	
	^factory oneCentimeter ! !

!CatedraDistanceTest methodsFor: 'Measure measures' stamp: 'HAW 5/31/2017 11:03:53'!
oneHundredCentimeters
	
	^factory oneHundredCentimeters ! !

!CatedraDistanceTest methodsFor: 'Measure measures' stamp: 'HAW 5/31/2017 11:04:03'!
oneMeter
	
	^factory oneMeter ! !

!CatedraDistanceTest methodsFor: 'Measure measures' stamp: 'HAW 5/31/2017 11:04:18'!
twoHundredCentimeters
	
	^factory twoHundredCentimeters ! !

!CatedraDistanceTest methodsFor: 'Measure measures' stamp: 'HAW 5/31/2017 11:04:29'!
twoMeters
	
	^factory twoMeters ! !

!CatedraDistanceTest methodsFor: 'Measure measures' stamp: 'HAW 5/31/2017 11:04:38'!
zeroMeters

	^factory zeroMeters ! !


!classDefinition: #DistanceTest category: #'Measure-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro otroUnMetro dosMetros cienCentimetros thousandMillimeter halfMeter zeroMeter factory diezKilometros unKilometro milMetros tresMetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

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

!DistanceTest methodsFor: 'testing' stamp: 'FG 6/1/2017 19:24:32'!
test19DistancesHaveUnits
	self assert: (unMetro unit printString) equals: 'meter'! !


!DistanceTest methodsFor: 'setUp' stamp: 'FG 6/8/2017 18:41:49'!
setUp

	factory := MeasureFactory new.
	unMetro := Measure amount: 1 unit: (Unit meter).
	otroUnMetro := Measure amount: 1 unit: (Unit meter).
	dosMetros := Measure amount: 2 unit: (Unit meter).
	cienCentimetros := Measure amount: 100 unit: (Unit centimeter).
	thousandMillimeter := Measure amount: 1000 unit: (Unit millimeter).
	halfMeter := Measure amount: (1 / 2) unit: (Unit meter).
	zeroMeter := Measure amount: 0 unit: (Unit meter).
	diezKilometros  := Measure amount: 10 unit: (Unit kilometer).
	unKilometro := Measure amount: 1 unit: (Unit kilometer).
	milMetros  := Measure amount: 1000 unit: (Unit meter).
	tresMetros := Measure amount: 3 unit: (Unit meter).! !


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/5/2017 19:06:55'!
test01SameAmountsOfAMeasureShouldBeEqual

	self assert: (self peso amount: 1) equals: (self peso amount: 1).
	self assert: (self liter amount: 1) equals: (self liter amount: 1).! !

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/5/2017 19:20:12'!
test02AmountsOfDifferentUnitsShouldNotBeEqual

	self deny: (self peso amount: 1) = (self liter amount: 1).
	self deny: (self peso amount: 1) = (self meter amount: 1).! !

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/5/2017 19:24:18'!
test03CanOperateBetweenSameTypesOfUnit

	self assert: (self peso amount: 100) equals: (self peso amount: 50) + (self peso amount: 50).
	self assert: (self peso amount: 100) equals: (self peso amount: 150) - (self peso amount: 50).
	self assert: (self peso amount: 100) equals: (self peso amount: 50) * 2.
	self assert: (self peso amount: 100) equals: (self peso amount: 200) / 2.! !

!MeasureTest methodsFor: 'testing' stamp: 'T 6/8/2017 15:51:17'!
test04CanOperateBetweenDifferentTypesOfUnit

	self assert: ((self peso amount: 100) + (self liter amount: 100)) equals: ((self liter amount: 100) + (self peso amount: 100)).
	self assert: (self peso amount: 100) - (self liter amount: 100) equals: (self peso amount: 100) - (self liter amount: 100).
	self assert: (self peso amount: 100) + (self peso amount: 100) + (self liter amount: 100) equals: (self peso amount: 200) + (self liter amount: 100).! !

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/5/2017 20:49:02'!
test05ZeroesShouldAllBeEqual

	self assert: (self peso amount: 0) equals: (self liter amount: 0).! !

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/6/2017 20:38:50'!
test06ConversionBetweenUnitsOfDifferentTypeShouldFail

	self should: [
		((self centavo amount: 100) convertTo: self liter)
	] raise: Error - MessageNotUnderstood ! !

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/6/2017 20:41:14'!
test07ConversionBetweenUnitsOfSameTypeShouldBePossible

	self assert: ((self centavo amount: 100) convertTo: self peso) equals: (self peso amount: 1).! !

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/6/2017 20:57:42'!
test08MeasuresOfSameUnitFormATotalOrder
	self assert: (self peso amount: 1) <= (self peso amount: 2).
	self assert: (self peso amount: 1) < (self peso amount: 2).
	self assert: (self peso amount: 2) > (self peso amount: 1).
	self assert: (self peso amount: 2) >= (self peso amount: 1).
	
	self assert: (self peso amount: 1) > (self centavo amount: 2).! !

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/8/2017 19:02:41'!
test09CanRepresentMeasureOfCompoundUnits

	self assert: (self meter amount: 10) / self second equals: (self meter amount: 10) / self second.
	self assert: (self meter amount: 1000) / self second equals: (self kilometer amount: 1) / self second.
	self assert: (self meter amount: 1/3600) / self second equals: (self meter amount: 1) / self hour.
	self assert: (self meter amount: 1000/3600) / self second equals: (self kilometer amount: 1) / self hour.! !


!MeasureTest methodsFor: 'units' stamp: 'FG 6/6/2017 20:34:43'!
centavo
	^Unit centavo! !

!MeasureTest methodsFor: 'units' stamp: 'FG 6/8/2017 18:35:30'!
hour
	^Unit hour! !

!MeasureTest methodsFor: 'units' stamp: 'FG 6/8/2017 18:12:12'!
kilometer
	^Unit kilometer! !

!MeasureTest methodsFor: 'units' stamp: 'FG 6/6/2017 20:26:23'!
liter
	^Unit liter! !

!MeasureTest methodsFor: 'units' stamp: 'FG 6/6/2017 20:26:19'!
meter
	^Unit meter! !

!MeasureTest methodsFor: 'units' stamp: 'FG 6/6/2017 20:26:21'!
peso
	^Unit peso! !

!MeasureTest methodsFor: 'units' stamp: 'FG 6/8/2017 18:06:38'!
second
	^Unit second! !


!classDefinition: #CompoundMeasure category: #'Measure-Solution'!
Object subclass: #CompoundMeasure
	instanceVariableNames: 'amounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 20:42:07'!
= aCompoundMeasure
	^(aCompoundMeasure isKindOf: self class) and: [amounts = aCompoundMeasure amounts]! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 20:15:15'!
amounts
	^amounts! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 20:23:55'!
initializeWithMeasures: anArrayOfMeasures
	amounts := Dictionary new.
	anArrayOfMeasures do: [ :aMeasure | | baseUnit |
		baseUnit := aMeasure unit base.
		amounts at: baseUnit put: (aMeasure convertTo: baseUnit) amount.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundMeasure class' category: #'Measure-Solution'!
CompoundMeasure class
	instanceVariableNames: ''!

!CompoundMeasure class methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 20:10:43'!
of: anArrayOfMeasures
	^self new initializeWithMeasures: anArrayOfMeasures ! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/8/2017 18:48:37'!
centimeter

	^Unit centimeter! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/8/2017 18:48:42'!
decameter

	^Unit decameter! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/8/2017 18:48:47'!
decimeter

	^Unit decimeter! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/8/2017 18:49:10'!
hectometer

	^Unit hectometer! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/8/2017 18:48:59'!
kilometer

	^Unit kilometer! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/8/2017 18:48:28'!
meter

	^Unit meter! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/8/2017 18:48:53'!
millimeter

	^Unit millimeter! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/6/2017 20:26:28'!
minusOneMeter

	^Measure amount: -1 unit: (Unit meter)! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/6/2017 20:26:31'!
oneCentimeter

	^Measure amount: 1 unit: (Unit centimeter)! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/6/2017 20:26:30'!
oneHundredCentimeters

	^Measure amount: 100 unit: (Unit centimeter)! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/6/2017 20:26:35'!
oneMeter

	^Measure amount: 1 unit: (Unit meter)! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/6/2017 20:26:27'!
twoHundredCentimeters

	^Measure amount: 200 unit: (Unit centimeter)! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/6/2017 20:26:34'!
twoMeters

	^Measure amount: 2 unit: (Unit meter)! !

!MeasureFactory class methodsFor: 'distance' stamp: 'FG 6/6/2017 20:26:25'!
zeroMeters

	^Measure amount: 0 unit: (Unit meter)! !


!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:43:05'!
day

	^Unit day! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:43:53'!
hour

	^Unit minute! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:43:55'!
minute

	^Unit minute! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:46:36'!
oneDay

	^Unit day amount: 1! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:46:44'!
oneHour

	^Unit hour amount: 1! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:47:05'!
oneMinute
	^Unit minute amount: 1! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:47:01'!
oneSecond
	^Unit second amount: 1! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:43:47'!
second

	^Unit second! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:47:14'!
sixtyMinutes
	^Unit minute amount: 60! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:47:38'!
sixtyOneSeconds
	^Unit seconds amount: 61! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:47:44'!
sixtySeconds
	^Unit seconds amount: 60! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:47:52'!
twentyFourHours
	^Unit hour amount: 24! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:47:59'!
twoSeconds
	^Unit second amount: 2! !

!MeasureFactory class methodsFor: 'time' stamp: 'FG 6/8/2017 18:48:06'!
zeroSeconds
	^Unit second amount: 0! !


!MeasureFactory class methodsFor: 'compound' stamp: 'FG 6/8/2017 18:51:29'!
oneHundredTwentyOneMetersPerSecond

	^(Unit meter amount: 121) / Unit second! !

!MeasureFactory class methodsFor: 'compound' stamp: 'FG 6/8/2017 18:51:48'!
oneMeterPerSecond

	^(Unit meter amount: 1) / Unit second! !

!MeasureFactory class methodsFor: 'compound' stamp: 'FG 6/8/2017 18:52:29'!
twoMetersBySecond

	^(Unit meter amount: 2) / Unit second! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:24:00'!
compatibleWith: aUnit
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 20:36:11'!
centavo
	^SimpleUnit new initializeWithName: 'centavo' base: (self peso) factorToBase: 1/100! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:33'!
centimeter
	^SimpleUnit new initializeWithName: 'centimeter' base: (self meter) factorToBase: 1/100! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:44:34'!
day
	^SimpleUnit new initializeWithName: 'day' base: (self second) factorToBase: 1/(24*3600)! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:26'!
decameter
	^SimpleUnit new initializeWithName: 'decameter' base: (self meter) factorToBase: 10! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:38'!
decimeter
	^SimpleUnit new initializeWithName: 'decimeter' base: (self meter) factorToBase: 1/10! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:40'!
hectometer
	^SimpleUnit new initializeWithName: 'hectometer' base: (self meter) factorToBase: 100! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:44:10'!
hour
	^SimpleUnit new initializeWithName: 'hour' base: (self second) factorToBase: 1/3600! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:46'!
kilometer
	^SimpleUnit new initializeWithName: 'kilometer' base: (self meter) factorToBase: 1000! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:17:09'!
liter
	^SimpleUnit baseNamed: 'liter'! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:16:56'!
meter
	^SimpleUnit baseNamed: 'meter'! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:14:07'!
millimeter
	^SimpleUnit new initializeWithName: 'millimeter' base: (self meter) factorToBase: 1/1000! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:44:20'!
minute
	^SimpleUnit new initializeWithName: 'minute' base: (self second) factorToBase: 1/60! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:16:40'!
peso
	^SimpleUnit baseNamed: 'peso'! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:35:20'!
second
	^SimpleUnit baseNamed: 'second'! !


!classDefinition: #ProductUnit category: #'Measure-Solution'!
Unit subclass: #ProductUnit
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!ProductUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 17:26:24'!
base
	^self! !

!ProductUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:15:06'!
compatibleWith: aCompoundUnit 
	^self class = aCompoundUnit class and: [ (numerator compatibleWith: aCompoundUnit numerator) & denominator compatibleWith: aCompoundUnit denominator ].! !

!ProductUnit methodsFor: 'as yet unclassified' stamp: 'T 6/8/2017 16:43:55'!
denominator
	^denominator.! !

!ProductUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:20:43'!
factorTo: aCompoundUnit 
	| denominatorFactor numeratorFactor |
	numeratorFactor := self numerator factorTo: aCompoundUnit numerator.
	denominatorFactor := self denominator factorTo: aCompoundUnit denominator.
	^ numeratorFactor * denominatorFactor.! !

!ProductUnit methodsFor: 'as yet unclassified' stamp: 'T 6/8/2017 16:31:37'!
initializeWith: anUnit dividedBy: anUnit2 
	numerator := anUnit.
	denominator := anUnit2.! !

!ProductUnit methodsFor: 'as yet unclassified' stamp: 'T 6/8/2017 16:43:29'!
numerator
	^ numerator .! !

!ProductUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:05:29'!
printOn: aStream
	numerator printOn: aStream.
	aStream nextPutAll: '/'.
	denominator printOn: aStream.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProductUnit class' category: #'Measure-Solution'!
ProductUnit class
	instanceVariableNames: ''!

!ProductUnit class methodsFor: 'as yet unclassified' stamp: 'T 6/8/2017 16:27:31'!
with: anUnit dividedBy: anUnit2 
	^self new initializeWith: anUnit dividedBy: anUnit2 .! !


!classDefinition: #SimpleUnit category: #'Measure-Solution'!
Unit subclass: #SimpleUnit
	instanceVariableNames: 'name factorToBase base'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 20:52:27'!
* aNumber
	^self amount: aNumber! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 18:22:46'!
/ anUnit 
	^ ProductUnit with: self dividedBy: anUnit! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 20:01:14'!
<= aUnit
	^name <= aUnit name.! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:43:33'!
= aUnit
	^name = aUnit name & factorToBase = aUnit factorToBase.! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 20:51:09'!
adaptToNumber: aNumber andSend: aSymbol 
	
	"Operation must be commutative"
	^self perform: aSymbol with: aNumber! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 20:25:01'!
amount: anAmount
	^Measure amount: anAmount unit: self! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:11:46'!
base
	^base! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 17:16:27'!
compatibleWith: anUnit 
	^self class = anUnit class and: [self base = anUnit base].! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 20:42:33'!
factorTo: aUnit
	(self base = aUnit base) ifFalse: [self error: 'cannot convert'].
	^self factorToBase / aUnit factorToBase.! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:49:34'!
factorToBase
	^factorToBase! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/6/2017 19:42:06'!
hash
	^{ name . factorToBase } hash! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:18:03'!
initializeWithName: aString 
	name := aString.
	base := self.
	factorToBase := 1.! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:12:20'!
initializeWithName: aName base: aUnit factorToBase: aFactor
	name := aName.
	base := aUnit.
	factorToBase := aFactor.! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:45:35'!
name
	^name! !

!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'FG 6/8/2017 17:58:31'!
printOn: aStream
	aStream nextPutAll: name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimpleUnit class' category: #'Measure-Solution'!
SimpleUnit class
	instanceVariableNames: ''!

!SimpleUnit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:19:22'!
baseNamed: aString 
	^self new initializeWithName: aString! !
