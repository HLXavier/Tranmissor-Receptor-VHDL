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
entity transmissores is
  port( clock, reset, release : in std_logic;
        palavra : in words;
        send : in control;
        busy : out control;
        linha : out std_logic
      );
end entity;

--------------------------------------
-- Arquitetura
--------------------------------------
architecture transmissores of transmissores is
  signal req, grant : control;
begin

  TX0 : entity work.tx
    port map(clock => clock,
    reset => reset,
    send => send(0),
    grant => grant(0),
    palavra => palavra(0),
    address => "00",
    busy => busy(0),
    linha => linha,
    req => req(0));

  TX1 : entity work.tx
    port map(clock => clock,
    reset => reset,
    send => send(1),
    grant => grant(1),
    palavra => palavra(1),
    address => "01",
    busy => busy(1),
    linha => linha,
    req => req(1));

  TX2 : entity work.tx
    port map(
    clock => clock,
    reset => reset,
    send => send(2),
    grant => grant(2),
    palavra => palavra(2),
    address => "10",
    busy => busy(2),
    linha => linha,
    req => req(2));

  TX3 : entity work.tx
    port map(clock => clock,
    reset => reset,
    send => send(3),
    grant => grant(3),
    palavra => palavra(3),
    address => "11",
    busy => busy(3),
    linha => linha,
    req => req(3));

  ARBITRO : entity work.arbitro
    port map(
    clock => clock,
    reset => reset,
    release => release,
    req => req,
    grant => grant
    );

end architecture;