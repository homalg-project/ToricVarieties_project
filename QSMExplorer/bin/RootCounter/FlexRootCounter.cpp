#include "WDiagram.h"


// Global variable for counting diagrams // thread-safe addition
unsigned long long int total_flex;
std::mutex myMutexFlex;
void IncreaseTotalFlex( int s )
{
    std::lock_guard<std::mutex> guard(myMutexFlex);
    total_flex = total_flex + s;
}


// Count the minimal roots
// Count the minimal roots
int FlexRootCounter( WeightedDiagram dia, int w0 )
{
    
    // save total number of roots found
    unsigned long long int sum = 0;
    
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
    WeightedDiagram new_dia = dia;
    
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
                bool ok = dia.test_weights( new_weights );
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
            
            // set the weights in a new diagram
            new_dia = dia;
            int mult = new_dia.get_mult( currentSnapshot.w );
            sum = sum + mult;
            
        }
        
    }
    
    // increase the total number of diagrams found and inform that this thread is finished
    return sum;
    
}

void FlexDistributer( WeightedDiagram dia, std::vector<int> ws )
{
    
    // initialize sum
    unsigned long long int sum = 0;
    
    // find roots for different weight assignments
    for ( int i = 0; i < ws.size(); i++ ){
        sum = sum + FlexRootCounter( dia, ws[ i ] );
    }
    
    // increase the total number of roots found
    IncreaseTotalFlex( sum );
    
    // and signal end of thread run
    std::cout<<"Thread complete. Total roots found: " << sum << "\n";
    
}

int countRoots( WeightedDiagram dia, int NUM_THREADS )
{
    
    if ( NUM_THREADS <= 0 ){
        throw std::invalid_argument( "Number of threads must be at least 1." );
        return -1;
    }
    
    // inform about the diagram in question
    dia.print_complete_information();
    
    // initialize total as 0
    total = 0;
    
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
        WeightedDiagram new_dia = dia;
        threadList.push_back( std::thread( Distributer, new_dia, packages[ i ] ) );
    }
    
    // Now wait for the results of the worker threads (i.e. call the join() function on each of the std::thread objects) and inform the user
    std::for_each(threadList.begin(),threadList.end(), std::mem_fn(&std::thread::join));
    std::cout << "Found " << total << " minimal roots\n\n";
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(end - begin).count() << "[s]\n\n";
    
    // return the number of diagrams
    return total;
    
}

// default/convenience method
int countRoots( WeightedDiagram dia )
{
    return countRoots( dia, dia.get_root() - 1 );
}
