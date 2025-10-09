#include <iostream>
#include <fstream>
#include "converter.h"

using namespace std;
int main (int argc, char** argv){
	// for calling from terminal
	ofstream converted_input_file;
	Converter convert;

	converted_input_file.open ("../converted_inputs.txt", ios_base::app);
	if (argc > 1){
		 // converted_input_file << convert.IntToQfixedBin (argv[1], 19) << endl;
		 cout << convert.IntToQfixedBin (argv[1], 19) << endl;
	}
	else {
		cout << "Wrong format, usage: \n ./convertInt [int] " << endl;
	}
	converted_input_file.close();
	return 0;

	/* for doing all in cpp
	ifstream input_decimals;
	ofstream output_qBins;
	*/
}
