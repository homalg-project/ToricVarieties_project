#! @Chapter Additional properties of toric varieties

#! @Section Example: Stanley-Reisner ideal for CAP

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
SR1 := SRLeftIdealForCAP( P2 );
#!
SR2 := SRRightIdealForCAP( P2 );
#!
#! @EndExample


#! @Section Example: Irrelevant ideal for CAP

#! @Subsection Examples
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
IR1 := IrrelevantLeftIdealForCAP( P2 );
#!
IR2 := IrrelevantRightIdealForCAP( P2 );
#!
#! @Example

#! @EndExample
