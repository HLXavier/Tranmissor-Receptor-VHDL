library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--------------------------------------
-- Descreva Aqui a Entidade
--------------------------------------

entity tx is
    port (
        clock, reset, send, grant : in std_logic;
        palavra : in std_logic_vector(7 downto 0);
        address : in std_logic_vector(1 downto 0);
        busy, linha, req : out std_logic
    );

end tx;


--------------------------------------
-- Descreva aqui a Arquitetura
--------------------------------------

architecture transmissor of tx is
    type STATES is (SWAIT, SREQ, SSTART, A0, A1, S0, S1, S2, S3, S4, S5, S6, S7, SSTOP);
    signal EA, PE : STATES;


--process classico pra estados
begin
    process(clock, reset)
        begin
            if reset = '1' then EA <= SWAIT;
            elsif rising_edge(clock) then
                EA <= PE;
            end if;
        end process;

  process(EA, send, grant)
  begin
    case EA is
      when SWAIT =>  
        if send='1' then 
          PE <= SREQ; 
        else PE <= SWAIT; 
        end if;

      when SREQ => 
        if grant = '1' then
          PE <= SSTART;
        else
          PE <= SREQ;
        end if;

      when SSTART =>   PE <= A0;

      when A0 => PE <= A1;
      when A1 => PE <= S0;

      when S0 =>   PE <= S1;
      when S1 =>   PE <= S2;
      when S2 =>   PE <= S3;
      when S3 =>   PE <= S4;
      when S4 =>   PE <= S5;
      when S5 =>   PE <= S6;
      when S6 =>   PE <= S7;
      when S7 =>   PE <= SSTOP;
            
        when SSTOP  =>   PE <= SWAIT;
    end case;  
  end process;

  req <= '1' when EA = SREQ else '0';
    
  busy <= '0' when EA = SWAIT else '1';

  linha <= 

    address(0)    when EA=A0 else
    address(1)    when EA=A1 else

    palavra(0)    when EA=S0 else
    palavra(1)    when EA=S1 else
    palavra(2)    when EA=S2 else
    palavra(3)    when EA=S3 else
    palavra(4)    when EA=S4 else
    palavra(5)    when EA=S5 else
    palavra(6)    when EA=S6 else
    palavra(7)    when EA=S7 else

    '0' when EA = SSTART or EA = SSTOP else 
    'H';
     
end transmissor;