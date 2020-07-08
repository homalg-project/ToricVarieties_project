#! @Chapter Spectrum approximation from curve splittings in H2

#! @Section Examples

LoadPackage( "H0Approximator" );

#! We can approximate the spectrum roughly, that is we do not take irreducibilty of curves into account.
#! Here is a simple example:

#! @Example
approx1 := RoughApproximationOnH2( [3,1],[1,1] );;
#! (*) Curve: [ 3, 1 ]
#! (*) Bundle: [ 1, 1 ]
#! (*) 4 rough approximations
#! (*) Rough spectrum estimate: [ 3 ]
#!      (x) h0 = 3: 4
#! @EndExample

#! We can of course compute this also finer, i.e. by checking irreducibiltiy for each identified setup:

#! @Example
approx2 := FineApproximationOnH2( [3,1],[1,1] );;
#! (*) Curve: [ 3, 1 ]
#! (*) Bundle: [ 1, 1 ]
#! (*) 4 rough approximations
#! (*) Rough spectrum estimate: [ 3 ]
#!      (x) h0 = 3: 4
#! (*) Checking irreducibility of curves...
#! (*) 2 fine approximations
#! (*) Fine spectrum estimate: [ 3 ]
#!      (x) h0 = 3: 2
#! @EndExample

#! Here is a more involved example:

#! @Example
approx2 := RoughApproximationOnH2( [5,2],[1,4] );;
#! (*) Curve: [ 5, 2 ]
#! (*) Bundle: [ 1, 4 ]
#! (*) 9 rough approximations
#! (*) Rough spectrum estimate: [ 5, 6, 9, 11, 12, 15 ]
#!      (x) h0 = 5: 3
#!      (x) h0 = 6: 1
#!      (x) h0 = 9: 1
#!      (x) h0 = 11: 1
#!      (x) h0 = 12: 2
#!      (x) h0 = 15: 1
#! @EndExample

#! We can of course compute this also finer, i.e. by checking irreducibiltiy for each identified setup:

#! @Example
approx3 := FineApproximationOnH2( [5,2],[1,4] );;
#! (*) Curve: [ 5, 2 ]
#! (*) Bundle: [ 1, 4 ]
#! (*) 9 rough approximations
#! (*) Rough spectrum estimate: [ 5, 6, 9, 11, 12, 15 ]
#!      (x) h0 = 5: 3
#!      (x) h0 = 6: 1
#!      (x) h0 = 9: 1
#!      (x) h0 = 11: 1
#!      (x) h0 = 12: 2
#!      (x) h0 = 15: 1
#! (*) Checking irreducibility of curves...
#! (*) 7 fine approximations
#! (*) Fine spectrum estimate: [ 5, 6, 9, 11, 12 ]
#!      (x) h0 = 5: 2
#!      (x) h0 = 6: 1
#!      (x) h0 = 9: 1
#!      (x) h0 = 11: 1
#!      (x) h0 = 12: 2
#! @EndExample

