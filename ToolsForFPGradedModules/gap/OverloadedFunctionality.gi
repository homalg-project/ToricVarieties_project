################################################################################################
##
##  OverloadedFunctionality.gi   ToolsForFPGradedModules package
##
##  Copyright 2020               Martin Bies,       University of Oxford
##
#! @Chapter Overload functions/methods for old graded modules
##
################################################################################################


InstallMethod( ByASmallerPresentation,
               "a f.p. graded S-module",
               [ IsFpGradedLeftOrRightModulesObject ],
  function( module )

  return TurnIntoCAPGradedModule( ByASmallerPresentation( TurnIntoOldGradedModule( module ) ) );

end );
