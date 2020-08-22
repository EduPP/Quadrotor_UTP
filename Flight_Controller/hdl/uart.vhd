
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity uart is
   generic(
     -- Default setting:
     -- 115200 baud, 8 data bis, 1 stop its, 2^2 FIFO
      DBIT: integer:=8;     -- # data bits
      SB_TICK: integer:=16; -- # ticks for stop bits, 16/24/32
                            --   for 1/1.5/2 stop bits
      DVSR: integer:= 54;  -- baud rate divisor
                            -- DVSR = 100M/(16*baud rate)
      DVSR_BIT: integer:=8; -- # bits of DVSR
      FIFO_W: integer:=6    -- # addr bits of FIFO
                            -- # words in FIFO=2^FIFO_W
   );
   port(
      clk, reset: in std_logic;
      w_data: in std_logic_vector(8 downto 0);
      tx: out std_logic
   );
end uart;

architecture str_arch of uart is
   signal tick: std_logic;
   signal tx_fifo_out: std_logic_vector(7 downto 0);
   signal tx_empty, tx_fifo_not_empty: std_logic;
   signal tx_done_tick: std_logic;
	signal wdata8_reg,wdata8_s : std_logic;
	signal wr_s : std_logic;
begin
   baud_gen_unit: entity work.mod_m_counter(arch)
      generic map(M=>DVSR, N=>DVSR_BIT)
      port map(clk=>clk, reset=>reset,
               q=>open, max_tick=>tick);
   
   fifo_tx_unit: entity work.fifo(arch)
      generic map(B=>DBIT, W=>FIFO_W)
      port map(clk=>clk, reset=>reset, rd=>tx_done_tick,
               wr=>wr_s, w_data=>w_data(7 downto 0), empty=>tx_empty,
               full=>open, r_data=>tx_fifo_out);
					
   uart_tx_unit: entity work.uart_tx(arch)
      generic map(DBIT=>DBIT, SB_TICK=>SB_TICK)
      port map(clk=>clk, reset=>reset,
               tx_start=>tx_fifo_not_empty,
               s_tick=>tick, din=>tx_fifo_out,
               tx_done_tick=> tx_done_tick, tx=>tx);
					
   tx_fifo_not_empty <= not tx_empty;
			  
P_flanco_sub: process(clk,reset)
					begin
					if reset = '0' then				
						wdata8_s <= '0';
						wdata8_reg <= '0';
					elsif Clk'event and Clk='1' then
						wdata8_s <= w_data(8);
						wdata8_reg <= wdata8_s;
					end if;
					end process;

wr_s <= '1' when (wdata8_s = '1' and wdata8_reg='0') else '0';
					
end str_arch;