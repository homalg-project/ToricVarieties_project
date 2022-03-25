#! @Chapter Tools for computing root bundle distributions in the Quadrillion F-theory Standard Models

#! @Section Example: Spin bundles on general nodal curves

LoadPackage( "QSMExplorer" );

#! @Example
genera := [0,0,0];
degrees := [1,4,1];
edges := [[0,1],[0,1],[0,1],[1,2],[1,2],[1,2]];
total_genus := 4;
root := 2;
h0Min := 0;
h0Max := 0;
numNodesMin := 0;;
numNodesMax := Length(edges);;
number_processes := 8;
res := CountPartialBlowupLimitRootDistribution([genera, degrees, edges, total_genus, root, h0Min, h0Max, numNodesMin, numNodesMax, false, number_processes]);;
res;
#! [ [ [ 1, 0, 0, 0, 0, 0, 0 ] ], [ [ 0, 0, 6, 0, 9, 0, 0 ] ] ]
#! @EndExample

#! @Example
genera := [0,0,0];
degrees := [0,2,0];
edges := [[0,1],[0,1],[1,2],[1,2]];
total_genus := 2;
root := 2;
h0Min := 0;
h0Max := 0;
numNodesMin := 0;;
numNodesMax := Length(edges);;
number_processes := 8;
res := CountPartialBlowupLimitRootDistribution([genera, degrees, edges, total_genus, root, h0Min, h0Max, numNodesMin, numNodesMax, false, number_processes]);;
res;
#! [ [ [ 1, 0, 0, 0, 0 ] ], [ [ 0, 0, 2, 0, 1 ] ] ]
#! @EndExample

#! @Example
genera := [0,0,0,0];
degrees := [0,0,0,4];
edges := [[0,3],[0,3],[1,3],[1,3],[2,3],[2,3]];
total_genus := 3;
root := 2;
h0Min := 0;
h0Max := 0;
numNodesMin := 0;;
numNodesMax := Length(edges);;
number_processes := 8;
res := CountPartialBlowupLimitRootDistribution([genera, degrees, edges, total_genus, root, h0Min, h0Max, numNodesMin, numNodesMax, false, number_processes]);;
res;
#! [ [ [ 1, 0, 0, 0, 0, 0, 0 ] ], [ [ 0, 0, 3, 0, 3, 0, 1 ] ] ]
#! @EndExample
