----------------------------------------------------------------
-- SBA DataIntf
--
-- version 1.0 20091001
--
-- Miguel A. Risco Castillo
-- email: mrisco@accesus.com
-- webpage: http://mrisco.accesus.com
--
-- Data Output Bus interface
-- Use to connect SBA Slave blocks to SBA input data bus
-- Allow to the synthesizer to inferring a bus multiplexer
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.SBA_config.all;

entity  DataIntf  is
port(
   STB_I: in  std_logic;           -- Strobe input Chip selector
   DAT_I: in  DATA_type;           -- Data Bus from slave       
   DAT_O: out DATA_type            -- output Data Bus to master
);
end DataIntf;

architecture DataIntf_Arch of DataIntf is
begin
  DAT_O <= DAT_I when STB_I='1' else (others=>'Z');
end DataIntf_Arch;
