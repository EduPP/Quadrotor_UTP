----------------------------------------------------------------
-- SBA AddrSpace
-- Address Decoder
--
-- v3.2 20120613
--
-- (c) Miguel A. Risco Castillo
-- email: mrisco@accesus.com
-- webpage: http://mrisco.accesus.com
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
-- Notes:
--
-- v3.2
-- Added the stb() function, 
-- change from structural to behavioral design
--
-- v3.1
-- Restored STB_I
--
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sba_config.all;
use work.sba_package.all;

entity  AddrSpace  is
port(
   STB_I: in std_logic;           -- Address Enabler
   ADR_I: in ADDR_type;           -- Address input Bus
   STB_O: out STB_type 	          -- Strobe Chips selector 
);
end AddrSpace;

architecture AddrSpace_Arch of AddrSpace is

Signal STBi : STB_type;

begin

ADDRProc:process (ADR_I)

  Variable ADRi : ADRi_type;

  function stb(val:natural) return STB_type is
  variable ret : unsigned(STB_Type'range);
  begin
    ret:=(0 => '1', others=>'0');
    return STB_type((ret sll (val)));
  end;

begin
  ADRi := to_integer(unsigned(ADR_I));
  case ADRi is
     --When GPIO                    => STBi <= stb(STB_GPIO);  -- General Purpose IO;
     When GPIOAceleX                    => STBi <= stb(STB_AceleX); -- GPIO1
	  When GPIOAceleY                    => STBi <= stb(STB_AceleY);
	  When GPIOAceleZ                    => STBi <= stb(STB_AceleZ);
	  
	  When GPIOTempGy                    => STBi <= stb(STB_TempGy);
	  When GPIOGyrosX                    => STBi <= stb(STB_GyrosX);
	  When GPIOGyrosY                    => STBi <= stb(STB_GyrosY);
	  When GPIOGyrosZ                    => STBi <= stb(STB_GyrosZ);
	  
	  When GPIOMagneX                    => STBi <= stb(STB_MagneX);
	  When GPIOMagneY                    => STBi <= stb(STB_MagneY);
	  When GPIOMagneZ                    => STBi <= stb(STB_MagneZ);
	  
     When I2C to I2C+3            => STBi <= stb(STB_I2C);  -- GPIO1
	  When OTHERS                  => STBi <= (others =>'0');
  end case;

end process;

  STB_O <= STBi When STB_I='1' else (others=>'0');

end AddrSpace_Arch;

