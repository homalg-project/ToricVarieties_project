#include <bits/stdc++.h>

int merge(int* parent, int x)
{
    if (parent[x] == x)
        return x;
    return merge(parent, parent[x]);
}

int betti_number(int &v, std::vector<std::vector<int>>& edges)
{
    
    // count number of components
    int c = 0;
    int parent[v];
    for (int i = 0; i < v; i++) {
        parent[i] = i;
    }
    for (auto x : edges) {
        parent[merge(parent, x[0])] = merge(parent, x[1]);
    }
    for (int i = 0; i < v; i++) {
        c += (parent[i] == i);
    }
    for (int i = 0; i < v; i++) {
        parent[i] = merge(parent, parent[i]);
    }
    std::map<int, std::list<int>> m;
    for (int i = 0; i < v; i++) {
        m[parent[i]].push_back(i);
    }
    
    // compute betti number
    return edges.size() + c - v;
    
}
