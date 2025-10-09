#include "converter.h"
#include <iostream>

using namespace std;
int main (int argc, char** argv){
	Converter convert;
	if( argc > 1){
		string inputQbin = argv[1];
		cout << convert.QfixedBinToInt (inputQbin) << endl;
	}
	return 0;
}

