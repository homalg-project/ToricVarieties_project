gap> START_TEST( "linear-programming.tst");
gap> trails := 20;;
gap> N := 17;;
gap> for i in [ 1 .. trails ] do
> n := NanosecondsSinceEpoch() mod N;;
> if n <> 0 then
>   N := n;
>   break;
> fi;
> od;;
gap> M := 2 + NanosecondsSinceEpoch() mod 3;;
gap> L := List( [ 1 .. N ], i -> List( [ 1 .. M ], i -> Random( [ -10 .. 10 ] ) ) );;
gap> target_func := List( [ 1 .. M ], i -> Random( [ -1000 .. 1000 ] ) );;
gap> max := Maximum( List( L, p -> target_func*p ) );;
gap> min := Minimum( List( L, p -> target_func*p ) );;
gap> P := Polytope( L );;
gap> r := NanosecondsSinceEpoch() mod 1001;;
gap> is_okay := SolveLinearProgram( P, "max", Concatenation( [r], target_func ) )[2] = max + r
> and SolveLinearProgram( P, "min", Concatenation( [r], target_func ) )[2] = min + r;
true
gap> if is_okay <> true then
> Print( "Something went wronge, please report this as an issue with the following input: \n" );
> Print( "Vertices are ", L, "\n" );
> Print( "Target function is ", Concatenation( [r], target_func ) );
> fi;

