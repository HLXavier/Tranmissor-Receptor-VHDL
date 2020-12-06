--------------------------------------
-- Biblioteca
--------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

--------------------------------------
-- Pacote
--------------------------------------
package p_arb is         
  type control is array(0 to 3) of std_logic;
  type words is array(0 to 3) of std_logic_vector(7 downto 0);
end package;