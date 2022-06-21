#include <unordered_map>

// Create a customer Key struct for lookup in our hash table
// define equivalence 
struct customKey {
    int N;
    int n;
    std::vector<int> minima;
    std::vector<int> maxima;

    bool operator==(const customKey &other) const {
        return (N == other.N && n == other.n && minima == other.minima && maxima == other.maxima);
    }
};

// Create a custom key hasher for our table

struct KeyHasher {
    std::size_t operator()(const customKey& k) const {
        using std::size_t;
        using std::hash;
        using std::string;

        std::size_t h1 = std::hash<int>()(k.N);
        std::size_t h2 = std::hash<int>()(k.n);
        std::size_t h3 = k.minima.size();
        std::size_t h4 = k.maxima.size();

        for (auto &i : k.minima) {
            h3 ^= i + 0x9e3779b9 + (h3 << 6) + (h3 >> 2);
        }

        for (auto &i : k.maxima) {
            h4 ^= i + 0x9e3779b9 + (h4 << 6) + (h4 >> 2);
        }

        return h1^h2^h3^h4;

    }
};

class customHash {


	public:
		std::unordered_map<customKey, std::vector<std::vector<int>>, KeyHasher> hashTable;

		// adds value to hashtable
		void add_value(customKey key, std::vector<std::vector<int>> vector) {
			hashTable[key] = vector;
		};


		// returns true if key is found in hashtable
		bool in_set(customKey key) {
			return hashTable.count(key) !=0;
		};

		// returns value from hashtable
		std::vector<std::vector<int>> get_value(customKey key) {
			return hashTable[key];
		};

		int size(){
			return hashTable.size();
		};



};