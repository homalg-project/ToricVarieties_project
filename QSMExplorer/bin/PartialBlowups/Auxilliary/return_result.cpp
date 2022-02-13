// (1) Return result
// (1) Return result
// (1) Return result

void return_result(const std::string & full_path,
                            const std::vector<std::vector<boost::multiprecision::int128_t>> & n_exact,
                            const std::vector<std::vector<boost::multiprecision::int128_t>> & n_lower_bound,
                            const int & number_of_edges,
                            const int & genus,
                            const int & root,
                            const int & h0Min,
                            const int & h0Max,
                            const int & b1,
                            const bool & display_details)
{
    
    // print result
    if (display_details){
        
        // print the exact numbers
        std::cout << "\n";
        for (int j = 0; j <= number_of_edges; j++){
            std::cout << j << ":\t";
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
            for (int j = 0; j <= number_of_edges; j++){
                counter += n_exact[i][j];
            }
            std::cout << counter << "\t";
            counter = (boost::multiprecision::int128_t) 0;
            for (int j = 0; j <= number_of_edges; j++){
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
        for (int j = 0; j <= number_of_edges; j++){
            std::cout << j << ":\t";
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
            for (int j = 0; j <= number_of_edges; j++){
                percentage_counter += LongFloat(100) * LongFloat(n_exact[i][j]) / LongFloat(total_number_roots);
            }
            std::cout << std::setprecision(3) << percentage_counter << "\t";
                        percentage_counter = 0;
            for (int j = 0; j <= number_of_edges; j++){
                percentage_counter += LongFloat(100) * LongFloat(n_lower_bound[i][j]) / LongFloat(total_number_roots);
            }
            std::cout << std::setprecision(3) << percentage_counter << "\t";
        }
        std::cout << "\n\n";
    
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
