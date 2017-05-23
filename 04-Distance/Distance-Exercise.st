!classDefinition: #DistanceTest category: #'Distance-Exercise'!
TestCase subclass: #DistanceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Exercise'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'T 5/22/2017 22:11:21'!
test01UnMetroShouldBeEqualToUnMetro

	| unMetro otroUnMetro |
	unMetro := Metro with: 1.
	otroUnMetro := Metro with: 1.
	
	self assert: unMetro = otroUnMetro! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'T 5/22/2017 21:58:51'!
test02UnMetroPlusUnMetroShouldBeEqualToDosMetros

	| unMetro dosMetros |
	unMetro := Metro with: 1.
	dosMetros := Metro with: 2.
	
	self assert: (unMetro + unMetro) = dosMetros
	
	
	! !


!classDefinition: #Metro category: #'Distance-Exercise'!
Object subclass: #Metro
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Exercise'!

!Metro methodsFor: 'as yet unclassified' stamp: 'T 5/22/2017 22:13:18'!
+ aMetro 

	^self class with: amount + aMetro amountValue.! !

!Metro methodsFor: 'as yet unclassified' stamp: 'T 5/22/2017 22:13:02'!
= aMetro

	^amount  = aMetro amountValue.! !

!Metro methodsFor: 'as yet unclassified' stamp: 'T 5/22/2017 22:13:28'!
amountValue

	^ amount! !

!Metro methodsFor: 'as yet unclassified' stamp: 'T 5/22/2017 21:57:29'!
initializeWith: aDistanceInMetros

	amount := aDistanceInMetros.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Metro class' category: #'Distance-Exercise'!
Metro class
	instanceVariableNames: ''!

!Metro class methodsFor: 'as yet unclassified' stamp: 'T 5/22/2017 21:54:53'!
with: aDistanceInMetros
 
	^self new initializeWith: aDistanceInMetros ! !
