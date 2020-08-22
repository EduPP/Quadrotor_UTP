----------------------------------------------------------------
-- SBA SysCon
-- System CLK & Reset Generator
--
-- v0.1
-- 20110410
--
-- Miguel A. Risco Castillo
-- email: mrisco@accesus.com
-- webpage: http://mrisco.accesus.com
--
-- Notes:
--
-- v0.1
-- First version
--
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sba_config.all;
use work.sba_package.all;

entity  SysCon  is
port(
   CLK_I: in  std_logic;          -- External Clock input
   CLK_O: out std_logic;          -- System Clock output 
   RST_I: in  std_logic;          -- Asynchronous Reset Input
   RST_O: out std_logic           -- Synchronous Reset Output
);
end SysCon;

architecture SysCon_arch of SysCon is

   Signal CLKi : std_logic;
   Signal RSTi : std_logic;

begin

  process(RST_I, CLKi)
  begin
    if RST_I='1' then
      RSTi<='1';
    elsif rising_edge(CLKi) then
      RSTi<='0';
    end if;
  end process;

  process(RSTi,CLKi)
  begin
    if RSTi='1' then
      RST_O<='1';
    elsif rising_edge(CLKi) then
      RST_O<='0';
    end if;
  end process; 

CLKi  <= CLK_I;                   -- Insert a divider if is needed

CLK_O <= CLKi;
  
end SysCon_arch;
