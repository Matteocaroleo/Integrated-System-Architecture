library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


entity mul is 
	generic(
		x: integer := 15
	);
	
	
	Port (	A:	In	std_logic_vector(14 downto 0);
		B:	In	std_logic_vector(14 downto 0);
		M:	Out	std_logic_vector((x-1) downto 0)
	);
end mul; 

architecture BEHAVIORAL of mul is
signal temp: std_logic_vector(29 downto 0);
begin

process(A, B)
  begin
    temp <= std_logic_vector(signed(A) * signed(B));
 end process;
 process(temp)
  begin
	 M <= temp(29 downto (30-x));
 end process;

end BEHAVIORAL;
