#include "GenFuncs.h"
#include <iostream>

int GenFuncs::pauseprompt()
{
    std::cout << "Press enter to continue..." << std::endl;
    std::cin.ignore();
    return 0;
}
