library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


entity mult is 
	generic(
		x: integer := 15
	);
	
	
	Port (	A:	In	std_logic_vector((x-1) downto 0);
		B:	In	std_logic_vector((x-1) downto 0);
		M:	Out	std_logic_vector((x-1) downto 0)
	);
end mult; 

architecture BEHAVIORAL of mult is
signal temp: std_logic_vector((2*x-1) downto 0);
begin

process(A, B)
  begin
    temp <= std_logic_vector(signed(A) * signed(B));
 end process;
 process(temp)
  begin
	 M <= temp((2*x-2) downto (x-1));
 end process;

end BEHAVIORAL;
