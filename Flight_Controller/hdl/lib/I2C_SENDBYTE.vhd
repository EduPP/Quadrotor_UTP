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
-- basen upon SBA architecture 
-- Author: Miguel A. Risco Castillo
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.SBA_package.all;

entity CORE_I2C is

generic (
      CLK_FREC      : integer:=100e6;
      I2C_ADDRESS   : natural:=7;
      I2C_CLK       : natural:=400e3 -- Frequency KHZ
  );    

port (
    CLK_I   : in std_logic;
    RST_I   : in std_logic;
 
    -- I2C 
    I2C_WR          :   in std_logic;  -- 0 write ;  1 read
    I2C_ADR_I       :   in std_logic_vector(I2C_ADDRESS-1 downto 0);
    I2C_REG_I       :   in std_logic_vector(15 downto 0);
    I2C_DATA_I      :   in std_logic_vector(15 downto 0);
    I2C_DATA_O      :   out std_logic_vector(7 downto 0);   
    I2C_START_I     :   in std_logic;
    I2C_DATASENT     :   out std_logic;
    I2C_DATARCV      :   out std_logic;    
    I2C_ERROR_O         :   out std_logic;
    -- Signal out I2C
    I2C_SCL : inout std_logic;
    I2C_SDA : inout std_logic
         

);
end CORE_I2C;

architecture arch_CORE_I2C of CORE_I2C is
   -- signal, component etc. declarations
--ClockDiv
constant M: integer:= integer(real(CLK_FREC)/real(4*I2C_CLK)+0.499)-1;
signal Q : std_logic;
signal Y : integer range 0 to M+1;
signal YP: integer range 0 to M+1;

type cstate is (IdleSt,StartSt,StopSt,RStartSt,WriteSt,ReadSt);
signal state_I2C : cstate;
signal SCLi : std_logic;
signal SDAi : std_logic;
signal txi  : std_logic;
signal Data_o: std_logic;
signal Data_i: std_logic;

type tstate is (IniSt,WriteB,WWaitSt,WEndSt,ReadB,RAckSt,RWaitSt,REndSt); -- SPI Communication States
signal state : tstate;
-- repstart	SCL	 ____/~~~~\___
--	SDA	         __/~~~\______
constant CMD_NOP	: std_logic_vector(3 downto 0) := "0000";
constant CMD_START	   : std_logic_vector(3 downto 0) := "1100";
constant CMD_START_SCL : std_logic_vector(3 downto 0) := "1110";  
constant CMD_RSTART	: std_logic_vector(3 downto 0) := "1100";
constant CMD_STOP	: std_logic_vector(3 downto 0) := "0011";
constant CMD_STOP_SCL :std_logic_vector(3 downto 0):= "0111";
constant CMD_SCL	: std_logic_vector(3 downto 0) := "0110";


signal nSCK:integer range 0 to 3;

signal cmd_ok : std_logic;
signal Tramainit    :   std_logic_vector (35 downto 0);  
signal NB,NBstep:integer range 0 to 64;
signal load:unsigned (3 downto 0);
signal Data_rcv: std_logic_vector(7 downto 0);
signal RxData_ok,TxData_ok: std_logic;

constant nTypeAddr : std_logic_vector(1 downto 0):="00";
signal shift_data: std_logic;

Signal DATI_i : std_logic_vector(15 downto 0);

begin

-- Generation I2C
  SHIFT_I2C:process(CLK_I,RST_I)
 
	begin
		if (RST_I = '1') then

          TramaInit<=(others => '1');

        elsif (CLK_I'event and CLK_I = '1') then
         
--         if ( I2C_START_I ='1') then
--              DATI_i<=I2C_DATA_I;
--         end if;
		  
          if ( I2C_START_I ='1' and txi='0' ) then  -- 
           
           if (I2C_WR='0') then

                if (nTypeAddr="00") then 
                  TramaInit<= trailing(I2C_ADR_I & I2C_WR & I2C_REG_I(7 downto 0),Tramainit'length,'1');
                elsif (nTypeAddr="01") then
                  TramaInit<= trailing(I2C_ADR_I & I2C_WR & I2C_REG_I,Tramainit'length,'0');
                end if;
           
           else  
                if (nTypeAddr="00") then  --sale un error por el trailing
                  TramaInit<= trailing(I2C_ADR_I & '0' &  I2C_REG_I(7 downto 0) & I2C_ADR_I & '1',Tramainit'length,'1');
                elsif (nTypeAddr="01") then
                  TramaInit<= trailing(I2C_ADR_I & '0' &  I2C_REG_I & I2C_ADR_I & '1' ,Tramainit'length,'0');
                end if;


           end if;
                        
          end if;
              
           if (load ="0001") then 
              TramaInit<= trailing(I2C_DATA_I(7 downto 0),Tramainit'length,'1');
           end if;
           if (cmd_ok='1' and shift_data='1') then
	          TramaInit<= TramaInit(Tramainit'length-2 downto 0 ) & '1';  		
		   end if;

           --Data_o<=TramaInit(35);
         

		end if;
	end process SHIFT_I2C;

Data_o<= '0' when (load="0010") else
         '1' when (load="0100") else TramaInit(Tramainit'length-1);


Shift_ReadData: process(RST_I,CLK_I)
	begin
		if (RST_I = '1') then

         Data_rcv<=(others => '0');


        elsif (CLK_I'event and CLK_I = '1') then
			if (cmd_ok = '1') then
              Data_rcv <= (Data_rcv(6 downto 0) & Data_i);
             end if;
            if (RxData_ok='1') then
             I2C_DATA_O<=Data_rcv ;
            end if;
        end if;
	end process Shift_ReadData;


 I2C_flow: 
 process (CLK_I,RST_I)

  variable jmp:integer range 0 to 64;
 begin  
 
 
    
    if RST_I = '1' then
    
     State<=IniSt;
     state_I2C<=IdleSt;
     NB<=0;
     load<="0000";
     txi<='0';
     RxData_ok<='0';
     shift_data<='0';
    -- nTypeAddr<="01";

    elsif (rising_edge(CLK_I)) then
    
     if (cmd_ok='1') then state_I2C<=IdleSt;
     end if;
     
     jmp:=0;
     load<="0000";
     RxData_ok<='0';
     TxData_ok<='0';
     shift_data<='0';

     case State is
        when IniSt  =>  if (I2C_START_I='1') then 
                          if (I2C_WR='0') then 
                            State<=WriteB; 
                          else 
                            State<=ReadB; 
                           end if;
                        else state <= IniSt;
                        end if;
                        txi<='0';
 
        when WriteB  => txi<='1';                      
                        case (NB) is
                         when 0        => state_I2C<=StartSt;
                         when 1 to 8   => state_I2C<=WriteSt;shift_data <= '1';
                         when 9        => state_I2C<=ReadSt; 
                         when 10       => if (nTypeAddr = "00") then jmp:=20;
                                          elsif (nTypeAddr = "01") then jmp:=11;
                                         -- elsif (nTypeAddr="11") then jmp:=29;
                                          end if;
                         when 11 to 18 => state_I2C<=WriteSt;shift_data <= '1';
                         when 19       => state_I2C<=ReadSt;  --ack
                         when 20 to 27 => state_I2C<=WriteSt;shift_data <= '1';
                         when 28       => state_I2C<=ReadSt; 
                         when 29       => load <="0001"; jmp:=30;--ack
                         when 30 to 37 => state_I2C<=WriteSt;shift_data <= '1';
                         when 38       => TxData_ok<='1';jmp:=39;
                         when 39       => TxData_ok<='0';jmp:=40;
                         when 40       => if ( I2C_START_I ='1' ) then 
                                           load <="0001";
                                           jmp:=28;
                                          else jmp:=41; 
                                          end if;
                         when 41       => state_I2C<=ReadSt;
                         when 42       => state_I2C<=StopSt; 
                         when 43       => State<=IniSt;state_I2C<=IdleSt;                                                            
                         when others   => state_I2C<=IdleSt;
                        end case; 
                        
                         
--       
--        when ReadB  =>  txi<='1';
--                        case (NB) is
--                         when 0        => state_I2C<=StartSt;
--                         when 1 to 8   => state_I2C<=WriteSt;shift_data <= '1';
--                         when 9        => state_I2C<=ReadSt; 
--                         when 10       => if (nTypeAddr = "00") then jmp:=20;
--                                          elsif (nTypeAddr = "01") then jmp:=11;
--                                          end if;
--                         when 11 to 18 => state_I2C<=WriteSt;shift_data <= '1';
--                         when 19       => state_I2C<=ReadSt;  --ack
--                         when 20 to 27 => state_I2C<=WriteSt;shift_data <= '1';
--                         when 28       => state_I2C<=ReadSt; --ack
--                         --when 29       => TxData_ok<='1';jmp:=38;
--                         when 29       => state_I2C<=RStartSt;
--                         when 30 to 37 => state_I2C<=WriteSt;shift_data <= '1';
--                         when 38       => state_I2C<=ReadSt;--ack
--                         when 39 to 46 => state_I2C<=ReadSt;--read data
--                         when 47       => RxData_ok<='1';jmp:=48; 
--                         when 48       => RxData_ok<='0';jmp:=49;--Data disponible
--                         when 49       => RxData_ok<='0';--Data disponible
--                                          if ( I2C_START_I ='1' ) then jmp:=50;
--                                          else jmp:=52;
--                                          end if;                                          
--                         when 50       => load<="0010"; state_I2C<=WriteSt; --write ACK master Data_o<='0';
--                         when 51       => jmp:=39;
--                         when 52       => load<="0100";state_I2C<=WriteSt;  --Data_o<='1';
--                         when 53       => state_I2C<=StopSt;
--                         when 54       => State_I2C<=IdleSt;State<=IniSt;                                                                    
--                         when others   => state_I2C<=IdleSt;State<=IniSt;
--                        end case;  

        when ReadB  =>  txi<='1';
                        case (NB) is
                         when 0        => state_I2C<=StartSt;
                         when 1 to 8   => state_I2C<=WriteSt;shift_data <= '1';
                         when 9        => state_I2C<=ReadSt; 
                         when 10       => if (nTypeAddr = "00") then jmp:=20;
                                          elsif (nTypeAddr = "01") then jmp:=11;
                                          end if;
                         when 11 to 18 => state_I2C<=WriteSt;shift_data <= '1';
                         when 19       => state_I2C<=ReadSt;  --ack
                         when 20 to 27 => state_I2C<=WriteSt;shift_data <= '1';
                         when 28       => state_I2C<=ReadSt; --ack
                         when 29       => state_I2C<=StopSt;
                         when 30       => state_I2C<=StartSt;
                         when 31 to 38 => state_I2C<=WriteSt;shift_data <= '1';
                         when 39       => state_I2C<=ReadSt;--ack
                         when 40 to 47 => state_I2C<=ReadSt;--read data
                         when 48       => RxData_ok<='1';jmp:=49; 
                         when 49       => RxData_ok<='0';jmp:=50;--Data disponible
                         when 50       => RxData_ok<='0';--Data disponible
                                          if ( I2C_START_I ='1' ) then jmp:=51;
                                          else jmp:=53;
                                          end if;                                          
                         when 51       => load<="0010"; state_I2C<=WriteSt; --write ACK master Data_o<='0';
                         when 52       => jmp:=40;
                         when 53       => load<="0100";state_I2C<=WriteSt;  --Data_o<='1';
                         when 54       => state_I2C<=StopSt;
                         when 55       => State_I2C<=IdleSt;State<=IniSt;                                                                    
                         when others   => state_I2C<=IdleSt;State<=IniSt;
                        end case;  
        
        when others =>
      end case;

     if jmp>0 then NB<=jmp; else NB<=NBstep; end if;
     
    end if;

 end process;


NBstep <= NB + 1 when ( cmd_ok = '1') else
            0    when ( State=IniSt ) else NB;

 I2C_DATASENT<= TxData_ok;
 I2C_DATARCV <= RxData_ok;

--type cstate is (IdleSt,StartSt,StopSt,RStartSt,WriteSt,ReadSt);
 I2C_sendbit: 
 process (state_I2C,CLK_I,RST_I)
 begin  
    if RST_I = '1' then
    
     SDAi<='1';
     SCLi<='1';
     cmd_ok<='0';
     nSCK<=3;
     Data_i<='0';

    elsif (CLK_I'event and CLK_I = '1') then
 
    if ( Q = '1') then
      
     if (state_I2C /= IdleSt) then
        if (nSCK = 0) then
           nSCK<=3;cmd_ok<='1';
        else nSCK<= nSCK-1;
        end if;
     end if;                     
    
     case state_I2C is
        when IdleSt   => SCLi <= SCLi;
                         SDAi <= SDAi;
                         nSCK <= 3;
 
        when StartSt  => SDAi<= CMD_START(nSCK);
                         SCLi<= CMD_START_SCL(nSCK);
                         

        when StopSt  =>  SDAi<= CMD_STOP(nSCK);
                         SCLi<= CMD_STOP_SCL(nSCK);
                         

        when RStartSt => SDAi<= CMD_RSTART(nSCK);
                         SCLi<= CMD_SCL(nSCK);
                         

        when WriteSt  => SDAi<= Data_o;
                         SCLi<= CMD_SCL(nSCK);
                        

        when ReadSt  =>  if(nSCK=1) then
                          Data_i<=I2C_SDA;
                         end if;
                         SDAi<='1';
                         SCLi<= CMD_SCL(nSCK);

      end case;
     else cmd_ok<='0';
     end if; 
    end if;



 end process;

clock_div:
process (CLK_I,RST_I)
 begin
   if rising_edge(CLK_I) then
     if RST_I = '1' then
       --if (debug=1) then
         report "CLKDiv Div: " & integer'image(M) & " frec: " & real'image(real(CLK_FREC)/real((M+1)));
       --end if;
       Y <= 0;
       Q <='0';
     elsif Y=M then
       Y <= 0;
       Q <='1';
     else 
       Y <= YP;
       Q <= '0';
     end if;
   end if;
 end process;

 YP<=Y+1; 


 
I2C_SDA <= '0' when (SDAi='0') else 'Z';
I2C_SCL <= '0' when (SCLi='0') else 'Z';

end arch_CORE_I2C;