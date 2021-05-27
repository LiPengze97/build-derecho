#include <algorithm>
#include <iostream>
#include <iterator>
#include <nlohmann/json.hpp>
#include <string>
#include <set>
#include <vector>
#include <sstream>

using namespace std;
using json = nlohmann::json;

template <typename Type>
void print_set(const std::set<Type> uset)
{
    std::stringstream stream;
    for (auto thing : uset)
    {
        stream << thing << ' ';
    }
    std::string out = stream.str();
    cout << out << endl;
}

template <typename Type>
void print_set(const vector<Type> uset)
{
    for (auto thing : uset)
    {
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

    // set<int> difference_set;
    // vector<int> out;
    // print_set<int>(reserved_node_id_by_shard[0]);
    // print_set<int>(reserved_node_id_by_shard[1]);
    // std::set_intersection(reserved_node_id_by_shard[0].begin(), reserved_node_id_by_shard[0].end(),
    //                     reserved_node_id_by_shard[1].begin(), reserved_node_id_by_shard[1].end(),
    //                     std::inserter(out, out.begin()));
    // print_set<int>(out);

    /** This function is invoked if there is a prev_view, and the members is already
     * arranged into two parts: the first part hold survive nodes from prev_view, and the second
     * part holds newly added nodes. The next_unassigned_rank is the length of the first part.
     * If we have reserved node_ids, we need to rearrnage members into 3 parts:
     * the first part holds reserved node_ids, no matter it's from prev_view or newly added,
     * the second part holds survive non-reserved node_ids,
     * and the third part holds newly added non-reserved node_ids.
     * We then rearrange next_unassigned_rank to be the length of the first two parts, for they are assigned already.
     */
    std::vector<int> members{0, 1, 2, 3, 4, 5, 6};
    int next_unassigned_rank = 4; // 0 1 2 3 survive
    std::set<int> all_reserved_node_ids{2, 3, 4, 5};

    std::vector<int> curr_members;
    std::set<int> curr_member_set(members.begin(), members.end());
    std::set<int> survive_member_set(members.begin(), members.begin() + next_unassigned_rank);
    std::set<int> added_member_set(members.begin() + next_unassigned_rank, members.end());
    if (all_reserved_node_ids.size() > 0)
    {
        std::set_intersection(
            curr_member_set.begin(), curr_member_set.end(),
            all_reserved_node_ids.begin(), all_reserved_node_ids.end(),
            std::inserter(curr_members, curr_members.end()));
        std::set_difference(
            survive_member_set.begin(), survive_member_set.end(),
            all_reserved_node_ids.begin(), all_reserved_node_ids.end(),
            std::inserter(curr_members, curr_members.end()));
        next_unassigned_rank = curr_members.size();
        std::set_difference(
            added_member_set.begin(), added_member_set.end(),
            all_reserved_node_ids.begin(), all_reserved_node_ids.end(),
            std::inserter(curr_members, curr_members.end()));
    }
    print_set<int>(curr_members);
    cout << next_unassigned_rank << endl;
    return 0;
}