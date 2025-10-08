library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff is
  port (
    CLK : in  std_logic;                             
    reset : in  std_logic;                             
    E  : in  std_logic;                             
    D   : in  std_logic;    
    Q   : out std_logic     
  );
end entity ff;

architecture BEHAVIORAL of ff is
begin

  proc_reg : process(CLK, reset)
  begin
    if reset = '0' then
		Q <= '0';  
    elsif rising_edge(CLK) then
      if E = '1' then
        Q <= D;
      end if;
    end if;
  end process;


end architecture;
