----------------------------------------------------------------
-- SBA_config
-- Constants for system configuration and adress map
--
-- v1.3
-- 20120613
--
-- Miguel A. Risco Castillo
-- email: mrisco@accesus.com
-- webpage: http://mrisco.accesus.com
--
-- Notes:
--
-- v1.3
-- Added the type definitions
--
-- v1.2
-- Included constants for STB lines
--
-- v1.1
-- Include constants for address map
--
-- v1.0
-- First version
--
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package SBA_config is

-- System configuration
  constant debug : integer := 1;            -- '1' for Debug reports
  constant Adr_width: integer := 10;         -- Width of address bus
  constant Dat_width: integer := 16;        -- Width of data bus
  constant Stb_width: integer := 15;         -- number of strobe signals (chip select)
  constant max_steps: integer := 100;        -- Max number of steps on SBAController
  constant sysfrec  : integer := 50e6;      -- Main system clock frequency

-- Address Map
  constant GPIOAceleX: integer := 1;
  constant GPIOAceleY: integer := 2;
  constant GPIOAceleZ: integer := 3;
  
  constant GPIOTempGy: integer := 4;
  constant GPIOGyrosX: integer := 5;
  constant GPIOGyrosY: integer := 6;
  constant GPIOGyrosZ: integer := 7;
  
  constant GPIOMagneX: integer := 8;
  constant GPIOMagneY: integer := 9;
  constant GPIOMagneZ: integer := 10;
  
  constant I2C      : integer := 20;
  constant I2C_reg0 : integer := 20; 
  constant I2C_reg1 : integer := 21;
  constant I2C_reg2 : integer := 22;
  constant I2C_reg3 : integer := 23;
  --constant LEDS     : integer := 7;  

--Strobe Lines
 -- constant STB_GPIO  : integer := 0;
  constant STB_I2C   : integer := 1;
  
  constant STB_AceleX  : integer := 2;
  constant STB_AceleY  : integer := 3;
  constant STB_AceleZ  : integer := 4;
  
  constant STB_TempGy  : integer := 5;
  constant STB_GyrosX  : integer := 6;
  constant STB_GyrosY  : integer := 7;
  constant STB_GyrosZ  : integer := 8;

  constant STB_MagneX  : integer := 9;
  constant STB_MagneY  : integer := 10;
  constant STB_MagneZ  : integer := 11;

-- System Type definitions
  subtype ADDR_type is std_logic_vector(Adr_width-1 downto 0);
  subtype ADRI_type is integer range 0 to (2**Adr_width) - 1;
  subtype DATA_type is std_logic_vector(Dat_width-1 downto 0);
  subtype DATI_type is unsigned(Dat_width-1 downto 0);
  subtype STB_type  is std_logic_vector(Stb_width-1 downto 0);
  subtype step_type is integer range 0 to max_steps;

end SBA_config;
