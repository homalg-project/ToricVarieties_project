// (1) Helper functions to print vectors and vectors of vectors
// (1) Helper functions to print vectors and vectors of vectors
// (1) Helper functions to print vectors and vectors of vectors

void print_vector(const std::string &message, const std::vector<int> &values)
{
    std::cout << message;
    for (auto i: values)
        std::cout << i << ", ";
    std::cout << "\n";
}

void print_vector_of_vector(const std::string &message, const std::vector<std::vector<int>> &values)
{
    std::cout << message;
    for (int i = 0; i < values.size(); i++){
        print_vector("", values[i]);
    }
    std::cout << "\n";
}
