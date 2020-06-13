#! @Chapter Functionality

#! @Section Examples

LoadPackage( "H0Approximator" );

#! We can approximate the spectrum roughly, that is we do not take irreducibilty of curves into account.
#! Here is a simple example:

#! @Example
approx1 := RoughApproximation( [3,-1,-1,-1],[1,-1,-3,-1] );;
#! (*) Curve: [ 3, -1, -1, -1 ]
#! (*) Bundle: [ 1, -1, -3, -1 ]
#! (*) 79 rough approximations
#! (*) Rough spectrum estimate: [ 0, 1, 2, 3 ]
#!      (*) h0 = 0: 22
#!      (*) h0 = 1: 6
#!      (*) h0 = 2: 37
#!      (*) h0 = 3: 14
#! @EndExample

#! We can of course compute this also finer, i.e. by checking irreducibiltiy for each identified setup:

#! @Example
approx2 := FineApproximation( [3,-1,-1,-1],[1,-1,-3,-1] );;
#! (*) Curve: [ 3, -1, -1, -1 ]
#! (*) Bundle: [ 1, -1, -3, -1 ]
#! (*) 79 rough approximations
#! (*) Rough spectrum estimate: [ 0, 1, 2, 3 ]
#!      (*) h0 = 0: 22
#!      (*) h0 = 1: 6
#!      (*) h0 = 2: 37
#!      (*) h0 = 3: 14
#! (*) Checking irreducibility of curves...
#! (*) 23 fine approximations
#! (*) Fine spectrum estimate: [ 0, 2, 3 ]
#!      (*) h0 = 0: 11
#!      (*) h0 = 2: 11
#!      (*) h0 = 3: 1

#! @EndExample

#! Here is a more involved example:

#! @Example
approx2 := RoughApproximation( [5,-1,-1,-2],[1,1,-4,1] );;
#! (*) Curve: [ 5, -1, -1, -2 ]
#! (*) Bundle: [ 1, 1, -4, 1 ]
#! (*) 325 rough approximations
#! (*) Rough spectrum estimate: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
#!      (*) h0 = 0: 13
#!      (*) h0 = 1: 18
#!      (*) h0 = 2: 9
#!      (*) h0 = 3: 37
#!      (*) h0 = 4: 30
#!      (*) h0 = 5: 31
#!      (*) h0 = 6: 148
#!      (*) h0 = 7: 39
#! @EndExample
