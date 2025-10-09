#include "converter.h"

using namespace std;

string Converter :: intToBin(string input, int parallelism){
    unsigned int mask= 0x00000001;	// mask for 32 bit parallelism (worst case) 
    bool conversion_succeded = true;
    int inputInt = 0;
    
    // creating default output string
    string output;
    for (int i = 0; i < parallelism; i++){
    	output.append("0");	
    }
    try{
    	inputInt=std::stoi(input);
    }
    catch(...){
        //cerr << "Conversion stoi failed" << endl;
	conversion_succeded = false;
    } 

    /* CONVERION TO BIN */
    if (conversion_succeded){
    	// shifts input and masks it to get the binary value of lsb bit
	for(int i = 0 ; i < parallelism; i++){
        	output [parallelism - 1 - i] = (mask & (inputInt >> i)) + 48;
        }
    }
    else {
	    output = {"ERROR"};
    }
    return output;
}

string Converter :: binToInt(string input){
    int output=0;
    int i = 0;
    bool inputIsValid = true ;
    string strOut;
    
    // input validity checking 
    for (int i = 0; i < input.length (); i++){
	    if(input [i] != '0' && input [i] != '1'){
		    cerr << "Conversion failure" << endl;
		    inputIsValid = false;
	    }
    }
    if (inputIsValid){
	    
	    /* SIGN CHECKING */
	    if (input.front() == '0'){	// case for positive binary number
		    for (int i = 1; i < input.length(); i++){	
	    		    // converts to int		    
			    output = output + (((input [i] - 48)) * (1 << ( (input.length() - 1)  -i )) );
			}
		    }
	    

	    else {	// case for negative binary number
		    for (int i = 1; i < input.length(); i++){
			    // negates binary value
			    if (input [i] == '0'){
				    input [i] = '1';
			    }
			    else {
				    input [i] = '0';
			    }
			    // converts to int
			    output = output + ((input [i] - 48) )*(1 << ( (input.length() - 1) - i));
			}
		    // adds one for 2's complement and add minus
		    output = -(output + 1);
	    }

    	strOut = to_string (output);
    }
    else {
	    strOut = {"ERROR"};
    }
    return strOut;
}

// Takes only Q0.x signed format, where 'x' is defined as the length of input WITHOUT sign bit
string Converter :: QfixedBinToInt (string inputQbin){
	float coefficient = 1; // positional coeff that multiplies the bin value
	float result = 0;
	string str_result;

	// creates string without sign bit
	string uValue = inputQbin.substr(1, inputQbin.size() - 1);
	
	// checks sign
	if (inputQbin[0] == '0'){	// positive value
		for (int i = 0; i < uValue.size(); i++){
			coefficient /= 2;
			result += coefficient * (uValue[i] - 48);
		}
		str_result = to_string (result);
	}
	
	else if (inputQbin[0] == '1'){	// negative value: is in 2's complement
		for (int i = 0; i < uValue.length(); i++){
			    // negates binary value
			    if (uValue [i] == '0'){
				    uValue [i] = '1';
			    }
			    else {
				    uValue [i] = '0';
			    }
			}

		// converts to int
		for (int i = 0; i < uValue.size(); i++){
			coefficient /= 2;
			result += coefficient * (uValue[i] - 48);
		}
		
		//negates value and adds 1 for 2's complement
		result = - (result + coefficient);
		str_result = to_string (result);

	}
	return str_result;
}

// CHANGE NAME FROM 'INT' TO 'FLOAT'
string Converter :: IntToQfixedBin (string inputInt, int bitNum){
	float resolution = 1;
	float inputDecimal = stof (inputInt);
	string result;

	//resolution calc from Q format 
	for (int i = 0; i < bitNum; i++){
		resolution /= 2;
	}	
	result = intToBin(to_string ((int) (inputDecimal / resolution)) , bitNum);
	
	// adding sign
	if (inputDecimal < 0){
		result = '1' + result;
	}
	else {
		result = '0' + result;
	}
	
	return result;
	
}

string Converter :: hexToInt(string input){
	string inputBin;
	string inputInt;
	int i = 0;

	//check format and end of string
	for (int i = 0; i < input.length(); i++) {
		if (((input[i] >= 'A') && (input[i] <= 'F')) || ((input[i] >= 'a') && (input[i] <= 'f')) || ((input[i] >= '0') && (input[i] <= '9'))) {
			inputBin.append(hexToBin(input[i])); // intermediate conversion 
		}
		else{
			return "ERROR";
		}
	}
	inputInt = (binToInt(inputBin));
	return inputInt;
}

string Converter :: hexToBin(char InputChar) {
	switch (InputChar) {
	case '0':
		return "0000";
	case '1':
		return "0001";
	case '2':
		return "0010";
	case '3':
		return "0011";
	case '4':
		return "0100";
	case '5':
		return "0101";
	case '6':
		return "0110";
	case '7':
		return "0111";
	case '8':
		return "1000";
	case '9':
		return "1001";
	case 'A':
		return "1010";
	case 'a':
		return "1010";
	case 'B':
		return "1011";
	case 'b':
		return "1011";
	case 'C':
		return "1100";
	case 'c':
		return "1100";
	case 'D':
		return "1101";
	case 'd':
		return "1101";
	case 'E':
		return "1110";
	case 'e':
		return "1110";
	case 'F':
		return "1111";
	case 'f':
		return "1111";
	default:
		return "error";
	}
	return "error";
}

string Converter :: intToHex(string input){
	unsigned int mask = 0x0000000F;
	bool conversion_succeded = true;
	string output = { "" };
	int inputInt = 0;
	try {
		inputInt = std::stoi(input);
		cout << "inputInt: " << inputInt << endl;
	}
	catch (...) {
		cerr << "Conversion stoi failed" << endl;
		conversion_succeded = false;
	}

	if (conversion_succeded) {
		// shifts input and masks it to get the hexadecimal value of last 4 bits
		int digit = 0;
		for (int i = 0; i < 8; i++) {
			digit = mask & (inputInt >> (i*4));;
			if ((digit >= 0) && (digit <= 9)) {
				// use push_front instead of append to avoid using reverse
				output.append(to_string(digit));
			}
			else if (digit == 10){
				output.append("A");
			}
			else if (digit == 11) {
				output.append("B");
			}
			else if (digit == 12) {
				output.append("C");
			}
			else if (digit == 13) {
				output.append("D");
			}
			else if (digit == 14) {
				output.append("E");
			}
			else if (digit == 15) {
				output.append("F");
			}
		}
		reverse (output.begin(), output.end()); // reverse 
	}
	else {
		output = { "ERROR" };
	}
	return output;
}
