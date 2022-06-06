// (1) Return result
// (1) Return result
// (1) Return result

void return_result(const std::string & full_path,
                            const std::vector<std::vector<boost::multiprecision::int128_t>> & n_exact,
                            const std::vector<std::vector<boost::multiprecision::int128_t>> & n_lower_bound,
                            const int & numberBlowupsConsidered,
                            const int & numNodesMin,
                            const int & genus,
                            const int & root,
                            const int & h0Min,
                            const int & h0Max,
                            const int & b1,
                            const std::chrono::steady_clock::time_point & before,
                            const std::chrono::steady_clock::time_point & after,
                            const bool & display_details)
{
    
    // print result
    if (display_details){
        
        // print the exact numbers
        std::cout << "\n";
        for (int j = 0; j <= numberBlowupsConsidered; j++){
            std::cout << j + numNodesMin << ":\t";
            for (int i = 0; i <= h0Max - h0Min; i++){
                std::cout << n_exact[i][j] << "\t" << n_lower_bound[i][j] << "\t";
            }
            std::cout << "\n";
        }
        
        // print the totals
        boost::multiprecision::int128_t counter;
        std::cout << "Total:\t";
        for (int i = 0; i <= h0Max - h0Min; i++){
            counter = (boost::multiprecision::int128_t) 0;
            for (int j = 0; j <= numberBlowupsConsidered; j++){
                counter += n_exact[i][j];
            }
            std::cout << counter << "\t";
            counter = (boost::multiprecision::int128_t) 0;
            for (int j = 0; j <= numberBlowupsConsidered; j++){
                counter += n_lower_bound[i][j];
            }
            std::cout << counter << "\t";
        }
        std::cout << "\n\n";
        
        // compute the total number of roots
        boost::multiprecision::int128_t geo_mult = (boost::multiprecision::int128_t) (pow(root, b1));
        boost::multiprecision::int128_t total_number_roots = ((boost::multiprecision::int128_t) (pow(root, 2 * genus))/geo_mult);
        
        // print the percentages
        using LongFloat=boost::multiprecision::cpp_bin_float_quad;
        for (int j = 0; j <= numberBlowupsConsidered; j++){
            std::cout << j + numNodesMin << ":\t";
            for (int i = 0; i <= h0Max - h0Min; i++){
                LongFloat r1 = LongFloat(100) * LongFloat(n_exact[i][j]) / LongFloat(total_number_roots);
                LongFloat r2 = LongFloat(100) * LongFloat(n_lower_bound[i][j]) / LongFloat(total_number_roots);
                std::cout << std::setprecision(3) << r1 << "\t" << std::setprecision(3) << r2 << "\t";
            }
            std::cout << "\n";
        }

        // print the totals
        std::cout << "Total:\t";
        LongFloat percentage_counter;
        for (int i = 0; i <= h0Max - h0Min; i++){
            percentage_counter = 0;
            for (int j = 0; j <= numberBlowupsConsidered; j++){
                percentage_counter += LongFloat(100) * LongFloat(n_exact[i][j]) / LongFloat(total_number_roots);
            }
            std::cout << std::setprecision(3) << percentage_counter << "\t";
                        percentage_counter = 0;
            for (int j = 0; j <= numberBlowupsConsidered; j++){
                percentage_counter += LongFloat(100) * LongFloat(n_lower_bound[i][j]) / LongFloat(total_number_roots);
            }
            std::cout << std::setprecision(3) << percentage_counter << "\t";
        }
        std::cout << "\n\n";
    
        // did we find all root bundles?
        boost::multiprecision::int128_t total_roots_found;
        for (int i = 0; i <= h0Max - h0Min; i++){
            for (int j = 0; j <= numberBlowupsConsidered; j++){
                total_roots_found += n_exact[i][j];
            }
            for (int j = 0; j <= numberBlowupsConsidered; j++){
                total_roots_found += n_lower_bound[i][j];
            }
        }
        
        std::cout << "\n##########################################\n";
        std::cout << "Results:\n";
        std::cout << "-----------------------\n";
        std::cout << "Number of roots found: " << (boost::multiprecision::int128_t) (geo_mult * total_roots_found) << "\n";
        std::cout << "Number of total roots: " << (boost::multiprecision::int128_t) (pow(root, 2 * genus)) << "\n";
        std::cout << "Difference: " << (boost::multiprecision::int128_t) (pow(root, 2 * genus)) - (boost::multiprecision::int128_t) (geo_mult * total_roots_found) << "\n";
        std::cout << "Time for run: " << std::chrono::duration_cast<std::chrono::seconds>(after - before).count() << "[s]\n";
        std::cout << "##########################################\n\n";
        
    }
    
    // set up variables to write to the result file
    std::ofstream ofile;
    std::string dir_path = full_path.substr(0, full_path.find_last_of("."));
    
    // save the result to a dummy file next to main.cpp, so gap can read it out and display intermediate process details
    ofile.open( dir_path + "/result.txt" );
    ofile << "[[";
    for (int i = 0; i < n_exact.size(); i ++){
        ofile << "[";
        for (int j = 0; j < n_exact[i].size()-1; j++){
            ofile << n_exact[i][j] << " ,";
        }
        ofile << n_exact[i][n_exact[i].size()-1] << "],\n";
    }
    ofile << "],\n[";
    for (int i = 0; i < n_lower_bound.size(); i ++){
        ofile << "[";
        for (int j = 0; j < n_lower_bound[i].size()-1; j++){
            ofile << n_lower_bound[i][j] << " ,";
        }
        ofile << n_lower_bound[i][n_lower_bound[i].size()-1] << "],\n";
    }
    ofile << "]];";
    ofile.close();
    
}



// (2) Return simple result
// (2) Return simple result
// (2) Return simple result

void return_simple_result(const std::string & full_path,
                            const std::vector<std::vector<boost::multiprecision::int128_t>> & n_exact,
                            const std::vector<std::vector<boost::multiprecision::int128_t>> & n_lower_bound,
                            const int & numberBlowupsConsidered,
                            const int & numNodesMin,
                            const int & genus,
                            const int & root,
                            const int & h0Min,
                            const int & h0Max,
                            const int & b1,
                            const std::chrono::steady_clock::time_point & before,
                            const std::chrono::steady_clock::time_point & after,
                            const bool & display_details)
{
    
    // did we find all root bundles?
    boost::multiprecision::int128_t geo_mult = (boost::multiprecision::int128_t) (pow(root, b1));
    boost::multiprecision::int128_t total_number_roots = ((boost::multiprecision::int128_t) (pow(root, 2 * genus))/geo_mult);
    boost::multiprecision::int128_t total_roots_found;
    for (int i = 0; i <= h0Max - h0Min; i++){
        for (int j = 0; j <= numberBlowupsConsidered; j++){
            total_roots_found += n_exact[i][j] + n_lower_bound[i][j];
        }
    }
    if (total_roots_found != total_number_roots){
        std::cout << "\n\nNOT ALL ROOTS FOUND!\n\n";
    }
    
    // print the number of those roots with exactly the lowest h0
    using LongFloat=boost::multiprecision::cpp_bin_float_quad;
    boost::multiprecision::int128_t counter;
    for (int i = 0; i <= h0Max - h0Min; i++){
        counter = (boost::multiprecision::int128_t) 0;
        for (int j = 0; j <= numberBlowupsConsidered; j++){
            counter += n_exact[i][j];
        }
        if (counter != 0){
            std::cout << counter << "\t\t";
            LongFloat percentage_counter = LongFloat(100) * LongFloat(counter) / LongFloat(total_number_roots);
            std::cout << std::setprecision(3) << percentage_counter << "\t" << i << "\n";
            break;
        }
    }
}
