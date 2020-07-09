#! @Chapter Spectrum approximation from curve splittings in dP3

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
#!      (x) h0 = 0: 22
#!      (x) h0 = 1: 6
#!      (x) h0 = 2: 37
#!      (x) h0 = 3: 14
#! @EndExample

#! We can of course compute this also finer, i.e. by checking irreducibiltiy for each identified setup:

#! @Example
approx2 := FineApproximation( [3,-1,-1,-1],[1,-1,-3,-1] );;
#! (*) Curve: [ 3, -1, -1, -1 ]
#! (*) Bundle: [ 1, -1, -3, -1 ]
#! (*) 79 rough approximations
#! (*) Rough spectrum estimate: [ 0, 1, 2, 3 ]
#!      (x) h0 = 0: 22
#!      (x) h0 = 1: 6
#!      (x) h0 = 2: 37
#!      (x) h0 = 3: 14
#! (*) Checking irreducibility of curves...
#! (*) 23 fine approximations
#! (*) Fine spectrum estimate: [ 0, 2, 3 ]
#!      (x) h0 = 0: 11
#!      (x) h0 = 2: 11
#!      (x) h0 = 3: 1

#! @EndExample

#! Here is a more involved example:

#! @Example
approx2 := RoughApproximation( [5,-1,-1,-2],[1,1,-4,1] );;
#! (*) Curve: [ 5, -1, -1, -2 ]
#! (*) Bundle: [ 1, 1, -4, 1 ]
#! (*) 332 rough approximations
#! (*) Rough spectrum estimate: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
#!      (x) h0 = 0: 20
#!      (x) h0 = 1: 18
#!      (x) h0 = 2: 9
#!      (x) h0 = 3: 37
#!      (x) h0 = 4: 30
#!      (x) h0 = 5: 31
#!      (x) h0 = 6: 148
#!      (x) h0 = 7: 39
#! @EndExample

#! Another involved example:

#! @Example
approx3 := FineApproximation( [3,-1,-1,-1],[1,-1,-3,-1] );;
#! (*) Curve: [ 3, -1, -1, -1 ]
#! (*) Bundle: [ 1, -1, -3, -1 ]
#! (*) 79 rough approximations
#! (*) Rough spectrum estimate: [ 0, 1, 2, 3 ]
#!     (x) h0 = 0: 22
#!     (x) h0 = 1: 6
#!     (x) h0 = 2: 37
#!     (x) h0 = 3: 14
#! (*) Checking irreducibility of curves...
#! (*) 23 fine approximations
#! (*) Fine spectrum estimate: [ 0, 2, 3 ]
#!     (x) h0 = 0: 11
#!     (x) h0 = 2: 11
#!     (x) h0 = 3: 1
#! @EndExample

