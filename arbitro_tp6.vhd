--------------------------------------
-- Biblioteca
--------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.p_arb.all;

--------------------------------------
-- Entidade
--------------------------------------
entity arbitro is
	port( clock, reset, release : in std_logic;
        req : in control;
        grant : out control);
end entity;

--------------------------------------
-- Arquitetura
--------------------------------------
architecture arbitro of  arbitro is
	type states is ( IDLE, SSELECT, ACK, WAITING );
	signal EA, PE : states;
	signal sel : std_logic_vector(1 downto 0);
begin
	-- Processo para troca de estados
	process(reset, clock)
	begin
		if reset='1' then
			EA <= IDLE;
		elsif rising_edge(clock) then
			EA <= PE;
		end if;
	end process;

	-- Processo para definir o proximo estado
	process (EA, req, release)
		begin
			case EA is
				when IDLE =>
					if req = "0000" then
						PE <= IDLE;
					else
						PE <= SSELECT;
					end if;
				when SSELECT =>
					PE <= ACK;
				when ACK =>
					PE <= WAITING;
				when WAITING =>
					if release = '1' then
						PE <= IDLE;
					else
						PE <= WAITING;
					end if;
				when others =>
					PE <= IDLE;
			end case;
	end process;

	-- Bloco de dados conforme as laminas
	grant(0) <= '1' when EA = ACK and sel = "00" else '0';
	grant(1) <= '1' when EA = ACK and sel = "01" else '0';
	grant(2) <= '1' when EA = ACK and sel = "10" else '0';
	grant(3) <= '1' when EA = ACK and sel = "11" else '0';

	process(reset, clock)
		begin
			if reset='1' then
				sel <= "00";
			elsif rising_edge(clock) then
				if EA=SSELECT then
				if req(CONV_INTEGER(sel+1))='1' then
					sel <= sel + 1;
				elsif req(CONV_INTEGER(sel+2))='1' then
					sel <= sel + 2;
				elsif req(CONV_INTEGER(sel+3))='1' then
					sel <= sel + 3;
				end if;
			end if;
		end if;
	end process;

end architecture;