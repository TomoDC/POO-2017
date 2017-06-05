!classDefinition: #Distance category: #'Distance-Solution'!
Magnitude subclass: #Distance
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'converting' stamp: 'FG 6/5/2017 20:26:02'!
convertTo: aUnit 
	(aUnit isKindOf: CompoundUnit) ifTrue: [
'		^CompoundMeasure amounts: 2.'
	] ifFalse: [
		^self class amount: (self amount * (self unit factorToBase / aUnit factorToBase)) unit: aUnit
	]! !

!Distance methodsFor: 'converting' stamp: 'FG 6/1/2017 19:29:56'!
initializeWithAmount: aNumber unit: aUnit
	amount := aNumber.
	unit := aUnit.! !


!Distance methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:23:00'!
* aNumber
	^self unit amount: (self amount * aNumber)! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 6/5/2017 20:45:15'!
+ aDistance
	(self unit base = aDistance unit base) ifTrue: [
		^self unit amount: (self amount + (aDistance convertTo: self unit) amount)
	] ifFalse: [
		^CompoundMeasure amounts: {self . aDistance}
	]! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 19:55:14'!
- aDistance 
	^self + (aDistance negated)! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:23:14'!
/ aNumber
	^self unit amount: (self amount / aNumber)! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 5/23/2017 21:18:06'!
adaptToNumber: aNumber andSend: aSymbol 
	
	"Operation must be commutative"
	^self perform: aSymbol with: aNumber! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:46:27'!
hash
	^(self amount * self unit factorToBase) hash! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:36:08'!
isZero
	^self amount isZero! !

!Distance methodsFor: 'arithmetic' stamp: 'FG 6/1/2017 20:23:21'!
negated
	^self unit amount: (self amount negated)! !


!Distance methodsFor: 'comparing' stamp: 'FG 6/1/2017 19:51:52'!
< aDistance 
	^self amount < (aDistance convertTo: (self unit)) amount! !

!Distance methodsFor: 'comparing' stamp: 'FG 6/5/2017 20:48:11'!
= aDistance 
	^(((aDistance isKindOf: self class)
		and: [self unit base = aDistance unit base])
		or: [self amount = 0 & aDistance amount = 0])
		and: [self amount = (aDistance convertTo: (self unit)) amount].
! !


!Distance methodsFor: 'accessing' stamp: 'FG 6/1/2017 19:51:21'!
amount
	^amount! !

!Distance methodsFor: 'accessing' stamp: 'FG 6/1/2017 19:25:48'!
unit
	^unit! !


!Distance methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:21:16'!
to: aDistance
	^DistanceInterval from: self to: (aDistance convertTo: self unit) by: (self unit amount: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:22:21'!
to: aLastDistance by: aStepDistance 
	^DistanceInterval from: self to: (aLastDistance convertTo: self unit) by: (aStepDistance convertTo: self unit)! !


!Distance methodsFor: 'printing' stamp: 'FG 6/5/2017 19:33:39'!
printOn: aStream
	self amount printOn: aStream.
	' ' printOn: aStream.
	self unit printOn: aStream.
	self amount > 1 ifTrue: ['s' printOn: aStream].! !

!Distance methodsFor: 'printing' stamp: 'FG 6/1/2017 20:53:17'!
printString
	self amount > 1 ifTrue: [
		^self amount printString, ' ', self unit printString, 's'
	] ifFalse: [
		^self amount printString, ' ', self unit printString
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:19:24'!
amount: aNumber unit: aUnit
	^self new initializeWithAmount: aNumber unit: aUnit! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
SequenceableCollection subclass: #DistanceInterval
	instanceVariableNames: 'first last step'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 21:00:42'!
at: index
	^first + ((index - 1) * step)! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:34:15'!
by
	^self step! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:33:53'!
from
	^self first! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:48:37'!
initializeWithFirst: aFirstDistance last: aLastDistance step: aStepDistance 
	first := aFirstDistance.
	last := aLastDistance convertTo: first unit.
	step := aStepDistance convertTo: first unit.! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 21:07:32'!
size
	^1 + (((last amount - first amount) abs) / (step amount abs))! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:48:32'!
step
	^step! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:34:03'!
to
	^self last! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'as yet unclassified' stamp: 'FG 5/30/2017 18:42:49'!
from: aFirstDistance to: aLastDistance by: aStepDistance 
	^self new initializeWithFirst: aFirstDistance last: aLastDistance step: aStepDistance.! !


!classDefinition: #CatedraDistanceTest category: #'Distance-Solution'!
TestCase subclass: #CatedraDistanceTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

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


!CatedraDistanceTest methodsFor: 'distance units' stamp: 'FG 6/1/2017 20:26:34'!
centimeter

	^Unit centimeter! !

!CatedraDistanceTest methodsFor: 'distance units' stamp: 'FG 6/1/2017 20:26:30'!
decameter
	
	^Unit decameter! !

!CatedraDistanceTest methodsFor: 'distance units' stamp: 'FG 6/1/2017 20:26:26'!
decimeter
	
	^Unit decimeter! !

!CatedraDistanceTest methodsFor: 'distance units' stamp: 'HAW 5/31/2017 12:37:50'!
distanceUnits 

	"¿Quién se anima a explicar cómo funciona este método? 
	¿Por qué está hecho así? "
		
	| unitsCategory unitMessageNames |
	
	unitsCategory := self class organization categoryOfElement: thisContext method selector.
	unitMessageNames := (self class organization listAtCategoryNamed:  unitsCategory) reject: [ :aMessageName | aMessageName = thisContext method selector ].
	
	 ^ unitMessageNames collect: [ :aMessageName | self perform: aMessageName ]
	
! !

!CatedraDistanceTest methodsFor: 'distance units' stamp: 'FG 6/1/2017 20:26:18'!
hectometer
	
	^Unit hectometer! !

!CatedraDistanceTest methodsFor: 'distance units' stamp: 'FG 6/1/2017 20:26:11'!
kilometer
	
	^Unit kilometer! !

!CatedraDistanceTest methodsFor: 'distance units' stamp: 'FG 6/1/2017 20:25:56'!
meter

	^Unit meter! !

!CatedraDistanceTest methodsFor: 'distance units' stamp: 'FG 6/1/2017 20:26:03'!
millimeter
	
	^Unit millimeter! !


!CatedraDistanceTest methodsFor: 'distance measures' stamp: 'HAW 5/31/2017 11:20:12'!
distanceExamples

	"¿Quién se anima a explicar cómo funciona este método? 
	¿Por qué está hecho así? "
		
	| distanceCategory distanceMessageNames |
	
	distanceCategory := self class organization categoryOfElement: thisContext method selector.
	distanceMessageNames := (self class organization listAtCategoryNamed:  distanceCategory) reject: [ :aMessageName | aMessageName = thisContext method selector ].
	
	 ^ distanceMessageNames collect: [ :aMessageName | self perform: aMessageName ]
	
! !

!CatedraDistanceTest methodsFor: 'distance measures' stamp: 'HAW 5/31/2017 11:03:32'!
minusOneMeter 
	
	^factory minusOneMeter! !

!CatedraDistanceTest methodsFor: 'distance measures' stamp: 'HAW 5/31/2017 11:03:45'!
oneCentimeter
	
	^factory oneCentimeter ! !

!CatedraDistanceTest methodsFor: 'distance measures' stamp: 'HAW 5/31/2017 11:03:53'!
oneHundredCentimeters
	
	^factory oneHundredCentimeters ! !

!CatedraDistanceTest methodsFor: 'distance measures' stamp: 'HAW 5/31/2017 11:04:03'!
oneMeter
	
	^factory oneMeter ! !

!CatedraDistanceTest methodsFor: 'distance measures' stamp: 'HAW 5/31/2017 11:04:18'!
twoHundredCentimeters
	
	^factory twoHundredCentimeters ! !

!CatedraDistanceTest methodsFor: 'distance measures' stamp: 'HAW 5/31/2017 11:04:29'!
twoMeters
	
	^factory twoMeters ! !

!CatedraDistanceTest methodsFor: 'distance measures' stamp: 'HAW 5/31/2017 11:04:38'!
zeroMeters

	^factory zeroMeters ! !


!CatedraDistanceTest methodsFor: 'setup' stamp: 'HAW 5/31/2017 11:06:46'!
setUp

	| factoryClass |
	
	factoryClass := Smalltalk classNamed: #DistanceFactory.
	self assert: factoryClass notNil description: 'No se entrego la clase DistanceFactory'.
	
	factory := factoryClass new.! !


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

!DistanceTest methodsFor: 'testing' stamp: 'FG 6/1/2017 19:24:32'!
test19DistancesHaveUnits
	self assert: (unMetro unit printString) equals: 'meter'! !


!DistanceTest methodsFor: 'setUp' stamp: 'FG 6/1/2017 20:02:03'!
setUp

	factory := DistanceFactory new.
	unMetro := Distance amount: 1 unit: (Unit meter).
	otroUnMetro := Distance amount: 1 unit: (Unit meter).
	dosMetros := Distance amount: 2 unit: (Unit meter).
	cienCentimetros := Distance amount: 100 unit: (Unit centimeter).
	thousandMillimeter := Distance amount: 1000 unit: (Unit millimeter).
	halfMeter := Distance amount: (1 / 2) unit: (Unit meter).
	zeroMeter := Distance amount: 0 unit: (Unit meter).
	diezKilometros  := Distance amount: 10 unit: (Unit kilometer).
	unKilometro := Distance amount: 1 unit: (Unit kilometer).
	milMetros  := Distance amount: 1000 unit: (Unit meter).
	tresMetros := Distance amount: 3 unit: (Unit meter).
! !


!classDefinition: #MeasureTest category: #'Distance-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

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

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/5/2017 19:54:32'!
test04CanOperateBetweenDifferentTypesOfUnit

	self assert: ((self peso amount: 100) + (self liter amount: 100)) equals: ((self liter amount: 100) + (self peso amount: 100)).! !

!MeasureTest methodsFor: 'testing' stamp: 'FG 6/5/2017 20:49:02'!
test05ZeroesShouldAllBeEqual

	self assert: (self peso amount: 0) equals: (self liter amount: 0).! !


!MeasureTest methodsFor: 'units' stamp: 'FG 6/5/2017 19:07:13'!
liter
	^Unit liter! !

!MeasureTest methodsFor: 'units' stamp: 'FG 6/5/2017 19:20:28'!
meter
	^Unit meter! !

!MeasureTest methodsFor: 'units' stamp: 'FG 6/5/2017 19:04:54'!
peso
	^Unit peso! !


!classDefinition: #CompoundMeasure category: #'Distance-Solution'!
Object subclass: #CompoundMeasure
	instanceVariableNames: 'units amounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 20:42:07'!
= aCompoundMeasure
	^(aCompoundMeasure isKindOf: self class) and: [amounts = aCompoundMeasure amounts]! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 20:42:15'!
amounts
	^amounts! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 20:44:00'!
initializeWithAmounts: anArray 
	amounts := Set new.
	amounts addAll: anArray.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundMeasure class' category: #'Distance-Solution'!
CompoundMeasure class
	instanceVariableNames: ''!

!CompoundMeasure class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 20:40:25'!
amounts: anArray 
	^self new initializeWithAmounts: anArray! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:40:12'!
minusOneMeter

	^Distance amount: -1 unit: (Unit meter)! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:40:18'!
oneCentimeter

	^Distance amount: 1 unit: (Unit centimeter)! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:40:03'!
oneHundredCentimeters

	^Distance amount: 100 unit: (Unit centimeter)! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:37:47'!
oneMeter

	^Distance amount: 1 unit: (Unit meter)! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:39:49'!
twoHundredCentimeters

	^Distance amount: 200 unit: (Unit centimeter)! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:39:05'!
twoMeters

	^Distance amount: 2 unit: (Unit meter)! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:39:09'!
zeroMeters

	^Distance amount: 0 unit: (Unit meter)! !


!classDefinition: #Unit category: #'Distance-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'name factorToBase base'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 20:01:14'!
<= aUnit
	^name <= aUnit name.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:43:33'!
= aUnit
	^name = aUnit name & factorToBase = aUnit factorToBase.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:02:31'!
amount: anAmount
	^Distance amount: anAmount unit: self! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:11:46'!
base
	^base! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 19:49:34'!
factorToBase
	^factorToBase! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:18:03'!
initializeWithName: aString 
	name := aString.
	base := self.
	factorToBase := 1.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:12:20'!
initializeWithName: aName base: aUnit factorToBase: aFactor
	name := aName.
	base := aUnit.
	factorToBase := aFactor.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:11:01'!
initializeWithName: aName factorToBase: aFactor
	name := aName.
	factorToBase := aFactor.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:45:35'!
name
	^name! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:33:55'!
printOn: aStream
	name printOn: aStream.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'FG 6/1/2017 20:20:11'!
printString
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Distance-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:19:22'!
baseNamed: aString 
	^self new initializeWithName: aString! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:33'!
centimeter
	^self new initializeWithName: 'centimeter' base: (self meter) factorToBase: 1/100! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:58:32'!
common: aUnit with: anotherUnit
	(aUnit base = anotherUnit base) ifTrue: [^aUnit base] ifFalse: [^CompoundUnit of: { aUnit. anotherUnit. }]! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:26'!
decameter
	^self new initializeWithName: 'decameter' base: (self meter) factorToBase: 10! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:38'!
decimeter
	^self new initializeWithName: 'decimeter' base: (self meter) factorToBase: 1/10! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:40'!
hectometer
	^self new initializeWithName: 'hectometer' base: (self meter) factorToBase: 100! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:13:46'!
kilometer
	^self new initializeWithName: 'kilometer' base: (self meter) factorToBase: 1000! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:17:09'!
liter
	^self baseNamed: 'liter'! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:16:56'!
meter
	^self baseNamed: 'meter'! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:14:07'!
millimeter
	^self new initializeWithName: 'millimeter' base: (self meter) factorToBase: 1/1000! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'FG 6/5/2017 19:16:40'!
peso
	^self baseNamed: 'peso'! !
