void ReadData( std::vector<std::vector<unsigned long long int>> & data, std::string filename )
{

    // set up filestream
    std::ifstream myfile;
    myfile.open( filename );
    std::string myline;
    std::string delimiter = "],";
    size_t pos = 0;
    
    // try to read from the file
    if ( myfile.is_open() ) {
        
        while ( myfile ) {
            
            // read line
            std::getline (myfile, myline);
            
            // parse data
            std::string token;
            while ( ( pos = myline.find( delimiter ) ) != std::string::npos ) {
                
                // get substring
                token = myline.substr(0, pos);
                
                // parse it
                std::vector<unsigned long long int> vect;
                std::stringstream ss(token);
                for (unsigned long long int i; ss >> i;) {
                    vect.push_back( i );
                    if ( ss.peek() == ',' ){
                        ss.ignore();
                    }
                }
                
                // append it to data
                data.push_back( vect );
                
                // erase it from myline and start over
                myline.erase(0, pos + delimiter.length());
                
            }
            
        }
        
    }
    else {
        std::cout << "Couldn't open file " << filename << "\n";
    }
    
}
