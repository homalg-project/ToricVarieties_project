// Read the external weights
void ReadFluxes( std::vector<std::vector<int>> & external_fluxes )
{

    // set up filestream
    std::ifstream myfile;
    myfile.open("Data/Fluxes.txt");
    std::string myline;
    std::string delimiter = "],";
    size_t pos = 0;
    
    // try to read from the file
    if ( myfile.is_open() ) {
        
        // read the file content
        while ( myfile ) {

            // get line
            std::getline (myfile, myline);

            // parse into vector of integers
            std::string token;
            while ((pos = myline.find(delimiter)) != std::string::npos) {
                
                // get first substring
                token = myline.substr(0, pos);
                
                // parse
                std::vector<int> vect;
                std::stringstream ss(token);
                for (int i; ss >> i;) {
                    vect.push_back(i);    
                    if (ss.peek() == ','){
                        ss.ignore();
                    }
                }
                
                // append to external_fluxes
                external_fluxes.push_back( vect );
                
                // erase substring and start over
                myline.erase(0, pos + delimiter.length());
            }
            
        }
        
    }
    else {
        
        std::cout << "Couldn't open file /Data/Fluxes.txt\n";
        
    }
    
}

// Read distributions on Higgs curve components
void ReadDistributionOnHi( std::vector<std::vector<unsigned long long int>> & dist_H, std::string file_name )
{

    // set up filestream
    std::ifstream myfile;
    myfile.open(file_name);
    std::string myline;
    std::string delimiter = "],";
    size_t pos = 0;
    
    // try to read from the file
    if ( myfile.is_open() ) {
        
        // read the file content
        while ( myfile ) {

            // get line
            std::getline (myfile, myline);

            // parse into vector of integers
            std::string token;
            while ((pos = myline.find(delimiter)) != std::string::npos) {
                
                // get first substring
                token = myline.substr(0, pos);
                
                // parse
                std::vector<unsigned long long int> vect;
                if ( token == "t" ){
                    // trivial distribution
                    //int a = -1;
                    vect.push_back( 0 );
                }
                else{
                    // non-trivial distribution - parsing necessary
                    std::stringstream ss(token);
                    for (int i; ss >> i;) {
                        vect.push_back(i);    
                        if (ss.peek() == ','){
                            ss.ignore();
                        }
                    }
                }
                
                // append to external_weights
                dist_H.push_back( vect );
                
                // erase substring and start over
                myline.erase(0, pos + delimiter.length());
            }
            
        }
        
    }
    else {
        
        std::cout << "Couldn't open file /Data/Hi.txt\n";
        
    }
    
}


// Read the Hi
void ReadHi( std::vector<std::vector<unsigned long long int>> & dist_H, int i )
{
    std::string file_name;
    if ( i == 1 ){
        file_name = "Data/H1.txt";
    }
    if ( i == 2 ){
        file_name = "Data/H2.txt";
    }
    if ( i == 3 ){
        file_name = "Data/H3.txt";
    }
    ReadDistributionOnHi( dist_H, file_name );
}
