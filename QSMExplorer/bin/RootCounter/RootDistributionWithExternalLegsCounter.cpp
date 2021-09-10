#include "WDiagramWithExternalLegs.h"


// Global variable for counting diagrams // thread-safe addition
std::vector<unsigned long long int> distribution (100, 0);
std::mutex myMutexFlex;
void UpdateDistribution( std::vector<unsigned long long int> & s )
{
    
    std::lock_guard<std::mutex> guard(myMutexFlex);
    for ( int i = 0; i < s.size(); i ++ ){
        distribution[ i ] = distribution[ i ] + s[ i ];
    }
    
}


// Count root distribution
// Count root distribution
std::vector<unsigned long long int> RootDistributionCounter( WeightedDiagramWithExternalLegs dia, int w0, int h0_target )
{
    
    // save total number of roots found
    std::vector<unsigned long long int> sum ( h0_target - dia.get_h0_min() + 1, 0 );
    
    // Upper bound for the number of weights to be set
    int number_weights = dia.get_edges().size();
    
    // Create struc to record each snapshot
    struct SnapShotStruct {
        std::vector<int> w;
        int k;
    };
    
    // Create the stack
    std::stack<SnapShotStruct> snapshotStack;
    
    // Initialize the first snapshot and add it to the stack
    SnapShotStruct currentSnapshot;
    std::vector<int> newWeights ( number_weights, 0 );
    newWeights[ 0 ] = w0;
    currentSnapshot.w = newWeights;
    currentSnapshot.k = 1;
    snapshotStack.push(currentSnapshot);
    
    // initialize a copy of dia
    WeightedDiagramWithExternalLegs new_dia = dia;
    
    // Run...
    while(!snapshotStack.empty())
    {
        
        // Pick the top snapshot and delete it from the stack
        currentSnapshot=snapshotStack.top();
        snapshotStack.pop();
        
        // check what to do with this diagram
        if ( currentSnapshot.k < number_weights ){
            
            // there are still weighs to be set -- try all placements
            for ( int i = 1; i < dia.get_root(); i++ ){
                
                std::vector<int> new_weights = currentSnapshot.w;
                new_weights[ currentSnapshot.k ] = i;
                bool ok = dia.test_weights( new_weights, h0_target );
                if ( ok == true ){
                
                    // create new snapshot
                    SnapShotStruct newSnapshot;
                    newSnapshot.w = new_weights;
                    newSnapshot.k = currentSnapshot.k + 1;
                    
                    // add snapshot to the stack
                    snapshotStack.push(newSnapshot);
                    
                }
                
            }
            
        }
        else{
            
            // all weights set, find out h0 and multiplicity
            new_dia = dia;
            int mult = new_dia.get_mult( currentSnapshot.w );
            int pos = new_dia.h0_from_weights( currentSnapshot.w ) - new_dia.get_h0_min();
            sum[ pos ] = sum[ pos ] + mult;
            
        }
        
    }
    
    // return the result
    return sum;
    
}

void DistributionDistributer( WeightedDiagramWithExternalLegs dia, std::vector<int> ws, int h0_target )
{
    
    // initialize sum
    std::vector<unsigned long long int> sum ( h0_target - dia.get_h0_min() + 1, 0 );
    std::vector<unsigned long long int> result;
    
    // find roots for different weight assignments
    for ( int i = 0; i < ws.size(); i++ ){
        
        result = RootDistributionCounter( dia, ws[ i ], h0_target );
        for ( int i = 0; i < result.size(); i ++ ){
            sum[ i ] = sum[ i ] + result[ i ];
        }
        
    }
    
    // increase the total number of roots found
    UpdateDistribution( sum );
    
    // determine total number of roots found
    unsigned long long int total = 0;
    for ( int i = 0; i < sum.size(); i++ ){
        total = total + sum[ i ];
    }
    
    // signal end of thread
    std::cout<<"Thread complete. Total roots found: " << total << "\n";
    
}


std::vector<unsigned long long int> countRootDistribution( WeightedDiagramWithExternalLegs dia, int NUM_THREADS, int h0_target )
{
    
    // throw error if the number of threads is indicated as anything less than 1
    if ( NUM_THREADS <= 0 ){
        throw std::invalid_argument( "Number of threads must be at least 1." );
    }
    
    // inform about the diagram in question
    dia.print_complete_information();
    
    // check if the h0_target is meaningful
    if ( dia.get_h0_min() > h0_target ){
            std::cout<<"There are no roots with h0 smaller than " << dia.get_h0_min() << "\n";
            std::vector<unsigned long long int> res ( 1, 0 );
            return res;
    }
    
    // take time for counting
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    
    // inform what we are about to do
    std::cout<<"Executing...\n";
    std::cout<<"------------\n";
    
    // distribute weight assignments on first edge into NUM_THREADS packages -- each for one thread
    std::vector<std::vector<int>> packages;
    if ( NUM_THREADS >= dia.get_root() - 1 ){
        for ( int i = 0; i < dia.get_root() - 1; i++ ){
            std::vector<int> package ( 1, i+1 );
            packages.push_back( package );
        }
    }
    else{
        
        int package_size = (int) ( dia.get_root() - 1 ) / NUM_THREADS;
        int current_root = 1;
        for ( int i = 0; i < NUM_THREADS-1; i++ ){
            
            // set up thread with given package size
            std::vector<int> package ( package_size );
            for ( int j = 0; j < package_size; j++ ){
                package[ j ] = current_root;
                current_root++;
            }
            
            // update package size
            package_size = (int) ( dia.get_root() - current_root ) / ( NUM_THREADS - (i+1) );
            
            // append to packages
            packages.push_back( package );
            
        }
        
        // set up thread with given package size
        std::vector<int> package;
        for ( int j = current_root; j < dia.get_root(); j++ ){
            package.push_back( current_root );
            current_root++;
        }
        packages.push_back( package );
        
    }
    
    // signal and start the threads
    std::cout<<"Wait for " << packages.size() << " worker threads \n";
    std::vector<std::thread> threadList;
    for (int i = 0; i < packages.size(); i++)
    {
        WeightedDiagramWithExternalLegs new_dia = dia;
        threadList.push_back( std::thread( DistributionDistributer, new_dia, packages[ i ], h0_target ) );
    }
    
    // Now wait for the results of the worker threads (i.e. call the join() function on each of the std::thread objects) and inform the user
    std::for_each(threadList.begin(),threadList.end(), std::mem_fn(&std::thread::join));
    
    // determine the total number of roots found
    int total_number = 0;
    for ( int i = 0; i < h0_target -dia.get_h0_min() + 1; i++ ){
        total_number = total_number + distribution[ i ];
    }
    
    // print results nicely
    std::cout << "\n";
    std::cout << "Found distribution:\n";
    std::cout << "--------------------------\n";
    for ( int i = 0; i < h0_target - dia.get_h0_min() + 1; i++ ){
        std::cout << "Found " << distribution[ i ] << " roots with h0 = " << dia.get_h0_min() + i << " (" << 100 * distribution[ i ] / total_number << "%)\n";
    }
    std::cout << "\n";
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(end - begin).count() << "[s]\n\n";
    
    // return the number of diagrams
    return distribution;
    
}

// default/convenience method
std::vector<unsigned long long int> countRootDistribution( WeightedDiagramWithExternalLegs dia, int h0_target )
{
    return countRootDistribution( dia, dia.get_root() - 1, h0_target );
}
