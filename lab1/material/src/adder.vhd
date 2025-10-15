library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


entity add is 
	generic(
		x: integer := 15
	);
	
	
	Port (	A:	In	std_logic_vector((x-1) downto 0);
		B:	In	std_logic_vector((x-1) downto 0);
		S:	Out	std_logic_vector((x-1) downto 0)
	);
end add; 

architecture BEHAVIORAL of add is
signal temp: std_logic_vector ((x-1) downto 0);
begin

process(A, B)
	begin
		temp <= std_logic_vector(signed(A) + signed(B));
 end process;
 process(temp)
	begin
	S <= temp((x-1) downto 0);
	end process;

end BEHAVIORAL;
