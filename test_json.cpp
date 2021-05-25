#include <algorithm>
#include <iostream>
#include <iterator>
#include <nlohmann/json.hpp>
#include <string>
#include <set>
#include <vector>

using namespace std;
using json = nlohmann::json;

template <typename Type>
void print_set(const set<Type> uset) {
    for (auto thing : uset) {
        cout << thing << ' ';
    }
    cout << endl;
}

template <typename Type>
void print_vec(const vector<Type> uset) {
    for (auto thing : uset) {
        cout << thing << ' ';
    }
    cout << endl;
}

int main()
{
    string json_str = "{\"reserved_node_id_by_shard\": [[ 1, 2, 3 ], [2, 3, 4], [3, 4, 5]]}";
    // string json_str = "\"type_alias\":   \"Bar\"";
    cout << json_str << endl;
    json test_json = json::parse(json_str.c_str());
    // cout << "test_json.contains(\"reserved_node_id_by_shard\"): " << (test_json.contains("reserved_node_id_by_shard")?"true":"false") << endl;

    std::vector<std::set<int>> reserved_node_id_by_shard;
    reserved_node_id_by_shard = test_json["reserved_node_id_by_shard"].get<vector<set<int>>>();

    // set<int> all_id;
    // for(auto id_set : reserved_node_id_by_shard) {
    //     std::set_union(all_id.begin(), all_id.end(), id_set.begin(), id_set.end(), std::inserter(all_id, all_id.begin()));
    // }
    // for(int id : all_id)
    //     cout << id << ' ';
    // cout << endl;

    set<int> difference_set;
    vector<int> out;
    std::set_difference(reserved_node_id_by_shard[0].begin(), reserved_node_id_by_shard[0].end(),
                        reserved_node_id_by_shard[1].begin(), reserved_node_id_by_shard[1].end(),
                        std::inserter(out, out.end()));
    std::set_difference(reserved_node_id_by_shard[0].begin(), reserved_node_id_by_shard[0].end(),
                        reserved_node_id_by_shard[1].begin(), reserved_node_id_by_shard[1].end(),
                        std::inserter(out, out.end()));
    std::set_difference(reserved_node_id_by_shard[0].begin(), reserved_node_id_by_shard[0].end(),
                        reserved_node_id_by_shard[1].begin(), reserved_node_id_by_shard[1].end(),
                        std::inserter(out, out.end()));
    print_set<int>(reserved_node_id_by_shard[0]);
    print_set<int>(reserved_node_id_by_shard[1]);
    print_vec<int>(out);

    return 0;
}