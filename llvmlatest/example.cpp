#include <meta>
#include <iostream>
#include <string>

struct Person {
    std::string name;
    int age;
    double height;
};

template<typename T>
void print_members(const T& obj) {
    std::cout << "Members of " << std::meta::name_v<^^T> << ":\n";

    // Get reflections of all non-static data members
    for (constexpr std::meta::info member : std::meta::nonstatic_data_members_of<^^T>) {
        // Print the member's name
        std::cout << "  " << std::meta::name_v<^^member> << ": ";

        // Splice to access the actual member value
        std::cout << obj.[:member:] << '\n';
    }
}

int main() {
    Person p{"Alice", 30, 1.75};

    print_members(p);
}
