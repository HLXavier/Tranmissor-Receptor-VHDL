--------------------------------------
-- Biblioteca
--------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

--------------------------------------
-- Entidade
--------------------------------------
entity tb is
end entity;

--------------------------------------
-- Arquitetura
--------------------------------------
architecture tb of tb is
  constant address: std_logic_vector(1 downto 0) := "10";
  signal linha, reset, send, req, busy, grant: std_logic;
  signal palavra : std_logic_vector(7 downto 0);
  signal clock : std_logic := '0';

  type padroes is array(natural range <>) of std_logic_vector(7 downto 0);
  constant words : padroes := (x"AB", x"BC", x"DE", x"EF", x"33", x"11", x"88");
begin
    DUT : entity work.tx_req
          port map ( address =>address, clock => clock, reset => reset, send => send,
                     busy => busy, palavra => palavra, linha => linha, req => req, grant => grant );

    -- gerador de clock
    clock <=  not clock after 10 ns;

    reset <= '1', '0' after 3 ns;   

   process
     variable i : integer := 0;
   begin
     -- ativa o send ------------------------------------------------------
     palavra <= words(i);
     send    <='0';    
     grant   <= '0';
     wait for 20 ns;
     i := i + 1;
     send    <='1';
     wait for 20 ns;
     send    <= '0';  

     -- tempo para dar o grant -----------------------------------------------------
     wait for 40 ns;
     grant <= '1';
     wait for 20 ns;
     grant <= '0';

     -- eespera que o busy desça ------------------------
     wait until busy ='0';
     wait for 80 ns;
   end process;

end architecture;