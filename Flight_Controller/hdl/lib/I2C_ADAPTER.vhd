-----------------------------------------------------------
-- I2C_Adapter.vhd
-- I2C Adapter for SBA v1.0 (Simple Bus Architecture)
--
-- Version 0.1
-- Date: 20130107
-- 16 bits Data Interface
--
-- Juan Vega
-- email: jvegam25@gmail.com
-- web page: http://mrisco.accesus.com
--
-- Miguel A. Risco Castillo
-- email: mrisco@gmail.com
-- web page: http://mrisco.accesus.com
-- Notes:
--
-- v0.1
-- This version is released under the GNU/GLP license
-- if you use this component for your research please
-- include the appropriate credit of Author.
-- For commercial purposes request the appropriate
-- license from the author. 
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.SBA_package.all;
use work.SBA_config.all;

entity I2C_CORE is
generic (
      CLK_FREC      : integer:= 100e6;
      I2C_ADDRESS   : natural:= 7;
      I2C_CLK       : natural:= 400e3
  ); 
port (

      -- SBA Bus Interface
      CLK_I  : in std_logic;
      RST_I  : in std_logic;
      -- Output Port 0
      WE_I  : in std_logic;
      STB_I : in std_logic;
      ACK_O : out std_logic;         -- Strobe Acknoledge
      ADR_I : in std_logic_vector(1 downto 0);
      DAT_I : in DATA_Type;
      DAT_O : out DATA_Type;
      
      --
      I2C_SCL : inout std_logic;
      I2C_SDA : inout std_logic

      );

end I2C_CORE ;

Architecture core_rtl of I2C_CORE is

signal CLKi : std_logic;
signal RSTi : std_logic;
signal DATo : DATA_Type;
signal I2C_WRi      : std_logic;
signal I2C_ADRi     : std_logic_vector (I2C_ADDRESS-1 downto 0);
signal I2C_DATAo    : std_logic_vector(15 downto 0);
signal I2C_REGi     : std_logic_vector(15 downto 0);
signal I2C_DATAi    : std_logic_vector(7 downto 0);
signal I2C_STARTi   : std_logic;
signal I2C_DATASENTi    : std_logic;
signal I2C_DATARCVi     : std_logic;

begin

U1: entity work.ControllerI2C
    generic map ( CLK_FREC    => sysfrec,
                  I2C_ADDRESS => 7 )
    port map
    (
       -- SBA Bus Interface
      CLK_I  => CLKi,
      RST_I  => RSTi,
      WE_I   => WE_I,
      STB_I  => STB_I,
      ACK_O  => ACK_O,
      ADR_I  => ADR_I(1 downto 0),
      DAT_I  => DAT_I(15 downto 0),
      DAT_O  => DATo,

      -- signals core i2C
      I2C_WR          => I2C_WRi,
      I2C_ADR_O       => I2C_ADRi,
      I2C_REG_O       => I2C_REGi,
      I2C_DATA_O      => I2C_DATAo, 
      I2C_DATA_I      => I2C_DATAi,    
      I2C_START_O     => I2C_STARTi,
      I2C_DATASENT    => I2C_DATASENTi,
      I2C_DATARCV     => I2C_DATARCVi       

);


U2: entity work.CORE_I2C 
generic map(
      CLK_FREC      => sysfrec,  
      I2C_ADDRESS   => I2C_ADDRESS,
      I2C_CLK       => I2C_CLK -- Frequency KHZ
  )    

port map(

    CLK_I  => CLKi,
    RST_I  => RSTi,
 
    -- I2C controller signals
    I2C_WR          => I2C_WRi,   
    I2C_ADR_I       => I2C_ADRi,
    I2C_REG_I       => I2C_REGi,
    I2C_DATA_I      => I2C_DATAo,
    I2C_DATA_O      => I2C_DATAi,  
    I2C_START_I     => I2C_STARTi,
    I2C_DATASENT    => I2C_DATASENTi,
    I2C_DATARCV     => I2C_DATARCVi,
    I2C_ERROR_O     => open,
    -- Signal out I2C
    I2C_SCL         => I2C_SCL,
    I2C_SDA         => I2C_SDA
         
);


CLKi<=CLK_I;
RSTi<=RST_I;
DAT_O<= std_logic_vector( resize(unsigned(DATo),DAT_O'length));


end core_rtl;
