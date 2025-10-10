library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity variableMult is
	generic (
		datawidth : integer := 15
	);
	port (
		A:	in std_logic_vector (14 downto 0);
		B:	in std_logic_vector (14 downto 0);
		Y:	out std_logic_vector(datawidth-1 downto 0)
	);
end entity variableMult;

architecture behavioral of variableMult is

	signal Y_t: std_logic_vector (2*datawidth-1 downto 0);
	begin --behavioral 
		
		process (A, B)
		begin
			Y_t <= std_logic_vector (signed(A) * signed(B));
			-- -2 because the sign is doubled
			Y <= Y_t (2*datawidth-2 downto datawidth-1);
	end process;
end architecture behavioral;
