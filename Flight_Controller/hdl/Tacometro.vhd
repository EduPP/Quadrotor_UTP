library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Tacometro is
port(	flanco_bajada 	:in std_logic;
		clk	:in std_logic;
		rst   :in std_logic;
		T  :out std_logic_vector(31 downto 0)
		);
end Tacometro;

architecture Behavioral of Tacometro is
signal s_flanco_bajada : std_logic;
signal reg : std_logic;
signal flag : std_logic;
signal count : unsigned(31 downto 0); 
begin
 								
P_flanco_bajada:Process (clk,rst) --flanco bajda de PWM
					 begin
					 if rst = '0' then
						reg <= '0';
					 elsif Clk'event and Clk='1' then
						s_flanco_bajada <= flanco_bajada; --registrando señal de bajada
						reg <= s_flanco_bajada;
					 end if;
					end process;
				
flag <= '1' when (s_flanco_bajada = '0' and reg='1') else '0';-- flag activo solo un ciclo de reloj


P_periodo: Process(clk,rst)
				begin
				if rst = '0' then
						count <= (others=>'0');
				elsif clk'event and clk='1' then
					if flag = '1' then
						count <= (others=>'0');
					else 
						count <= count + 1;
					end if;
				end if;
			  end process;
	
T <= std_logic_vector(count); 
	
end Behavioral;			  