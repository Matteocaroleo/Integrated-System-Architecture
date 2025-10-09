/// @file converter.h
/// @brief Header file for Converter class
//
#ifndef CONVERTER_H
#define CONVERTER_H

#include <string>
#include <cstring>
#include <iostream>
#include <stdlib.h>
#include <algorithm>

/// @class Converter
/// @brief Class for manipulating integer, binary and hex conversions	 
using namespace std;

class Converter{
public:
    string intToBin (string input, int parallelism);
    string binToInt (string inputBin);
    string QfixedBinToInt (string inputQbin);
    string IntToQfixedBin (string inputInt, int bitNum);
    string hexToInt (string inputHex);
    string intToHex (string inputInt);
    
private:
    string hexToBin(char input);
};

#endif //CONVERTER_H
