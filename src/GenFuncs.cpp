#include "GenFuncs.h"
#include <iostream>

int GenFuncs::xpPause()
{
    std::cout << "Press enter to continue..." << std::endl;
    std::cin.ignore();
    return 0;
}
