--PWM GENERATOR
--Freq. 400Hz -> 405Hz
--Resol. 14 bits (16384)
--By Eduardo Pillco Porlles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PWM is

	port 
	(
		clk		: in std_logic;
		pwm_out	: out std_logic;
		dutty_cycle	: in std_logic_vector(13 downto 0)
	);

end entity;

architecture behavioral of PWM is
	signal pwm	: std_logic;
	signal step : std_logic_vector(13 downto 0);
	signal count : integer range 0 to 14;
	begin
		process (clk, dutty_cycle, step, count)
		begin
			if (rising_edge(clk)) then
				count <= count+1;
				if (count = 14) then
					step <= step+1;
					count <= 0;
					if (step > dutty_cycle) then
						pwm <= '0';
					else
						pwm <= '1';
					end if;
				end if;
			end if;
		end process;
		pwm_out <= pwm;
end behavioral;