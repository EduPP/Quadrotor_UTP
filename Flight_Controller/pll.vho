--IP Functional Simulation Model
--VERSION_BEGIN 11.1SP1 cbx_mgl 2011:11:23:21:11:22:SJ cbx_simgen 2011:11:23:21:09:51:SJ  VERSION_END


-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- You may only use these simulation model output files for simulation
-- purposes and expressly not for synthesis or any other purposes (in which
-- event Altera disclaims all warranties of any kind).


--synopsys translate_off

 LIBRARY cycloneive;
 USE cycloneive.cycloneive_components.all;

--synthesis_resources = cycloneive_pll 1 lut 6 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  pll IS 
	 PORT 
	 ( 
		 address	:	IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
		 areset	:	IN  STD_LOGIC;
		 c0	:	OUT  STD_LOGIC;
		 c1	:	OUT  STD_LOGIC;
		 clk	:	IN  STD_LOGIC;
		 locked	:	OUT  STD_LOGIC;
		 phasedone	:	OUT  STD_LOGIC;
		 read	:	IN  STD_LOGIC;
		 readdata	:	OUT  STD_LOGIC_VECTOR (31 DOWNTO 0);
		 reset	:	IN  STD_LOGIC;
		 write	:	IN  STD_LOGIC;
		 writedata	:	IN  STD_LOGIC_VECTOR (31 DOWNTO 0)
	 ); 
 END pll;

 ARCHITECTURE RTL OF pll IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL  wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_clk	:	STD_LOGIC_VECTOR (4 DOWNTO 0);
	 SIGNAL  wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_fbout	:	STD_LOGIC;
	 SIGNAL  wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_inclk	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 SIGNAL  wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_locked	:	STD_LOGIC;
	 SIGNAL	pll_pll_altpll_8ra2_sd1_pll_lock_sync_120q	:	STD_LOGIC := '0';
	 SIGNAL	pll_pfdena_reg_24q	:	STD_LOGIC := '0';
	 SIGNAL	pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe4a_0_108q	:	STD_LOGIC := '0';
	 SIGNAL	pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe5a_0_111q	:	STD_LOGIC := '0';
	 SIGNAL	pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe6a_0_112q	:	STD_LOGIC := '0';
	 SIGNAL	pll_prev_reset_20q	:	STD_LOGIC := '0';
	 SIGNAL  wire_w_lg_w22w23w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w17w18w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_s_wire_pll_w_select_control_15_dataout21w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_s_wire_pll_w_select_control_15_dataout15w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_s_wire_pll_w_select_status_16_dataout16w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_address_range2w5w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_reset11w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_s_wire_pll_wire_sd1_areset_18_dataout86w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_address_range3w4w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w22w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w17w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_pll_pll_altpll_8ra2_sd1_locked_118_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_pll_w_select_control_15_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_pll_w_select_status_16_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_pll_wire_pfdena_reg_ena_12_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_pll_wire_sd1_areset_18_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_vcc :	STD_LOGIC;
	 SIGNAL  wire_w_address_range2w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_address_range3w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w22w23w(0) <= wire_w22w(0) AND read;
	wire_w_lg_w17w18w(0) <= wire_w17w(0) AND read;
	wire_w_lg_s_wire_pll_w_select_control_15_dataout21w(0) <= s_wire_pll_w_select_control_15_dataout AND pll_pfdena_reg_24q;
	wire_w_lg_s_wire_pll_w_select_control_15_dataout15w(0) <= s_wire_pll_w_select_control_15_dataout AND pll_prev_reset_20q;
	wire_w_lg_s_wire_pll_w_select_status_16_dataout16w(0) <= s_wire_pll_w_select_status_16_dataout AND pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe6a_0_112q;
	wire_w_lg_w_address_range2w5w(0) <= wire_w_address_range2w(0) AND wire_w_lg_w_address_range3w4w(0);
	wire_w_lg_reset11w(0) <= NOT reset;
	wire_w_lg_s_wire_pll_wire_sd1_areset_18_dataout86w(0) <= NOT s_wire_pll_wire_sd1_areset_18_dataout;
	wire_w_lg_w_address_range3w4w(0) <= NOT wire_w_address_range3w(0);
	wire_w22w(0) <= wire_w_lg_s_wire_pll_w_select_control_15_dataout21w(0) OR s_wire_pll_w_select_status_16_dataout;
	wire_w17w(0) <= wire_w_lg_s_wire_pll_w_select_control_15_dataout15w(0) OR wire_w_lg_s_wire_pll_w_select_status_16_dataout16w(0);
	c0 <= wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_clk(0);
	c1 <= wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_clk(1);
	locked <= s_wire_pll_pll_altpll_8ra2_sd1_locked_118_dataout;
	phasedone <= '0';
	readdata <= ( "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & wire_w_lg_w22w23w & wire_w_lg_w17w18w);
	s_wire_pll_pll_altpll_8ra2_sd1_locked_118_dataout <= (pll_pll_altpll_8ra2_sd1_pll_lock_sync_120q AND wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_locked);
	s_wire_pll_w_select_control_15_dataout <= wire_w_lg_w_address_range2w5w(0);
	s_wire_pll_w_select_status_16_dataout <= ((NOT address(0)) AND wire_w_lg_w_address_range3w4w(0));
	s_wire_pll_wire_pfdena_reg_ena_12_dataout <= (s_wire_pll_w_select_control_15_dataout AND write);
	s_wire_pll_wire_sd1_areset_18_dataout <= (pll_prev_reset_20q OR areset);
	s_wire_vcc <= '1';
	wire_w_address_range2w(0) <= address(0);
	wire_w_address_range3w(0) <= address(1);
	wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_inclk <= ( "0" & clk);
	pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130 :  cycloneive_pll
	  GENERIC MAP (
		BANDWIDTH_TYPE => "auto",
		CLK0_DIVIDE_BY => 1,
		CLK0_DUTY_CYCLE => 50,
		CLK0_MULTIPLY_BY => 2,
		CLK0_PHASE_SHIFT => "0",
		CLK1_DIVIDE_BY => 1,
		CLK1_DUTY_CYCLE => 50,
		CLK1_MULTIPLY_BY => 2,
		CLK1_PHASE_SHIFT => "-1667",
		COMPENSATE_CLOCK => "clk0",
		INCLK0_INPUT_FREQUENCY => 20000,
		OPERATION_MODE => "normal",
		PLL_TYPE => "auto"
	  )
	  PORT MAP ( 
		areset => s_wire_pll_wire_sd1_areset_18_dataout,
		clk => wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_clk,
		fbin => wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_fbout,
		fbout => wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_fbout,
		inclk => wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_inclk,
		locked => wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_locked
	  );
	PROCESS (wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_locked, s_wire_pll_wire_sd1_areset_18_dataout)
	BEGIN
		IF (s_wire_pll_wire_sd1_areset_18_dataout = '1') THEN
				pll_pll_altpll_8ra2_sd1_pll_lock_sync_120q <= '0';
		ELSIF (wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_locked = '1' AND wire_pll_pll_altpll_8ra2_sd1_cycloneive_pll_pll7_130_locked'event) THEN
				pll_pll_altpll_8ra2_sd1_pll_lock_sync_120q <= s_wire_vcc;
		END IF;
	END PROCESS;
	PROCESS (clk, reset)
	BEGIN
		IF (reset = '1') THEN
				pll_pfdena_reg_24q <= '1';
		ELSIF (clk = '1' AND clk'event) THEN
			IF (s_wire_pll_wire_pfdena_reg_ena_12_dataout = '1') THEN
				pll_pfdena_reg_24q <= writedata(1);
			END IF;
		END IF;
		if (now = 0 ns) then
			pll_pfdena_reg_24q <= '1' after 1 ps;
		end if;
	END PROCESS;
	PROCESS (clk, reset)
	BEGIN
		IF (reset = '1') THEN
				pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe4a_0_108q <= '0';
				pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe5a_0_111q <= '0';
				pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe6a_0_112q <= '0';
				pll_prev_reset_20q <= '0';
		ELSIF (clk = '1' AND clk'event) THEN
				pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe4a_0_108q <= s_wire_pll_pll_altpll_8ra2_sd1_locked_118_dataout;
				pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe5a_0_111q <= pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe4a_0_108q;
				pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe6a_0_112q <= pll_pll_stdsync_sv6_stdsync2_pll_dffpipe_l2c_dffpipe3_dffe5a_0_111q;
				pll_prev_reset_20q <= (s_wire_pll_wire_pfdena_reg_ena_12_dataout AND writedata(0));
		END IF;
	END PROCESS;

 END RTL; --pll
--synopsys translate_on
--VALID FILE
