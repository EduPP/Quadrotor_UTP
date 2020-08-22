-----------------------------------------------------------
-- SBAController.vhd
--
-- Based upon SBA Master Controller Version 1.47 20110331
-- 16 bits Data Interface,
-- SBA Master System Controller
--
-- (c) Miguel A. Risco Castillo
-- email: mrisco@accesus.com
-- sba web page: http://sba.accesus.com
--
-- Notes:
-- v1.47
-- Move step, ret and adr variables to signals to improve
-- performance and area. Restore ACK_I functionality
--
-- v1.46
-- Implement SBAWait for freeze Bus values;
-- Restore STB_O functionality
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
-----------------------------------------------------------
--
-- User Program:
--
-- Version: 0.1
-- Date: 20120116
-- User Program: SBA GPIO Simple Demo
--
-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.SBA_config.all;
use work.SBA_package.all;

entity  SBAController  is
port(
   RST_I : in std_logic;                     -- active high reset
   CLK_I : in std_logic;                     -- main clock
   DAT_I : in DATA_type;                     -- Data input Bus
   DAT_O : out DATA_type;                    -- Data output Bus
   ADR_O : out ADDR_type;                    -- Address output Bus
   STB_O : out std_logic;                    -- Strobe enabler
   WE_O  : out std_logic;                    -- Write / Read
   ACK_I : in  std_logic;                    -- Strobe Acknoledge
   INT_I : in  std_logic                     -- Interrupt request
);
end SBAController;

architecture SBAController_Arch of SBAController is

  signal step : step_type;                   -- Step counter
  signal ret  : step_type;                   -- Return step for subroutines register
  signal adr  : ADRi_type;                   -- Address register
  signal pstep: step_type;                   -- Step counter + 1

begin

  Main : process (CLK_I, RST_I)

-- General variables
  variable jmp  : step_type;                 -- Jump step register
  variable cal  : step_type;                 -- Call subroutine register
  variable dati : DATi_type;                 -- Input Internal Data Bus
  variable stb  : std_logic;                 -- strobe (Address valid)   
  variable we   : std_logic;                 -- Write enable ('0' read enable)
  variable dato : DATi_type;                 -- Output internal Data Bus


------------------------------ SBA procedures --------------------------------

  procedure SBAread(addr:in ADRi_type) is
  begin
    if (debug=1) then
      Report "SBARead: adr=" &  integer'image(addr);
    end if;

    adr <= addr;
    stb := '1';
    we  := '0';
  end;

  procedure SBAread(addr:in unsigned) is
  begin
    if (debug=1) then
      Report "SBARead: adr=" &  integer'image(to_integer(addr));
    end if;

    adr <= to_integer(addr);
    stb := '1';
    we  := '0';
  end;

  procedure SBAwrite(addr:in ADRi_type; data: in unsigned) is
  begin
    if (debug=1) then
      Report "SBAwrite: adr=" &  integer'image(addr) & " dat=" &  integer'image(to_integer(data));
    end if;

    adr <= addr;
    stb := '1';
    we  := '1';
    dato:= resize(data,dato'length);
  end;

  procedure SBAwrite(addr:in unsigned; data: in unsigned) is
  begin
    if (debug=1) then
      Report "SBAwrite: adr=" &  integer'image(to_integer(addr)) & " dat=" &  integer'image(to_integer(data));
    end if;

    adr <= to_integer(addr);
    stb := '1';
    we  := '1';
    dato:= resize(data,dato'length);
  end;
 
  procedure SBARet is
  begin
    jmp:=ret;
  end;
  
  procedure SBACall(stp:in step_type) is
  begin
    cal:=stp;
  end;

  procedure SBAWait is
  begin
    stb:='1'; 
  end;
  
------------------------------ User Registers and Constants -----------------------------

-- General Registers 
 variable Dlytmp  : unsigned(23 downto 0);      -- Delay register
 
-- Application Specific registers

 variable reg1   : unsigned(15 downto 0);       -- GP User register
 variable reg2   : unsigned(15 downto 0);       -- GP User register
 
 variable AceleX  : unsigned(15 downto 0);
 variable AceleY  : unsigned(15 downto 0);
 variable AceleZ  : unsigned(15 downto 0);
 
 variable TempGy  : unsigned(15 downto 0);
 variable GyrosX  : unsigned(15 downto 0);
 variable GyrosY  : unsigned(15 downto 0);
 variable GyrosZ  : unsigned(15 downto 0);
 
 variable MagneX  : unsigned(15 downto 0);
 variable MagneY  : unsigned(15 downto 0);
 variable MagneZ  : unsigned(15 downto 0);

-- Auto generated Jumping constants

 constant Init: step_type := 001;
 constant Delay: step_type := 002;
 constant WaitI2C: step_type := 003;
 constant MainLoop: step_type := 005;
 constant LecturaData: step_type := 030;


--------------------------- End of User Registers and Constants -------------------------

begin

  if rising_edge(CLK_I) then
  
    if (debug=1) then
      Report "Step: " &  integer'image(step);
    end if;
   
    if (RST_I='1') then
      step <= 1;              -- First step is 1 (cal and jmp valid only if >0)
      ret  <= 0;              -- Default ret value  
      adr  <= 0;              -- Default Address Value
      we   :='1';             -- Default we value on reset
      stb  :='0';
      dato :=(others=>'0');
--------------------------------------------------------------------------------------
-- Reset auxiliaries registers
      reg1 :=(others=>'0');
      reg2 :=(others=>'0');
      Dlytmp:=(others=>'0');
--------------------------------------------------------------------------------------

    elsif (ACK_I='1') or (stb='0') then

      dati:= unsigned(DAT_I); -- Get value from data bus
      jmp := 0;               -- Default jmp value  
      cal := 0;               -- Default cal value
      stb :='0';              -- Default stb value  

      case step is

------------------------------ User Programmable Section -----------------------------

                -- /L:Init
        When 001=> jmp:=MainLoop;
                -- /L:Delay
        When 002=> if Dlytmp/=0 then
                   Dec(Dlytmp);
                   jmp:=step;
                    else
                   SBARet;
                   end if;
                -- /L:WaitI2C
        When 003=> SBARead(I2C);
        When 004=> if (dati(15)='1' or dati(14)='1' ) then --si el dispositivo no esta listo
                     SBARead(I2C);
                     jmp:=step;
                   else SBARet;
                   end if;
                -- /L:MainLoop
                -- Proceso de escritura
					 -- Escritura Acele
        When 005=> SBAWrite(I2C_REG3,x"0008");   -- x"0008" --> 00 = position within the RAM
                						                           --> 08 = Data to write
        When 006=> SBAWrite(I2C_REG2,x"0000" );  -- write the number of bytes - 1
        When 007=> SBAWrite(I2C_REG1,x"002D" );  -- Initial register address
        When 008=> SBAWrite(I2C_REG0,x"5301" );  -- x"5301"  --> 1D = Device Address
                						                            --> 01 = Configure write and Start
        When 009=> SBAWait;
        When 010=> SBAcall(WaitI2C);

        When 011=> SBAWrite(I2C_REG3,x"000B");   -- x"000F"  --> 00 = position within the RAM
                						                            --> 0F = Data to write
        When 012=> SBAWrite(I2C_REG2,x"0000" );  -- write the number of bytes - 1
        When 013=> SBAWrite(I2C_REG1,x"0031" );  -- Initial register address
        When 014=> SBAWrite(I2C_REG0,x"5301" );  -- x"5301"  --> 53 = Device Address
                						                            --> 01 = Configure write and Start
        When 015=> SBAWait;
        When 016=> SBAcall(WaitI2C);

                -- Escritura Gyro

        When 017=> SBAWrite(I2C_REG3,x"000F");   -- x"000F" --> 00 = position within the RAM
                						                           --> 0F = Data to write
        When 018=> SBAWrite(I2C_REG3,x"011E");   -- x"011E" --> 01 = position within the RAM
                						                           --> 1E = Data to write
        When 019=> SBAWrite(I2C_REG2,x"0001" );  -- write the number of bytes - 1
        When 020=> SBAWrite(I2C_REG1,x"0015" );  -- Initial register address
        When 021=> SBAWrite(I2C_REG0,x"6801" );  -- x"6801"  --> 68 = Device Address
                						                            --> 01 = Configure write and Start
        When 022=> SBAWait;
        When 023=> SBAcall(WaitI2C);

                -- Escritura Magnetometro
        When 024=> SBAWrite(I2C_REG3,x"0000");   -- x"0000" --> 00 = position within the RAM
                						                           --> 00 = Data to write
        When 025=> SBAWrite(I2C_REG2,x"0000" );  -- write the number of bytes - 1
        When 026=> SBAWrite(I2C_REG1,x"0002" );  -- Initial register address
        When 027=> SBAWrite(I2C_REG0,x"1E01" );  -- x"1E01"  --> 1E = Device Address
                						                            --> 01 = Configure write and Start
        When 028=> SBAWait;
        When 029=> SBAcall(WaitI2C);


                -- reading process data of I2C
                -- /L:LecturaData
                -- lectura del acelerometro
        When 030=> SBAWrite(I2C_REG2,x"0005");   -- n bytes -1
        When 031=> SBAWrite(I2C_REG1,x"0032");   -- direccion del dispositivo
                --
        When 032=> SBAWrite(I2C_REG0,x"5303");   -- x"5301"  --> 53 = Address Device
                						                            --> 0011 = Read & Start
        When 033=> SBAWait;
        When 034=> SBAcall(WaitI2C);
        When 035=> SBAWrite(I2C_REG0,x"0008");   -- x"XX08"  --> XX --> unaffected
                		 --                                     --> 08 --> Enable read memory RAM
        When 036=> SBAwait;                      -- Wait complete write cycle
        When 037=> SBARead(I2C);						 -- Read Data ( 6 bytes )

        When 038=> SBAwait;  AceleX( 7 downto 0):= dati(7 downto 0);	-- first data    X (LSB)
        When 039=> SBAwait;  AceleX(15 downto 8):= dati(7 downto 0);	-- second data   X (MSB)
        When 040=> SBAwait;  AceleY( 7 downto 0):= dati(7 downto 0); -- third data    Y (LSB)
        When 041=> SBAwait;  AceleY(15 downto 8):= dati(7 downto 0);	-- fourth data   Y (MSB)
        When 042=> SBAwait;  AceleZ( 7 downto 0):= dati(7 downto 0);	-- fifth data    Z (LSB)
        When 043=> SBAwait;  AceleZ(15 downto 8):= dati(7 downto 0);	-- sixth data    Z (MSB)
                -- When 039=> SBAWrite(LEDS,reg2);								-- writting the value of X(LSB)

                -- lectura del gyro
        When 044=> SBAWrite(I2C_REG2,x"0007");   -- n bytes -1
        When 045=> SBAWrite(I2C_REG1,x"001B");   -- direccion del dispositivo
                --
        When 046=> SBAWrite(I2C_REG0,x"6803");   -- x"6803"  --> 68 = Address Device
                						                            --> 03 = Read & Start  x"03" = b"00000011"
        When 047=> SBAWait;
        When 048=> SBAcall(WaitI2C);
        When 049=> SBAWrite(I2C_REG0,x"0008");   -- x"XX08"  --> XX --> unaffected
                		 --                                     --> 08 --> Enable read memory RAM
        When 050=> SBAwait;                      -- Wait complete write cycle
        When 051=> SBARead(I2C);						 -- Read Data ( 6 bytes )

                --    When 048=> SBAwait;  -- reg1:= x"00" & dati(7 downto 0);	-- first data    Temp (LSB)
                --    When 049=> SBAwait;  -- reg2:= x"00" & dati(7 downto 0);	-- second data   Temp (MSB)
        When 052=> SBAwait;  TempGy(15 downto 8):= dati(7 downto 0);	-- first data    T (LSB)
        When 053=> SBAwait;  TempGy( 7 downto 0):= dati(7 downto 0);	-- second data   T (MSB)
        When 054=> SBAwait;  GyrosX(15 downto 8):= dati(7 downto 0);	-- first data    X (LSB)
        When 055=> SBAwait;  GyrosX( 7 downto 0):= dati(7 downto 0);	-- second data   X (MSB)
        When 056=> SBAwait;  GyrosY(15 downto 8):= dati(7 downto 0);	-- third data    Y (LSB)
        When 057=> SBAwait;  GyrosY( 7 downto 0):= dati(7 downto 0);	-- fourth data   Y (MSB)
        When 058=> SBAwait;  GyrosZ(15 downto 8):= dati(7 downto 0);	-- fifth data    Z (LSB)
        When 059=> SBAwait;  GyrosZ( 7 downto 0):= dati(7 downto 0);	-- sixth data    Z (MSB)
                -- When 053=> SBAWrite(LEDS,reg2);								-- writting the value of X(LSB)

                -- lectura del magnetometro
        When 060=> SBAWrite(I2C_REG2,x"0005");   -- n bytes -1
        When 061=> SBAWrite(I2C_REG1,x"0003");   -- direccion del dispositivo
                --
        When 062=> SBAWrite(I2C_REG0,x"1E03");   -- x"1D01"  --> 1E = Address Device
                						                            --> b0011 = Read & Start
        When 063=> SBAWait;
        When 064=> SBAcall(WaitI2C);
        When 065=> SBAWrite(I2C_REG0,x"0008");   -- x"XX08"  --> XX --> unaffected
                		 --                                     --> 08 --> Enable read memory RAM
        When 066=> SBAwait;                      -- Wait complete write cycle
        When 067=> SBARead(I2C);						 -- Read Data ( 6 bytes )

        When 068=> SBAwait;  MagneX(15 downto 8):= dati(7 downto 0);	-- first data    X (LSB)
        When 069=> SBAwait;  MagneX( 7 downto 0):= dati(7 downto 0); --reg2:= x"00" & dati(7 downto 0);	-- second data   X (MSB)
        When 070=> SBAwait;  MagneZ(15 downto 8):= dati(7 downto 0);	-- third data    Y (LSB)
        When 071=> SBAwait;  MagneZ( 7 downto 0):= dati(7 downto 0);	-- fourth data   Y (MSB)
        When 072=> SBAwait;  MagneY(15 downto 8):= dati(7 downto 0);	-- fifth data    Z (LSB)
        When 073=> SBAwait;  MagneY( 7 downto 0):= dati(7 downto 0);	-- sixth data    Z (MSB)

        When 074=> SBAWrite(GPIOAceleX,AceleX);								-- writting the value of X(LSB)
        When 075=> SBAWrite(GPIOAceleY,AceleY);
        When 076=> SBAWrite(GPIOAceleZ,AceleZ);

        When 077=> SBAWrite(GPIOTempGy,TempGy);
        When 078=> SBAWrite(GPIOGyrosX,GyrosX);
        When 079=> SBAWrite(GPIOGyrosY,GyrosY);
        When 080=> SBAWrite(GPIOGyrosZ,GyrosZ);

        When 081=> SBAWrite(GPIOMagneX,MagneX);
        When 082=> SBAWrite(GPIOMagneY,MagneY);
        When 083=> SBAWrite(GPIOMagneZ,MagneZ);


        When 084=> jmp:=LecturaData;

------------------------------ End of User Programmable Section -----------------------------

        When others=> jmp:=1; 
      end case;

      if jmp>0 then step<=jmp; else step<=pstep; end if;
      if cal>0 then ret<=pstep; step<=cal; end if;

    end if;

    STB_O <= stb;
    WE_O  <= we;
    DAT_O <= std_logic_vector(dato);

  end if;
end process;

pstep <= step + 1;
ADR_O <= std_logic_vector(to_unsigned(adr,ADR_O'length));


end SBAController_Arch;