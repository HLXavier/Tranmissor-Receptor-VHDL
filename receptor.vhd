--------------------------------------
-- Biblioteca
--------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

--------------------------------------
-- Entidade
--------------------------------------
entity receptor is
  port( clock, reset, linha : in std_logic;
        release : out std_logic;
        palavra : std_logic_vector(7 downto 0);
        endereco : std_logic_vector(1 downto 0)
      );
end entity;

--------------------------------------
-- Arquitetura
--------------------------------------
architecture receptor of receptor is
  type states is (SWAIT, A0, A1, S0, S1, S2, S3, S4, S5, S6, S7, SRELEASE);
  signal EA, PE : states;
  signal spalavra : std_logic_vector(7 downto 0);
  signal sendereco :  std_logic_vector(1 downto 0);
begin

  process(clock, reset)
    begin
      if reset = '1' then 
        EA <= SWAIT;
        spalavra <= (others => '0');
        sendereco <= (others => '0');
      elsif rising_edge(clock) then
        EA <= PE;
      end if;
    end process;
    
  spalavra <= palavra;
  sendereco <= endereco;
  release <= '1' when EA = SRELEASE else '0';

  process(EA, linha)
  begin
    case EA is
      when SWAIT =>
        if linha = '0' then
          PE <= A0;
        else
          PE <= SWAIT;
        end if;

      when A0 => PE <= A1; sendereco(0) <= linha;
      when A1 => PE <= S0; sendereco(1) <= linha;
      when S0 => PE <= S1; spalavra(0) <= linha;
      when S1 => PE <= S2; spalavra(1) <= linha;
      when S2 => PE <= S3; spalavra(2) <= linha;
      when S3 => PE <= S4; spalavra(3) <= linha;
      when S4 => PE <= S5; spalavra(4) <= linha;
      when S5 => PE <= S6; spalavra(5) <= linha;
      when S6 => PE <= S7; spalavra(6) <= linha;
      when S7 => PE <= SRELEASE; spalavra(7) <= linha;
      when SRELEASE => PE <= SWAIT;

      end case;
    end process;

end architecture;