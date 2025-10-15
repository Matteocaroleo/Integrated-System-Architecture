library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity datapath is
	Port (	
		DIN:	in	std_logic_vector(15-1 downto 0);
		VIN, clock, reset:	in	std_logic;
		VOUT:	out	std_logic;
		B0,B1,B2,B3,B4,B5,B6,B7,B8 : in std_logic_vector(15-1 downto 0);
		DOUT:	out	std_logic_vector(15-1 downto 0)
	);
end datapath;

architecture structural of datapath is

	
	signal to_add_1,to_add_2,to_add_3,to_add_4,to_add_5,to_add_6,to_add_7,to_add_8: std_logic_vector(15-1 downto 0);
	signal to_and: std_logic;
	signal and_temp : std_logic;
	-- signal to_reg_1,to_reg_2,to_reg_3,to_reg_4,to_reg_5,to_reg_6,to_reg_7,to_reg_8 : std_logic_vector(14 downto 0);
	signal out_reg_1,out_reg_2,out_reg_3,out_reg_4,out_reg_5,out_reg_6,out_reg_7,out_reg_8 : std_logic_vector(15-1 downto 0);
	signal out_mul_1,out_mul_2,out_mul_3,out_mul_4,out_mul_5,out_mul_6,out_mul_7,out_mul_8 : std_logic_vector(15-1 downto 0);
	signal out_add_8, DIN_out_reg : std_logic_vector(15-1 downto 0);
	signal VIN_ff: std_logic; --, out_FF2, out_FF3, out_FF4, out_FF5, out_FF6, out_FF7, out_FF8, out_FF9  : std_logic;
	signal B0_tmp,B1_tmp,B2_tmp,B3_tmp,B4_tmp,B5_tmp,B6_tmp,B7_tmp,B8_tmp : std_logic_vector(15-1 downto 0);
	
	
	
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
	
	--regs for b coeff
	REG_B0 : reg port map (clock, reset, '1', B0, B0_tmp);
	REG_B1 : reg port map (clock, reset, '1', B1, B1_tmp);
	REG_B2 : reg port map (clock, reset, '1', B2, B2_tmp);
	REG_B3 : reg port map (clock, reset, '1', B3, B3_tmp);
	REG_B4 : reg port map (clock, reset, '1', B4, B4_tmp);
	REG_B5 : reg port map (clock, reset, '1', B5, B5_tmp);
	REG_B6 : reg port map (clock, reset, '1', B6, B6_tmp);
	REG_B7 : reg port map (clock, reset, '1', B7, B7_tmp);
	REG_B8 : reg port map (clock, reset, '1', B8, B8_tmp);
	
	REG_IN : reg port map (clock, reset, '1', DIN, DIN_out_reg);
	
	MUL0 : mult port map(DIN_out_reg, B0_tmp, to_add_1);
	
	MUL1 : mult port map (out_reg_1, B1_tmp, out_mul_1); 
	ADD1 : add port map (to_add_1, out_mul_1, to_add_2);
	REG1 : reg port map (clock, reset, VIN_ff, DIN_out_reg, out_reg_1);--VIN => enable of FF to freeze FIR filter when VIN = '0'. input & output reg sample continuos (frozen Hillock commenti)
	
	MUL2 : mult port map (out_reg_2, B2_tmp, out_mul_2); 
	ADD2 : add port map (to_add_2, out_mul_2, to_add_3);
	REG2 : reg port map (clock, reset, VIN_ff, out_reg_1, out_reg_2);

	MUL3 : mult port map (out_reg_3, B3_tmp, out_mul_3); 
	ADD3 : add port map (to_add_3, out_mul_3, to_add_4);
	REG3 : reg port map (clock, reset, VIN_ff, out_reg_2, out_reg_3);

	MUL4 : mult port map (out_reg_4, B4_tmp, out_mul_4); 
	ADD4 : add port map (to_add_4, out_mul_4, to_add_5);
	REG4 : reg port map (clock, reset, VIN_ff, out_reg_3, out_reg_4);

	MUL5 : mult port map (out_reg_5, B5_tmp, out_mul_5); 
	ADD5 : add port map (to_add_5, out_mul_5, to_add_6);
	REG5 : reg port map (clock, reset, VIN_ff, out_reg_4, out_reg_5);

	MUL6 : mult port map (out_reg_6, B6_tmp, out_mul_6); 
	ADD6 : add port map (to_add_6, out_mul_6, to_add_7);
	REG6 : reg port map (clock, reset, VIN_ff, out_reg_5, out_reg_6);

	MUL7 : mult port map (out_reg_7, B7_tmp, out_mul_7); 
	ADD7 : add port map (to_add_7, out_mul_7, to_add_8);
	REG7 : reg port map (clock, reset, VIN_ff, out_reg_6, out_reg_7);

	MUL8 : mult port map (out_reg_8, B8_tmp, out_mul_8); 
	ADD8 : add port map (to_add_8, out_mul_8, out_add_8);
	REG8 : reg port map (clock, reset, VIN_ff, out_reg_7, out_reg_8);
	
	REG_OUT : reg port map (clock, reset, '1', out_add_8, DOUT);
	
	FF_in  : ff port map (clock, reset, '1', VIN, VIN_ff);
	FF_out : ff port map (clock, reset, '1', VIN_ff, VOUT);
	
end architecture;
