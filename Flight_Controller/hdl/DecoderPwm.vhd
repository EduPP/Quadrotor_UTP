library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity DecoderPwm is
generic(width : integer:= 12);
port(	pwm 	:in std_logic;
		clk	:in std_logic;
		rst   :in std_logic;
		duty  :out std_logic_vector(width-1 downto 0)
		);
end DecoderPwm;

architecture Behavioral of DecoderPwm is
constant fincuenta : integer := 50; ---> muestreo a 0.5 us
signal s_pwm : std_logic;
signal reg : std_logic;
signal u_duty : unsigned(width-1 downto 0);
signal flag : std_logic;
signal count : integer range 0 to 2**6-1; -- para 25 cuentas (0-49)
signal tick : std_logic; -- señal a '1' cada 50 cuentas

begin

P_divisor: Process(clk,rst)
				begin
				 if rst = '0' then
					tick <= '0';
					count <= 0;
				 elsif clk'event and clk = '1' then
				   if count = fincuenta-1 then
						count <= 0;
						tick <= '1';
					else
						tick <= '0';
						count <= count + 1;
					end if;
				 end if;
				end process;
 								
P_flanco_bajada:Process (clk,rst) --flanco bajda de PWM
					 begin
					 if rst = '0' then
						reg <= '0';
					 elsif Clk'event and Clk='1' then
						s_pwm <= pwm; 	      --registrando señal de pwm
						reg <= s_pwm;
					 end if;
					end process;
				
flag <= '1' when (s_pwm = '0' and reg='1') else '0';-- s_flag activo un ciclo de reloj


P_decoder: Process(clk,s_pwm,tick)
				begin
				if clk'event and clk='1' then
					if s_pwm = '1' then
						if tick = '1' then
							u_duty <= u_duty+1;
						end if;
					else 
						u_duty <= (others=>'0');
					end if;
				end if;
			  end process;

			 Process(clk)
				begin
				 if clk'event and clk = '1' then
					if flag = '1' then
						duty <= std_logic_vector(u_duty);
					end if;
				end if;
				end process;
			  
end Behavioral;			  