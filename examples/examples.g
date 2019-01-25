#! @Chapter Functionality of Topcom

#! @Section Functionality of Topcom: Examples 

LoadPackage( "TopcomInterface" );

#! @Example
rays := [[1,0],[0,1],[-1,-1]];
#! [ [ 1, 0 ], [ 0, 1 ], [ -1, -1 ] ]
trias := points2allfinetriangs( rays, [], ["regular"] );
#! [ [ 0, 1 ], [ 0, 2 ], [ 1, 2 ] ]
#! @EndExample


