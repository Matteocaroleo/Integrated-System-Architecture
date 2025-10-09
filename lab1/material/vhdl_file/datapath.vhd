library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity datapath is
	Port (	
		DIN:	in	std_logic_vector(14 downto 0);
		VIN, clock, reset, enable:	in	std_logic;
		VOUT:	out	std_logic;
		DOUT:	out	std_logic_vector(14 downto 0)
	);
end datapath;

architecture structural of datapath is

	signal b0,b1,b2,b3,b4,b5,b6,b7,b8 : std_logic_vector(14 downto 0);
	signal to_add_1,to_add_2,to_add_3,to_add_4,to_add_5,to_add_6,to_add_7,to_add_8,to_add_9 : std_logic_vector(14 downto 0);
	signal to_reg_1,to_reg_2,to_reg_3,to_reg_4,to_reg_5,to_reg_6,to_reg_7,to_reg_8 : std_logic_vector(14 downto 0);
	signal out_reg_1,out_reg_2,out_reg_3,out_reg_4,out_reg_5,out_reg_6,out_reg_7,out_reg_8 : std_logic_vector(14 downto 0);
	signal out_mul_1,out_mul_2,out_mul_3,out_mul_4,out_mul_5,out_mul_6,out_mul_7,out_mul_8 : std_logic_vector(14 downto 0);
	signal out_add_8, DIN_out_reg : std_logic_vector(14 downto 0);
	signal VIN_ff, out_FF1, out_FF2, out_FF3, out_FF4, out_FF5, out_FF6, out_FF7, out_FF8, out_FF9  : std_logic;
	
	
	
	component add
		generic(
			x: integer := 15
		);
		Port (	A:	In	std_logic_vector((x-1) downto 0);
			B:	In	std_logic_vector((x-1) downto 0);
			S:	Out	std_logic_vector((x-1) downto 0)
		);
	end component;
	
	component reg
		generic (
			N : positive := 15  --parallelismo
		);
		port (
			CLK : in  std_logic;                             
			reset : in  std_logic;                             
			E  : in  std_logic;                             
			D   : in  std_logic_vector((N-1) downto 0);    
			Q   : out std_logic_vector((N-1) downto 0)     
		);
	end component;
	
	component ff
		port (
			CLK : in  std_logic;                             
			reset : in  std_logic;                             
			E  : in  std_logic;                             
			D   : in  std_logic;    
			Q   : out std_logic     
		);
	end component;
	
	
	component mult
		generic(
			x: integer := 15
		);
		Port (	
			A:	In	std_logic_vector((x-1) downto 0);
			B:	In	std_logic_vector((x-1) downto 0);
			M:	Out	std_logic_vector((x-1) downto 0)
		);
	end component;
	
	begin 
	
	b0 <= "1111111100110101";
	b1 <= "1111111001000011";
	b2 <= "0000011010001101";
	b3 <= "0010000111111111";
	b4 <= "0011001111101010";
	b5 <= "0010000111111111";
	b6 <= "0000011010001101";
	b7 <= "1111111001000011";
	b8 <= "1111111100110101";
	

	
	REG_IN : reg port map (clock, reset, '1', DIN, DIN_out_reg);
	
	MUL0 : mult port map(DIN_out_reg, b0, to_add_1);
	
	MUL1 : mult port map (out_reg_1, b1, out_mul_1); 
	ADD1 : add port map (to_add_1, out_mul_1, to_add_2);
	REG1 : reg port map (clock, reset, VIN_ff, DIN_out_reg, out_reg_1);--VIN => enable of FF to freeze FIR filter when VIN = '0'. input & output reg sample continuos
	
	MUL2 : mult port map (out_reg_2, b2, out_mul_2); 
	ADD2 : add port map (to_add_2, out_mul_2, to_add_3);
	REG2 : reg port map (clock, reset, VIN_ff, out_reg_1, out_reg_2);

	MUL3 : mult port map (out_reg_3, b3, out_mul_3); 
	ADD3 : add port map (to_add_3, out_mul_3, to_add_4);
	REG3 : reg port map (clock, reset, VIN_ff, out_reg_2, out_reg_3);

	MUL4 : mult port map (out_reg_4, b4, out_mul_4); 
	ADD4 : add port map (to_add_4, out_mul_4, to_add_5);
	REG4 : reg port map (clock, reset, VIN_ff, out_reg_3, out_reg_4);

	MUL5 : mult port map (out_reg_5, b5, out_mul_5); 
	ADD5 : add port map (to_add_5, out_mul_5, to_add_6);
	REG5 : reg port map (clock, reset, VIN_ff, out_reg_4, out_reg_5);

	MUL6 : mult port map (out_reg_6, b6, out_mul_6); 
	ADD6 : add port map (to_add_6, out_mul_6, to_add_7);
	REG6 : reg port map (clock, reset, VIN_ff, out_reg_5, out_reg_6);

	MUL7 : mult port map (out_reg_7, b7, out_mul_7); 
	ADD7 : add port map (to_add_7, out_mul_7, to_add_8);
	REG7 : reg port map (clock, reset, VIN_ff, out_reg_6, out_reg_7);

	MUL8 : mult port map (out_reg_8, b8, out_mul_8); 
	ADD8 : add port map (to_add_8, out_mul_8, out_add_8);
	REG8 : reg port map (clock, reset, VIN_ff, out_reg_7, out_reg_8);
	
	REG_OUT : reg port map (clock, reset, '1', out_add_8, DOUT);
	
	
	--FF to delay VIN to generate VOUT
	
	
	FF1  : ff port map (clock, reset, '1', VIN, VIN_ff);
	FF2  : ff port map (clock, reset, VIN_ff, out_FF1, out_FF2);
	FF3  : ff port map (clock, reset, VIN_ff, out_FF2, out_FF3);
	FF4  : ff port map (clock, reset, VIN_ff, out_FF3, out_FF4);
	FF5  : ff port map (clock, reset, VIN_ff, out_FF4, out_FF5);
	FF6  : ff port map (clock, reset, VIN_ff, out_FF5, out_FF6);
	FF7  : ff port map (clock, reset, VIN_ff, out_FF6, out_FF7);
	FF8  : ff port map (clock, reset, VIN_ff, out_FF7, out_FF8);
	FF9  : ff port map (clock, reset, VIN_ff, out_FF8, out_FF9);
	FF10 : ff port map (clock, reset, '1', out_FF9, VOUT);

	
end architecture;
