------------------------------------------------------------
--
-- SBA_LED Simple Demo 3
-- 2013-01-23:
--
-- (c) Miguel A. Risco Castillo
-- email: mrisco@accesus.com
-- sba page: http://sba.accesus.com
--
-- This code, modifications, derivate work or
-- based upon, can not be used or distributed
-- without the complete credits on this header.
--
-- This version is released under the GNU/GLP license
-- http://www.gnu.org/licenses/gpl.html
-- if you use this component for your research please
-- include the appropriate credit of Author.
--
-- For commercial purposes request the appropriate
-- license from the author.
--
------------------------------------------------------------


Library IEEE;
use IEEE.std_logic_1164.all;
use work.SBA_config.all;
use work.SBA_package.all;

entity SENSORS is
port (
   CLK_BRD : in std_logic;
   RST_BRD : in std_logic;
   -- LEDS;
   ACELE_X    : out std_logic_vector(15 downto 0);
	ACELE_Y    : out std_logic_vector(15 downto 0);
	ACELE_Z    : out std_logic_vector(15 downto 0);
	
	
	GYROS_X    : out std_logic_vector(15 downto 0);
	GYROS_Y    : out std_logic_vector(15 downto 0);
	GYROS_Z    : out std_logic_vector(15 downto 0);
	
	MAGNE_X    : out std_logic_vector(15 downto 0);
	MAGNE_Y    : out std_logic_vector(15 downto 0);
	MAGNE_Z    : out std_logic_vector(15 downto 0);
	
	TEMPGYR    : out std_logic_vector(15 downto 0);
	
   -- I2C interface
   I2C_SCLK       : inout std_logic;
	I2C_SDAT       : inout std_logic
	--G_SENSOR_CS_N  : out std_logic    -- Selecciona Acelerometro 

);
end SENSORS;

------------------------------------------------------------

architecture Test of SENSORS is

-- SBA internal signals
   Signal RSTi  : Std_Logic;
   Signal CLKi  : Std_Logic;
   Signal ADRi  : ADDR_type;
   Signal DATOi : DATA_type;
   Signal DATIi : DATA_type;
   Signal STBi  : STB_type;
   Signal WEi   : Std_Logic;
   Signal ACKi  : Std_Logic;
   Signal INTi  : Std_Logic;

-- Auxiliary signals
   Signal STBEi : std_logic;                    -- Signal to interconect components ports
   Signal RSTe  : std_logic;                    -- Signal to connect to external ports
   --Signal LEDSe : std_logic_vector(7 downto 0); -- Signal to connect to external ports
	signal DAT_I2C   : DATA_type;
	
	Signal DAT_GPIOAceleX : DATA_type;
	Signal DAT_GPIOAceleY : DATA_type;
	Signal DAT_GPIOAceleZ : DATA_type;
	
	Signal DAT_GPIOTempGy : DATA_type;    -- siñal para temperatura del gyroscopio
	Signal DAT_GPIOGyrosX : DATA_type;
	Signal DAT_GPIOGyrosY : DATA_type;
	Signal DAT_GPIOGyrosZ : DATA_type;
	
	Signal DAT_GPIOMagneX : DATA_type;
	Signal DAT_GPIOMagneY : DATA_type;
	Signal DAT_GPIOMagneZ : DATA_type;
	
------------------------------------------------------------

begin

   Sys : entity work.SysCon
   port Map(
     CLK_I => CLK_BRD,
     CLK_O => CLKi,
     RST_I => RSTe,
     RST_O => RSTi
   );

   MasterController : entity work.SBAController
     port Map(
       RST_I => RSTi,
       CLK_I => CLKi,
       DAT_I => DATIi,
       DAT_O => DATOi,
       ADR_O => ADRi,
       STB_O => STBEi,
       WE_O  => WEi,
       ACK_I => ACKi,
       INT_I => INTi
     );

   Addr_Space : entity work.AddrSpace
      port Map(
        STB_I => STBEi,
        ADR_I => ADRi,
        STB_O => STBi
      );

   ----  Acele
	
   GPIO_AceleX: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOAceleX,
      STB_I => STBi(STB_AceleX),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => ACELE_X
      );

   DataInt_AceleX: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_AceleX),
      DAT_I => DAT_GPIOAceleX,
      DAT_O => DATIi
   );

	GPIO_AceleY: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOAceleY,
      STB_I => STBi(STB_AceleY),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => ACELE_Y
      );

   DataInt_AceleY: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_AceleY),
      DAT_I => DAT_GPIOAceleY,
      DAT_O => DATIi
   );

   GPIO_AceleZ: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOAceleZ,
      STB_I => STBi(STB_AceleZ),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => ACELE_Z
      );

   DataInt_AceleZ: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_AceleZ),
      DAT_I => DAT_GPIOAceleZ,
      DAT_O => DATIi
   );
	
   ---- fin Acele
   
	---- Gyros
	
   GPIO_TempGyro: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOTempGy,
      STB_I => STBi(STB_TempGy),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => TEMPGYR
      );

   DataInt_TempGyro: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_TempGy),
      DAT_I => DAT_GPIOTempGy,
      DAT_O => DATIi
   );	
	
   GPIO_GyrosX: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOGyrosX,
      STB_I => STBi(STB_GyrosX),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => GYROS_X
      );

   DataInt_GyrosX: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_GyrosX),
      DAT_I => DAT_GPIOGyrosX,
      DAT_O => DATIi
   );	
	
   GPIO_GyrosY: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOGyrosY,
      STB_I => STBi(STB_GyrosY),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => GYROS_Y
      );

   DataInt_GyrosY: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_GyrosY),
      DAT_I => DAT_GPIOGyrosY,
      DAT_O => DATIi
   );		

   GPIO_GyrosZ: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOGyrosZ,
      STB_I => STBi(STB_GyrosZ),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => GYROS_Z
      );

   DataInt_GyrosZ: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_GyrosZ),
      DAT_I => DAT_GPIOGyrosZ,
      DAT_O => DATIi
   );	
	
	---- fin Gyros
	
	---- Magne
	
   GPIO_MagneX: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOMagneX,
      STB_I => STBi(STB_MagneX),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => MAGNE_X
      );

   DataInt_MagneX: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_MagneX),
      DAT_I => DAT_GPIOMagneX,
      DAT_O => DATIi
   );	
	
   GPIO_MagneY: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOMagneY,
      STB_I => STBi(STB_MagneY),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => MAGNE_Y
      );

   DataInt_MagneY: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_MagneY),
      DAT_I => DAT_GPIOMagneY,
      DAT_O => DATIi
   );
	
   GPIO_MagneZ: entity work.GPIO_Adapter
   generic map(size=>16)
   port map(
      -- SBA Bus Interface
      RST_I => RSTi,
      CLK_I => CLKi,
      DAT_I => DATOi,
      DAT_O => DAT_GPIOMagneZ,
      STB_I => STBi(STB_MagneZ),
      WE_I  => WEi,
      -- PORTS Interface,
      P_I   => (others => '0'),
      P_O   => MAGNE_Z
      );

   DataInt_MagneZ: entity work.DataIntf
   port Map(
      STB_I => STBi(STB_MagneZ),
      DAT_I => DAT_GPIOMagneZ,
      DAT_O => DATIi
   );	
	
	---- fin Magne

	
     ----  I2C 	
     I2C: entity work.I2C_CORE
     generic map (
              CLK_FREC      => 50e6,
              I2C_ADDRESS   => 7,
              I2C_CLK       => 400e3
          ) 
     port map(
     -- SBA Bus Interface
      CLK_I  => CLKi,
      RST_I  => RSTi,
      -- Output Port 0
      WE_I   => WEi,             
      STB_I  => STBi(STB_I2C),
      ACK_O  => open,         -- Strobe Acknoledge
      ADR_I  => ADRi(1 downto 0), 
      DAT_I  => DATOi, 
      DAT_O  => DAT_I2C,
      
      --
      I2C_SCL => I2C_SCLK,
      I2C_SDA => I2C_SDAT

      );

      I2CDataIntf: entity work.DataIntf
      port Map(
         STB_I => STBi(STB_I2C),
         DAT_I => DAT_I2C,
         DAT_O => DATIi
      );
      ---- fin I2C

-- External Signals Assignments
-------------------------------
RSTe  <= not RST_BRD;         -- Depends of the hardware active low or high reset
--LEDS  <= LEDSe;   -- if LEDS are Common Anode then negate LEDSe
--G_SENSOR_CS_N <= '1';         -- CS acelerometro

-- Internal Signals Assigments
------------------------------
ACKi <= '1';

end Test;
------------------------------------------------------------