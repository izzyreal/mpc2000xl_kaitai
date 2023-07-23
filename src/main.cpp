#include <cstdio>

#include "parser/mpc2000xl_all.h"
#include <fstream>

int main() {
    std::ifstream ifs("../testdata/ALL/seq0-used-seq1-unused-seq2-used.ALL", std::ifstream::binary);
    kaitai::kstream ks(&ifs);
    mpc2000xl_all_t parser(&ks);
    auto sequences = parser.sequences();

    for (auto& s : *sequences)
    {
        auto idx = s->body()->index();
        auto name = s->name();
        printf("Sequence %d name: %s\n", idx, name.c_str());
    }
};