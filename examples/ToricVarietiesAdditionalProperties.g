#! @Chapter Additional methods and properties for toric varieties

#! @Section Example: Stanley-Reisner ideal for CAP

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
SR1 := SRLeftIdealForCAP( P2 );;
IsWellDefined( SR1 );
#! true
SR2 := SRRightIdealForCAP( P2 );;
IsWellDefined( SR2 );
#! true
#! @EndExample


#! @Section Example: Irrelevant ideal for CAP

#! @Subsection Examples
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
IR1 := IrrelevantLeftIdealForCAP( P2 );;
IsWellDefined( IR1 );
#! true
IR2 := IrrelevantRightIdealForCAP( P2 );;
IsWellDefined( IR2 );
#! true
#! @Example

#! @EndExample
