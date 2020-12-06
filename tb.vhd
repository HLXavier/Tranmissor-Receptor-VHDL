--------------------------------------
-- Biblioteca
--------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.CONV_STD_LOGIC_VECTOR;
use work.p_arb.all;

--------------------------------------
-- Entidade
--------------------------------------
entity tb is
end entity;

--------------------------------------
-- Arquitetura
--------------------------------------
architecture tb of tb is
  signal clock : std_logic := '0';
  signal reset, linha, fim, release : std_logic;
  signal saida : std_logic_vector(7 downto 0);
  signal endereco : std_logic_vector(1 downto 0);
  signal palavra : words;
  signal send, busy : control;

  type test_record is record
    word :  words;
    sendt:  control;
  end record;

  type padroes is array(natural range <>) of test_record;

  constant padrao_de_teste : padroes := (
    (word => (x"00", x"00", x"2B", x"00"), sendt=>('0', '0', '1', '0' )),    -- '2' pede
    (word => (x"00", x"1A", x"00", x"22"), sendt=>('0', '1', '0', '1' )),    -- dois requests simultâneos '1' e '3'
    (word => (x"00", x"3C", x"00", x"00"), sendt=>('0', '1', '0', '0' )),    -- 1 pede
    (word => (x"4D", x"5E", x"6F", x"8B"), sendt=>('1', '1', '1', '1' )),    -- todos pede
    (word => (x"33", x"00", x"00", x"00"), sendt=>('1', '0', '0', '0' )),    -- 0 pede
    (word => (x"00", x"00", x"AA", x"DD"), sendt=>('0', '0', '1', '1' )),    -- 2 e 3 pedem
    (word => (x"8B", x"00", x"00", x"00"), sendt=>('1', '0', '0', '0' )) );  -- 0 pede

begin

  TXS : entity work.transmissores
        port map ( clock     => clock,
		           reset     => reset,
                   palavra   => palavra,
                   send      => send,
                   busy      => busy,
                   release   => release,
                   linha     => linha
                 );

  RXT : entity work.receptor
        port map (  clock    => clock,
		            reset    => reset, 
                    palavra  => saida,
                    endereco => endereco,
                    linha    => linha,
                    release  => release
                 );

  reset <= '1', '0' after 5 ns;    
  clock <= not clock after 5 ns;

  TEST: process
  begin       
    for i in 0 to padrao_de_teste'high loop    

      palavra <=  padrao_de_teste(i).word;
      send    <=  padrao_de_teste(i).sendt; 
      wait for 25 ns;

      -- depois de fazer o send já desce o mesmo
      send    <=  ('0', '0', '0', '0' ); 
      wait for 25 ns;

      ---- aguardo todos os transmissores estarem livres
      wait until busy(0)='0' and busy(1)='0' and busy(2)='0' and busy(3)='0'; 

      wait for 100 ns;
    end loop; 
  end process; 

end architecture;