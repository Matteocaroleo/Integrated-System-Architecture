library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
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
end entity reg;

architecture BEHAVIORAL of reg is
begin

  proc_reg : process(CLK, reset)
  begin
    if reset = '0' then
		Q <= (others => '0');  
    elsif rising_edge(CLK) then
      if E = '1' then
        Q <= D;
      end if;
    end if;
  end process;


end architecture;
