# SPDX-License-Identifier: GPL-2.0-or-later
# NConvex: A Gap package to perform polyhedral computations
#
# Implementations
#




InstallGlobalFunction( SolveEqualitiesAndInequalitiesOverIntergers,
  function( arg )
    local eq, ineq, eq_and_ineq, nr_cols, signs, P;
    
    if Length( arg ) < 4 then
      Error( "Wrong input!\n" );
    fi;
    
    if not ForAll( arg, IsList ) then
      Error( "Wrong input!\n" );
    fi;
    
    eq := ListN( arg[ 1 ], arg[ 2 ], { e, c } -> Concatenation( [ -c ], e ) );
    
    ineq := ListN( arg[ 3 ], arg[ 4 ], { e, c } -> Concatenation( [ -c ], e ) );
    
    eq_and_ineq := Concatenation( eq, -eq, ineq );
    
    nr_cols := Size( eq_and_ineq[ 1 ] );
    
    if Length( arg ) = 5 then
      
      signs := Positions( arg[ 5 ], 1 );
      
      signs := List( signs, i -> List( [ 1 .. nr_cols ], j -> Minimum( Int( ( i + 1 ) / j ), Int( j / ( i + 1 ) ) ) ) ); # Kroniker-delta function
      
    else
      
      signs := [ ];
      
    fi;
    
    P := PolyhedronByInequalities( Concatenation( eq_and_ineq, signs ) );
    
    return LatticePointsGenerators( P );
    
end );
