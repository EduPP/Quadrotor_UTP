--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


--Legal Notice: (C)2016 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NiosII_clock_0_in_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_0_in_endofpacket : IN STD_LOGIC;
                 signal NiosII_clock_0_in_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_0_in_waitrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC;
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal NiosII_clock_0_in_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal NiosII_clock_0_in_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal NiosII_clock_0_in_endofpacket_from_sa : OUT STD_LOGIC;
                 signal NiosII_clock_0_in_nativeaddress : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                 signal NiosII_clock_0_in_read : OUT STD_LOGIC;
                 signal NiosII_clock_0_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_0_in_reset_n : OUT STD_LOGIC;
                 signal NiosII_clock_0_in_waitrequest_from_sa : OUT STD_LOGIC;
                 signal NiosII_clock_0_in_write : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_NiosII_clock_0_in : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_NiosII_clock_0_in : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_NiosII_clock_0_in : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_NiosII_clock_0_in : OUT STD_LOGIC;
                 signal d1_NiosII_clock_0_in_end_xfer : OUT STD_LOGIC
              );
end entity NiosII_clock_0_in_arbitrator;


architecture europa of NiosII_clock_0_in_arbitrator is
                signal NiosII_clock_0_in_allgrants :  STD_LOGIC;
                signal NiosII_clock_0_in_allow_new_arb_cycle :  STD_LOGIC;
                signal NiosII_clock_0_in_any_bursting_master_saved_grant :  STD_LOGIC;
                signal NiosII_clock_0_in_any_continuerequest :  STD_LOGIC;
                signal NiosII_clock_0_in_arb_counter_enable :  STD_LOGIC;
                signal NiosII_clock_0_in_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_0_in_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_0_in_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_0_in_beginbursttransfer_internal :  STD_LOGIC;
                signal NiosII_clock_0_in_begins_xfer :  STD_LOGIC;
                signal NiosII_clock_0_in_end_xfer :  STD_LOGIC;
                signal NiosII_clock_0_in_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_0_in_grant_vector :  STD_LOGIC;
                signal NiosII_clock_0_in_in_a_read_cycle :  STD_LOGIC;
                signal NiosII_clock_0_in_in_a_write_cycle :  STD_LOGIC;
                signal NiosII_clock_0_in_master_qreq_vector :  STD_LOGIC;
                signal NiosII_clock_0_in_non_bursting_master_requests :  STD_LOGIC;
                signal NiosII_clock_0_in_reg_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_0_in_slavearbiterlockenable :  STD_LOGIC;
                signal NiosII_clock_0_in_slavearbiterlockenable2 :  STD_LOGIC;
                signal NiosII_clock_0_in_unreg_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_0_in_waits_for_read :  STD_LOGIC;
                signal NiosII_clock_0_in_waits_for_write :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_NiosII_clock_0_in :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_NiosII_clock_0_in :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_NiosII_clock_0_in_waitrequest_from_sa :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_NiosII_clock_0_in :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_NiosII_clock_0_in :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_NiosII_clock_0_in :  STD_LOGIC;
                signal wait_for_NiosII_clock_0_in_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT NiosII_clock_0_in_end_xfer;
    end if;

  end process;

  NiosII_clock_0_in_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_instruction_master_qualified_request_NiosII_clock_0_in);
  --assign NiosII_clock_0_in_readdata_from_sa = NiosII_clock_0_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  NiosII_clock_0_in_readdata_from_sa <= NiosII_clock_0_in_readdata;
  internal_cpu_instruction_master_requests_NiosII_clock_0_in <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(26 DOWNTO 25) & std_logic_vector'("0000000000000000000000000")) = std_logic_vector'("010000000000000000000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --assign NiosII_clock_0_in_waitrequest_from_sa = NiosII_clock_0_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_NiosII_clock_0_in_waitrequest_from_sa <= NiosII_clock_0_in_waitrequest;
  --NiosII_clock_0_in_arb_share_counter set values, which is an e_mux
  NiosII_clock_0_in_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_NiosII_clock_0_in)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --NiosII_clock_0_in_non_bursting_master_requests mux, which is an e_mux
  NiosII_clock_0_in_non_bursting_master_requests <= internal_cpu_instruction_master_requests_NiosII_clock_0_in;
  --NiosII_clock_0_in_any_bursting_master_saved_grant mux, which is an e_mux
  NiosII_clock_0_in_any_bursting_master_saved_grant <= std_logic'('0');
  --NiosII_clock_0_in_arb_share_counter_next_value assignment, which is an e_assign
  NiosII_clock_0_in_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(NiosII_clock_0_in_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (NiosII_clock_0_in_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(NiosII_clock_0_in_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (NiosII_clock_0_in_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --NiosII_clock_0_in_allgrants all slave grants, which is an e_mux
  NiosII_clock_0_in_allgrants <= NiosII_clock_0_in_grant_vector;
  --NiosII_clock_0_in_end_xfer assignment, which is an e_assign
  NiosII_clock_0_in_end_xfer <= NOT ((NiosII_clock_0_in_waits_for_read OR NiosII_clock_0_in_waits_for_write));
  --end_xfer_arb_share_counter_term_NiosII_clock_0_in arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_NiosII_clock_0_in <= NiosII_clock_0_in_end_xfer AND (((NOT NiosII_clock_0_in_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --NiosII_clock_0_in_arb_share_counter arbitration counter enable, which is an e_assign
  NiosII_clock_0_in_arb_counter_enable <= ((end_xfer_arb_share_counter_term_NiosII_clock_0_in AND NiosII_clock_0_in_allgrants)) OR ((end_xfer_arb_share_counter_term_NiosII_clock_0_in AND NOT NiosII_clock_0_in_non_bursting_master_requests));
  --NiosII_clock_0_in_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_0_in_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(NiosII_clock_0_in_arb_counter_enable) = '1' then 
        NiosII_clock_0_in_arb_share_counter <= NiosII_clock_0_in_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --NiosII_clock_0_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_0_in_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((NiosII_clock_0_in_master_qreq_vector AND end_xfer_arb_share_counter_term_NiosII_clock_0_in)) OR ((end_xfer_arb_share_counter_term_NiosII_clock_0_in AND NOT NiosII_clock_0_in_non_bursting_master_requests)))) = '1' then 
        NiosII_clock_0_in_slavearbiterlockenable <= or_reduce(NiosII_clock_0_in_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/instruction_master NiosII_clock_0/in arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= NiosII_clock_0_in_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --NiosII_clock_0_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  NiosII_clock_0_in_slavearbiterlockenable2 <= or_reduce(NiosII_clock_0_in_arb_share_counter_next_value);
  --cpu/instruction_master NiosII_clock_0/in arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= NiosII_clock_0_in_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --NiosII_clock_0_in_any_continuerequest at least one master continues requesting, which is an e_assign
  NiosII_clock_0_in_any_continuerequest <= std_logic'('1');
  --cpu_instruction_master_continuerequest continued request, which is an e_assign
  cpu_instruction_master_continuerequest <= std_logic'('1');
  internal_cpu_instruction_master_qualified_request_NiosII_clock_0_in <= internal_cpu_instruction_master_requests_NiosII_clock_0_in AND NOT ((cpu_instruction_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_instruction_master_read_data_valid_NiosII_clock_0_in, which is an e_mux
  cpu_instruction_master_read_data_valid_NiosII_clock_0_in <= (internal_cpu_instruction_master_granted_NiosII_clock_0_in AND cpu_instruction_master_read) AND NOT NiosII_clock_0_in_waits_for_read;
  --assign NiosII_clock_0_in_endofpacket_from_sa = NiosII_clock_0_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  NiosII_clock_0_in_endofpacket_from_sa <= NiosII_clock_0_in_endofpacket;
  --master is always granted when requested
  internal_cpu_instruction_master_granted_NiosII_clock_0_in <= internal_cpu_instruction_master_qualified_request_NiosII_clock_0_in;
  --cpu/instruction_master saved-grant NiosII_clock_0/in, which is an e_assign
  cpu_instruction_master_saved_grant_NiosII_clock_0_in <= internal_cpu_instruction_master_requests_NiosII_clock_0_in;
  --allow new arb cycle for NiosII_clock_0/in, which is an e_assign
  NiosII_clock_0_in_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  NiosII_clock_0_in_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  NiosII_clock_0_in_master_qreq_vector <= std_logic'('1');
  --NiosII_clock_0_in_reset_n assignment, which is an e_assign
  NiosII_clock_0_in_reset_n <= reset_n;
  --NiosII_clock_0_in_firsttransfer first transaction, which is an e_assign
  NiosII_clock_0_in_firsttransfer <= A_WE_StdLogic((std_logic'(NiosII_clock_0_in_begins_xfer) = '1'), NiosII_clock_0_in_unreg_firsttransfer, NiosII_clock_0_in_reg_firsttransfer);
  --NiosII_clock_0_in_unreg_firsttransfer first transaction, which is an e_assign
  NiosII_clock_0_in_unreg_firsttransfer <= NOT ((NiosII_clock_0_in_slavearbiterlockenable AND NiosII_clock_0_in_any_continuerequest));
  --NiosII_clock_0_in_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_0_in_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(NiosII_clock_0_in_begins_xfer) = '1' then 
        NiosII_clock_0_in_reg_firsttransfer <= NiosII_clock_0_in_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --NiosII_clock_0_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  NiosII_clock_0_in_beginbursttransfer_internal <= NiosII_clock_0_in_begins_xfer;
  --NiosII_clock_0_in_read assignment, which is an e_mux
  NiosII_clock_0_in_read <= internal_cpu_instruction_master_granted_NiosII_clock_0_in AND cpu_instruction_master_read;
  --NiosII_clock_0_in_write assignment, which is an e_mux
  NiosII_clock_0_in_write <= std_logic'('0');
  --NiosII_clock_0_in_address mux, which is an e_mux
  NiosII_clock_0_in_address <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_instruction_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --slaveid NiosII_clock_0_in_nativeaddress nativeaddress mux, which is an e_mux
  NiosII_clock_0_in_nativeaddress <= A_EXT (A_SRL(cpu_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")), 24);
  --d1_NiosII_clock_0_in_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_NiosII_clock_0_in_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_NiosII_clock_0_in_end_xfer <= NiosII_clock_0_in_end_xfer;
    end if;

  end process;

  --NiosII_clock_0_in_waits_for_read in a cycle, which is an e_mux
  NiosII_clock_0_in_waits_for_read <= NiosII_clock_0_in_in_a_read_cycle AND internal_NiosII_clock_0_in_waitrequest_from_sa;
  --NiosII_clock_0_in_in_a_read_cycle assignment, which is an e_assign
  NiosII_clock_0_in_in_a_read_cycle <= internal_cpu_instruction_master_granted_NiosII_clock_0_in AND cpu_instruction_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= NiosII_clock_0_in_in_a_read_cycle;
  --NiosII_clock_0_in_waits_for_write in a cycle, which is an e_mux
  NiosII_clock_0_in_waits_for_write <= NiosII_clock_0_in_in_a_write_cycle AND internal_NiosII_clock_0_in_waitrequest_from_sa;
  --NiosII_clock_0_in_in_a_write_cycle assignment, which is an e_assign
  NiosII_clock_0_in_in_a_write_cycle <= std_logic'('0');
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= NiosII_clock_0_in_in_a_write_cycle;
  wait_for_NiosII_clock_0_in_counter <= std_logic'('0');
  --NiosII_clock_0_in_byteenable byte enable port mux, which is an e_mux
  NiosII_clock_0_in_byteenable <= A_EXT (-SIGNED(std_logic_vector'("00000000000000000000000000000001")), 2);
  --vhdl renameroo for output signals
  NiosII_clock_0_in_waitrequest_from_sa <= internal_NiosII_clock_0_in_waitrequest_from_sa;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_NiosII_clock_0_in <= internal_cpu_instruction_master_granted_NiosII_clock_0_in;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_NiosII_clock_0_in <= internal_cpu_instruction_master_qualified_request_NiosII_clock_0_in;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_NiosII_clock_0_in <= internal_cpu_instruction_master_requests_NiosII_clock_0_in;
--synthesis translate_off
    --NiosII_clock_0/in enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity NiosII_clock_0_out_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_0_out_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal NiosII_clock_0_out_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal NiosII_clock_0_out_granted_sdram_s1 : IN STD_LOGIC;
                 signal NiosII_clock_0_out_qualified_request_sdram_s1 : IN STD_LOGIC;
                 signal NiosII_clock_0_out_read : IN STD_LOGIC;
                 signal NiosII_clock_0_out_read_data_valid_sdram_s1 : IN STD_LOGIC;
                 signal NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal NiosII_clock_0_out_requests_sdram_s1 : IN STD_LOGIC;
                 signal NiosII_clock_0_out_write : IN STD_LOGIC;
                 signal NiosII_clock_0_out_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal NiosII_clock_0_out_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal NiosII_clock_0_out_readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_0_out_reset_n : OUT STD_LOGIC;
                 signal NiosII_clock_0_out_waitrequest : OUT STD_LOGIC
              );
end entity NiosII_clock_0_out_arbitrator;


architecture europa of NiosII_clock_0_out_arbitrator is
                signal NiosII_clock_0_out_address_last_time :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal NiosII_clock_0_out_byteenable_last_time :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_0_out_read_last_time :  STD_LOGIC;
                signal NiosII_clock_0_out_run :  STD_LOGIC;
                signal NiosII_clock_0_out_write_last_time :  STD_LOGIC;
                signal NiosII_clock_0_out_writedata_last_time :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal internal_NiosII_clock_0_out_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal internal_NiosII_clock_0_out_waitrequest :  STD_LOGIC;
                signal r_5 :  STD_LOGIC;

begin

  --r_5 master_run cascaded wait assignment, which is an e_assign
  r_5 <= Vector_To_Std_Logic(((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NiosII_clock_0_out_qualified_request_sdram_s1 OR NiosII_clock_0_out_read_data_valid_sdram_s1) OR NOT NiosII_clock_0_out_requests_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_0_out_granted_sdram_s1 OR NOT NiosII_clock_0_out_qualified_request_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT NiosII_clock_0_out_qualified_request_sdram_s1 OR NOT NiosII_clock_0_out_read) OR ((NiosII_clock_0_out_read_data_valid_sdram_s1 AND NiosII_clock_0_out_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT NiosII_clock_0_out_qualified_request_sdram_s1 OR NOT ((NiosII_clock_0_out_read OR NiosII_clock_0_out_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_0_out_read OR NiosII_clock_0_out_write)))))))))));
  --cascaded wait assignment, which is an e_assign
  NiosII_clock_0_out_run <= r_5;
  --optimize select-logic by passing only those address bits which matter.
  internal_NiosII_clock_0_out_address_to_slave <= NiosII_clock_0_out_address;
  --NiosII_clock_0/out readdata mux, which is an e_mux
  NiosII_clock_0_out_readdata <= sdram_s1_readdata_from_sa;
  --actual waitrequest port, which is an e_assign
  internal_NiosII_clock_0_out_waitrequest <= NOT NiosII_clock_0_out_run;
  --NiosII_clock_0_out_reset_n assignment, which is an e_assign
  NiosII_clock_0_out_reset_n <= reset_n;
  --vhdl renameroo for output signals
  NiosII_clock_0_out_address_to_slave <= internal_NiosII_clock_0_out_address_to_slave;
  --vhdl renameroo for output signals
  NiosII_clock_0_out_waitrequest <= internal_NiosII_clock_0_out_waitrequest;
--synthesis translate_off
    --NiosII_clock_0_out_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_0_out_address_last_time <= std_logic_vector'("0000000000000000000000000");
      elsif clk'event and clk = '1' then
        NiosII_clock_0_out_address_last_time <= NiosII_clock_0_out_address;
      end if;

    end process;

    --NiosII_clock_0/out waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_NiosII_clock_0_out_waitrequest AND ((NiosII_clock_0_out_read OR NiosII_clock_0_out_write));
      end if;

    end process;

    --NiosII_clock_0_out_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_0_out_address /= NiosII_clock_0_out_address_last_time))))) = '1' then 
          write(write_line, now);
          write(write_line, string'(": "));
          write(write_line, string'("NiosII_clock_0_out_address did not heed wait!!!"));
          write(output, write_line.all);
          deallocate (write_line);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_0_out_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_0_out_byteenable_last_time <= std_logic_vector'("00");
      elsif clk'event and clk = '1' then
        NiosII_clock_0_out_byteenable_last_time <= NiosII_clock_0_out_byteenable;
      end if;

    end process;

    --NiosII_clock_0_out_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line1 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_0_out_byteenable /= NiosII_clock_0_out_byteenable_last_time))))) = '1' then 
          write(write_line1, now);
          write(write_line1, string'(": "));
          write(write_line1, string'("NiosII_clock_0_out_byteenable did not heed wait!!!"));
          write(output, write_line1.all);
          deallocate (write_line1);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_0_out_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_0_out_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        NiosII_clock_0_out_read_last_time <= NiosII_clock_0_out_read;
      end if;

    end process;

    --NiosII_clock_0_out_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line2 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(NiosII_clock_0_out_read) /= std_logic'(NiosII_clock_0_out_read_last_time)))))) = '1' then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("NiosII_clock_0_out_read did not heed wait!!!"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_0_out_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_0_out_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        NiosII_clock_0_out_write_last_time <= NiosII_clock_0_out_write;
      end if;

    end process;

    --NiosII_clock_0_out_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line3 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(NiosII_clock_0_out_write) /= std_logic'(NiosII_clock_0_out_write_last_time)))))) = '1' then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("NiosII_clock_0_out_write did not heed wait!!!"));
          write(output, write_line3.all);
          deallocate (write_line3);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_0_out_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_0_out_writedata_last_time <= std_logic_vector'("0000000000000000");
      elsif clk'event and clk = '1' then
        NiosII_clock_0_out_writedata_last_time <= NiosII_clock_0_out_writedata;
      end if;

    end process;

    --NiosII_clock_0_out_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line4 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_0_out_writedata /= NiosII_clock_0_out_writedata_last_time)))) AND NiosII_clock_0_out_write)) = '1' then 
          write(write_line4, now);
          write(write_line4, string'(": "));
          write(write_line4, string'("NiosII_clock_0_out_writedata did not heed wait!!!"));
          write(output, write_line4.all);
          deallocate (write_line4);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NiosII_clock_1_in_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_1_in_endofpacket : IN STD_LOGIC;
                 signal NiosII_clock_1_in_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_1_in_waitrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal NiosII_clock_1_in_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal NiosII_clock_1_in_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal NiosII_clock_1_in_endofpacket_from_sa : OUT STD_LOGIC;
                 signal NiosII_clock_1_in_nativeaddress : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                 signal NiosII_clock_1_in_read : OUT STD_LOGIC;
                 signal NiosII_clock_1_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_1_in_reset_n : OUT STD_LOGIC;
                 signal NiosII_clock_1_in_waitrequest_from_sa : OUT STD_LOGIC;
                 signal NiosII_clock_1_in_write : OUT STD_LOGIC;
                 signal NiosII_clock_1_in_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_byteenable_NiosII_clock_1_in : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_granted_NiosII_clock_1_in : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_NiosII_clock_1_in : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_NiosII_clock_1_in : OUT STD_LOGIC;
                 signal cpu_data_master_requests_NiosII_clock_1_in : OUT STD_LOGIC;
                 signal d1_NiosII_clock_1_in_end_xfer : OUT STD_LOGIC
              );
end entity NiosII_clock_1_in_arbitrator;


architecture europa of NiosII_clock_1_in_arbitrator is
                signal NiosII_clock_1_in_allgrants :  STD_LOGIC;
                signal NiosII_clock_1_in_allow_new_arb_cycle :  STD_LOGIC;
                signal NiosII_clock_1_in_any_bursting_master_saved_grant :  STD_LOGIC;
                signal NiosII_clock_1_in_any_continuerequest :  STD_LOGIC;
                signal NiosII_clock_1_in_arb_counter_enable :  STD_LOGIC;
                signal NiosII_clock_1_in_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_1_in_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_1_in_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_1_in_beginbursttransfer_internal :  STD_LOGIC;
                signal NiosII_clock_1_in_begins_xfer :  STD_LOGIC;
                signal NiosII_clock_1_in_end_xfer :  STD_LOGIC;
                signal NiosII_clock_1_in_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_1_in_grant_vector :  STD_LOGIC;
                signal NiosII_clock_1_in_in_a_read_cycle :  STD_LOGIC;
                signal NiosII_clock_1_in_in_a_write_cycle :  STD_LOGIC;
                signal NiosII_clock_1_in_master_qreq_vector :  STD_LOGIC;
                signal NiosII_clock_1_in_non_bursting_master_requests :  STD_LOGIC;
                signal NiosII_clock_1_in_reg_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_1_in_slavearbiterlockenable :  STD_LOGIC;
                signal NiosII_clock_1_in_slavearbiterlockenable2 :  STD_LOGIC;
                signal NiosII_clock_1_in_unreg_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_1_in_waits_for_read :  STD_LOGIC;
                signal NiosII_clock_1_in_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_byteenable_NiosII_clock_1_in_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_byteenable_NiosII_clock_1_in_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_NiosII_clock_1_in :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_NiosII_clock_1_in :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_NiosII_clock_1_in_waitrequest_from_sa :  STD_LOGIC;
                signal internal_cpu_data_master_byteenable_NiosII_clock_1_in :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_data_master_granted_NiosII_clock_1_in :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_NiosII_clock_1_in :  STD_LOGIC;
                signal internal_cpu_data_master_requests_NiosII_clock_1_in :  STD_LOGIC;
                signal wait_for_NiosII_clock_1_in_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT NiosII_clock_1_in_end_xfer;
    end if;

  end process;

  NiosII_clock_1_in_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_NiosII_clock_1_in);
  --assign NiosII_clock_1_in_readdata_from_sa = NiosII_clock_1_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  NiosII_clock_1_in_readdata_from_sa <= NiosII_clock_1_in_readdata;
  internal_cpu_data_master_requests_NiosII_clock_1_in <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 25) & std_logic_vector'("0000000000000000000000000")) = std_logic_vector'("010000000000000000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign NiosII_clock_1_in_waitrequest_from_sa = NiosII_clock_1_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_NiosII_clock_1_in_waitrequest_from_sa <= NiosII_clock_1_in_waitrequest;
  --NiosII_clock_1_in_arb_share_counter set values, which is an e_mux
  NiosII_clock_1_in_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_NiosII_clock_1_in)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 2);
  --NiosII_clock_1_in_non_bursting_master_requests mux, which is an e_mux
  NiosII_clock_1_in_non_bursting_master_requests <= internal_cpu_data_master_requests_NiosII_clock_1_in;
  --NiosII_clock_1_in_any_bursting_master_saved_grant mux, which is an e_mux
  NiosII_clock_1_in_any_bursting_master_saved_grant <= std_logic'('0');
  --NiosII_clock_1_in_arb_share_counter_next_value assignment, which is an e_assign
  NiosII_clock_1_in_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(NiosII_clock_1_in_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (NiosII_clock_1_in_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(NiosII_clock_1_in_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (NiosII_clock_1_in_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --NiosII_clock_1_in_allgrants all slave grants, which is an e_mux
  NiosII_clock_1_in_allgrants <= NiosII_clock_1_in_grant_vector;
  --NiosII_clock_1_in_end_xfer assignment, which is an e_assign
  NiosII_clock_1_in_end_xfer <= NOT ((NiosII_clock_1_in_waits_for_read OR NiosII_clock_1_in_waits_for_write));
  --end_xfer_arb_share_counter_term_NiosII_clock_1_in arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_NiosII_clock_1_in <= NiosII_clock_1_in_end_xfer AND (((NOT NiosII_clock_1_in_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --NiosII_clock_1_in_arb_share_counter arbitration counter enable, which is an e_assign
  NiosII_clock_1_in_arb_counter_enable <= ((end_xfer_arb_share_counter_term_NiosII_clock_1_in AND NiosII_clock_1_in_allgrants)) OR ((end_xfer_arb_share_counter_term_NiosII_clock_1_in AND NOT NiosII_clock_1_in_non_bursting_master_requests));
  --NiosII_clock_1_in_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_1_in_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(NiosII_clock_1_in_arb_counter_enable) = '1' then 
        NiosII_clock_1_in_arb_share_counter <= NiosII_clock_1_in_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --NiosII_clock_1_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_1_in_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((NiosII_clock_1_in_master_qreq_vector AND end_xfer_arb_share_counter_term_NiosII_clock_1_in)) OR ((end_xfer_arb_share_counter_term_NiosII_clock_1_in AND NOT NiosII_clock_1_in_non_bursting_master_requests)))) = '1' then 
        NiosII_clock_1_in_slavearbiterlockenable <= or_reduce(NiosII_clock_1_in_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master NiosII_clock_1/in arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= NiosII_clock_1_in_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --NiosII_clock_1_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  NiosII_clock_1_in_slavearbiterlockenable2 <= or_reduce(NiosII_clock_1_in_arb_share_counter_next_value);
  --cpu/data_master NiosII_clock_1/in arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= NiosII_clock_1_in_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --NiosII_clock_1_in_any_continuerequest at least one master continues requesting, which is an e_assign
  NiosII_clock_1_in_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_NiosII_clock_1_in <= internal_cpu_data_master_requests_NiosII_clock_1_in AND NOT ((((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))))) OR (((NOT(or_reduce(internal_cpu_data_master_byteenable_NiosII_clock_1_in))) AND cpu_data_master_write))));
  --local readdatavalid cpu_data_master_read_data_valid_NiosII_clock_1_in, which is an e_mux
  cpu_data_master_read_data_valid_NiosII_clock_1_in <= (internal_cpu_data_master_granted_NiosII_clock_1_in AND cpu_data_master_read) AND NOT NiosII_clock_1_in_waits_for_read;
  --NiosII_clock_1_in_writedata mux, which is an e_mux
  NiosII_clock_1_in_writedata <= cpu_data_master_dbs_write_16;
  --assign NiosII_clock_1_in_endofpacket_from_sa = NiosII_clock_1_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  NiosII_clock_1_in_endofpacket_from_sa <= NiosII_clock_1_in_endofpacket;
  --master is always granted when requested
  internal_cpu_data_master_granted_NiosII_clock_1_in <= internal_cpu_data_master_qualified_request_NiosII_clock_1_in;
  --cpu/data_master saved-grant NiosII_clock_1/in, which is an e_assign
  cpu_data_master_saved_grant_NiosII_clock_1_in <= internal_cpu_data_master_requests_NiosII_clock_1_in;
  --allow new arb cycle for NiosII_clock_1/in, which is an e_assign
  NiosII_clock_1_in_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  NiosII_clock_1_in_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  NiosII_clock_1_in_master_qreq_vector <= std_logic'('1');
  --NiosII_clock_1_in_reset_n assignment, which is an e_assign
  NiosII_clock_1_in_reset_n <= reset_n;
  --NiosII_clock_1_in_firsttransfer first transaction, which is an e_assign
  NiosII_clock_1_in_firsttransfer <= A_WE_StdLogic((std_logic'(NiosII_clock_1_in_begins_xfer) = '1'), NiosII_clock_1_in_unreg_firsttransfer, NiosII_clock_1_in_reg_firsttransfer);
  --NiosII_clock_1_in_unreg_firsttransfer first transaction, which is an e_assign
  NiosII_clock_1_in_unreg_firsttransfer <= NOT ((NiosII_clock_1_in_slavearbiterlockenable AND NiosII_clock_1_in_any_continuerequest));
  --NiosII_clock_1_in_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_1_in_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(NiosII_clock_1_in_begins_xfer) = '1' then 
        NiosII_clock_1_in_reg_firsttransfer <= NiosII_clock_1_in_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --NiosII_clock_1_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  NiosII_clock_1_in_beginbursttransfer_internal <= NiosII_clock_1_in_begins_xfer;
  --NiosII_clock_1_in_read assignment, which is an e_mux
  NiosII_clock_1_in_read <= internal_cpu_data_master_granted_NiosII_clock_1_in AND cpu_data_master_read;
  --NiosII_clock_1_in_write assignment, which is an e_mux
  NiosII_clock_1_in_write <= internal_cpu_data_master_granted_NiosII_clock_1_in AND cpu_data_master_write;
  --NiosII_clock_1_in_address mux, which is an e_mux
  NiosII_clock_1_in_address <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --slaveid NiosII_clock_1_in_nativeaddress nativeaddress mux, which is an e_mux
  NiosII_clock_1_in_nativeaddress <= A_EXT (A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")), 24);
  --d1_NiosII_clock_1_in_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_NiosII_clock_1_in_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_NiosII_clock_1_in_end_xfer <= NiosII_clock_1_in_end_xfer;
    end if;

  end process;

  --NiosII_clock_1_in_waits_for_read in a cycle, which is an e_mux
  NiosII_clock_1_in_waits_for_read <= NiosII_clock_1_in_in_a_read_cycle AND internal_NiosII_clock_1_in_waitrequest_from_sa;
  --NiosII_clock_1_in_in_a_read_cycle assignment, which is an e_assign
  NiosII_clock_1_in_in_a_read_cycle <= internal_cpu_data_master_granted_NiosII_clock_1_in AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= NiosII_clock_1_in_in_a_read_cycle;
  --NiosII_clock_1_in_waits_for_write in a cycle, which is an e_mux
  NiosII_clock_1_in_waits_for_write <= NiosII_clock_1_in_in_a_write_cycle AND internal_NiosII_clock_1_in_waitrequest_from_sa;
  --NiosII_clock_1_in_in_a_write_cycle assignment, which is an e_assign
  NiosII_clock_1_in_in_a_write_cycle <= internal_cpu_data_master_granted_NiosII_clock_1_in AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= NiosII_clock_1_in_in_a_write_cycle;
  wait_for_NiosII_clock_1_in_counter <= std_logic'('0');
  --NiosII_clock_1_in_byteenable byte enable port mux, which is an e_mux
  NiosII_clock_1_in_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_NiosII_clock_1_in)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_byteenable_NiosII_clock_1_in)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (cpu_data_master_byteenable_NiosII_clock_1_in_segment_1(1), cpu_data_master_byteenable_NiosII_clock_1_in_segment_1(0), cpu_data_master_byteenable_NiosII_clock_1_in_segment_0(1), cpu_data_master_byteenable_NiosII_clock_1_in_segment_0(0)) <= cpu_data_master_byteenable;
  internal_cpu_data_master_byteenable_NiosII_clock_1_in <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_data_master_byteenable_NiosII_clock_1_in_segment_0, cpu_data_master_byteenable_NiosII_clock_1_in_segment_1);
  --vhdl renameroo for output signals
  NiosII_clock_1_in_waitrequest_from_sa <= internal_NiosII_clock_1_in_waitrequest_from_sa;
  --vhdl renameroo for output signals
  cpu_data_master_byteenable_NiosII_clock_1_in <= internal_cpu_data_master_byteenable_NiosII_clock_1_in;
  --vhdl renameroo for output signals
  cpu_data_master_granted_NiosII_clock_1_in <= internal_cpu_data_master_granted_NiosII_clock_1_in;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_NiosII_clock_1_in <= internal_cpu_data_master_qualified_request_NiosII_clock_1_in;
  --vhdl renameroo for output signals
  cpu_data_master_requests_NiosII_clock_1_in <= internal_cpu_data_master_requests_NiosII_clock_1_in;
--synthesis translate_off
    --NiosII_clock_1/in enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity NiosII_clock_1_out_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_1_out_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal NiosII_clock_1_out_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal NiosII_clock_1_out_granted_sdram_s1 : IN STD_LOGIC;
                 signal NiosII_clock_1_out_qualified_request_sdram_s1 : IN STD_LOGIC;
                 signal NiosII_clock_1_out_read : IN STD_LOGIC;
                 signal NiosII_clock_1_out_read_data_valid_sdram_s1 : IN STD_LOGIC;
                 signal NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal NiosII_clock_1_out_requests_sdram_s1 : IN STD_LOGIC;
                 signal NiosII_clock_1_out_write : IN STD_LOGIC;
                 signal NiosII_clock_1_out_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal NiosII_clock_1_out_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal NiosII_clock_1_out_readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_1_out_reset_n : OUT STD_LOGIC;
                 signal NiosII_clock_1_out_waitrequest : OUT STD_LOGIC
              );
end entity NiosII_clock_1_out_arbitrator;


architecture europa of NiosII_clock_1_out_arbitrator is
                signal NiosII_clock_1_out_address_last_time :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal NiosII_clock_1_out_byteenable_last_time :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_1_out_read_last_time :  STD_LOGIC;
                signal NiosII_clock_1_out_run :  STD_LOGIC;
                signal NiosII_clock_1_out_write_last_time :  STD_LOGIC;
                signal NiosII_clock_1_out_writedata_last_time :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal internal_NiosII_clock_1_out_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal internal_NiosII_clock_1_out_waitrequest :  STD_LOGIC;
                signal r_5 :  STD_LOGIC;

begin

  --r_5 master_run cascaded wait assignment, which is an e_assign
  r_5 <= Vector_To_Std_Logic(((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NiosII_clock_1_out_qualified_request_sdram_s1 OR NiosII_clock_1_out_read_data_valid_sdram_s1) OR NOT NiosII_clock_1_out_requests_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_1_out_granted_sdram_s1 OR NOT NiosII_clock_1_out_qualified_request_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT NiosII_clock_1_out_qualified_request_sdram_s1 OR NOT NiosII_clock_1_out_read) OR ((NiosII_clock_1_out_read_data_valid_sdram_s1 AND NiosII_clock_1_out_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT NiosII_clock_1_out_qualified_request_sdram_s1 OR NOT ((NiosII_clock_1_out_read OR NiosII_clock_1_out_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_1_out_read OR NiosII_clock_1_out_write)))))))))));
  --cascaded wait assignment, which is an e_assign
  NiosII_clock_1_out_run <= r_5;
  --optimize select-logic by passing only those address bits which matter.
  internal_NiosII_clock_1_out_address_to_slave <= NiosII_clock_1_out_address;
  --NiosII_clock_1/out readdata mux, which is an e_mux
  NiosII_clock_1_out_readdata <= sdram_s1_readdata_from_sa;
  --actual waitrequest port, which is an e_assign
  internal_NiosII_clock_1_out_waitrequest <= NOT NiosII_clock_1_out_run;
  --NiosII_clock_1_out_reset_n assignment, which is an e_assign
  NiosII_clock_1_out_reset_n <= reset_n;
  --vhdl renameroo for output signals
  NiosII_clock_1_out_address_to_slave <= internal_NiosII_clock_1_out_address_to_slave;
  --vhdl renameroo for output signals
  NiosII_clock_1_out_waitrequest <= internal_NiosII_clock_1_out_waitrequest;
--synthesis translate_off
    --NiosII_clock_1_out_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_1_out_address_last_time <= std_logic_vector'("0000000000000000000000000");
      elsif clk'event and clk = '1' then
        NiosII_clock_1_out_address_last_time <= NiosII_clock_1_out_address;
      end if;

    end process;

    --NiosII_clock_1/out waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_NiosII_clock_1_out_waitrequest AND ((NiosII_clock_1_out_read OR NiosII_clock_1_out_write));
      end if;

    end process;

    --NiosII_clock_1_out_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line5 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_1_out_address /= NiosII_clock_1_out_address_last_time))))) = '1' then 
          write(write_line5, now);
          write(write_line5, string'(": "));
          write(write_line5, string'("NiosII_clock_1_out_address did not heed wait!!!"));
          write(output, write_line5.all);
          deallocate (write_line5);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_1_out_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_1_out_byteenable_last_time <= std_logic_vector'("00");
      elsif clk'event and clk = '1' then
        NiosII_clock_1_out_byteenable_last_time <= NiosII_clock_1_out_byteenable;
      end if;

    end process;

    --NiosII_clock_1_out_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line6 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_1_out_byteenable /= NiosII_clock_1_out_byteenable_last_time))))) = '1' then 
          write(write_line6, now);
          write(write_line6, string'(": "));
          write(write_line6, string'("NiosII_clock_1_out_byteenable did not heed wait!!!"));
          write(output, write_line6.all);
          deallocate (write_line6);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_1_out_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_1_out_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        NiosII_clock_1_out_read_last_time <= NiosII_clock_1_out_read;
      end if;

    end process;

    --NiosII_clock_1_out_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line7 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(NiosII_clock_1_out_read) /= std_logic'(NiosII_clock_1_out_read_last_time)))))) = '1' then 
          write(write_line7, now);
          write(write_line7, string'(": "));
          write(write_line7, string'("NiosII_clock_1_out_read did not heed wait!!!"));
          write(output, write_line7.all);
          deallocate (write_line7);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_1_out_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_1_out_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        NiosII_clock_1_out_write_last_time <= NiosII_clock_1_out_write;
      end if;

    end process;

    --NiosII_clock_1_out_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line8 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(NiosII_clock_1_out_write) /= std_logic'(NiosII_clock_1_out_write_last_time)))))) = '1' then 
          write(write_line8, now);
          write(write_line8, string'(": "));
          write(write_line8, string'("NiosII_clock_1_out_write did not heed wait!!!"));
          write(output, write_line8.all);
          deallocate (write_line8);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_1_out_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_1_out_writedata_last_time <= std_logic_vector'("0000000000000000");
      elsif clk'event and clk = '1' then
        NiosII_clock_1_out_writedata_last_time <= NiosII_clock_1_out_writedata;
      end if;

    end process;

    --NiosII_clock_1_out_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line9 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_1_out_writedata /= NiosII_clock_1_out_writedata_last_time)))) AND NiosII_clock_1_out_write)) = '1' then 
          write(write_line9, now);
          write(write_line9, string'(": "));
          write(write_line9, string'("NiosII_clock_1_out_writedata did not heed wait!!!"));
          write(output, write_line9.all);
          deallocate (write_line9);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NiosII_clock_2_in_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_2_in_endofpacket : IN STD_LOGIC;
                 signal NiosII_clock_2_in_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal NiosII_clock_2_in_waitrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal NiosII_clock_2_in_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal NiosII_clock_2_in_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal NiosII_clock_2_in_endofpacket_from_sa : OUT STD_LOGIC;
                 signal NiosII_clock_2_in_nativeaddress : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal NiosII_clock_2_in_read : OUT STD_LOGIC;
                 signal NiosII_clock_2_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal NiosII_clock_2_in_reset_n : OUT STD_LOGIC;
                 signal NiosII_clock_2_in_waitrequest_from_sa : OUT STD_LOGIC;
                 signal NiosII_clock_2_in_write : OUT STD_LOGIC;
                 signal NiosII_clock_2_in_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_NiosII_clock_2_in : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_NiosII_clock_2_in : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_NiosII_clock_2_in : OUT STD_LOGIC;
                 signal cpu_data_master_requests_NiosII_clock_2_in : OUT STD_LOGIC;
                 signal d1_NiosII_clock_2_in_end_xfer : OUT STD_LOGIC
              );
end entity NiosII_clock_2_in_arbitrator;


architecture europa of NiosII_clock_2_in_arbitrator is
                signal NiosII_clock_2_in_allgrants :  STD_LOGIC;
                signal NiosII_clock_2_in_allow_new_arb_cycle :  STD_LOGIC;
                signal NiosII_clock_2_in_any_bursting_master_saved_grant :  STD_LOGIC;
                signal NiosII_clock_2_in_any_continuerequest :  STD_LOGIC;
                signal NiosII_clock_2_in_arb_counter_enable :  STD_LOGIC;
                signal NiosII_clock_2_in_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_2_in_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_2_in_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_2_in_beginbursttransfer_internal :  STD_LOGIC;
                signal NiosII_clock_2_in_begins_xfer :  STD_LOGIC;
                signal NiosII_clock_2_in_end_xfer :  STD_LOGIC;
                signal NiosII_clock_2_in_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_2_in_grant_vector :  STD_LOGIC;
                signal NiosII_clock_2_in_in_a_read_cycle :  STD_LOGIC;
                signal NiosII_clock_2_in_in_a_write_cycle :  STD_LOGIC;
                signal NiosII_clock_2_in_master_qreq_vector :  STD_LOGIC;
                signal NiosII_clock_2_in_non_bursting_master_requests :  STD_LOGIC;
                signal NiosII_clock_2_in_reg_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_2_in_slavearbiterlockenable :  STD_LOGIC;
                signal NiosII_clock_2_in_slavearbiterlockenable2 :  STD_LOGIC;
                signal NiosII_clock_2_in_unreg_firsttransfer :  STD_LOGIC;
                signal NiosII_clock_2_in_waits_for_read :  STD_LOGIC;
                signal NiosII_clock_2_in_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_NiosII_clock_2_in :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_NiosII_clock_2_in :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_NiosII_clock_2_in_waitrequest_from_sa :  STD_LOGIC;
                signal internal_cpu_data_master_granted_NiosII_clock_2_in :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_NiosII_clock_2_in :  STD_LOGIC;
                signal internal_cpu_data_master_requests_NiosII_clock_2_in :  STD_LOGIC;
                signal wait_for_NiosII_clock_2_in_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT NiosII_clock_2_in_end_xfer;
    end if;

  end process;

  NiosII_clock_2_in_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_NiosII_clock_2_in);
  --assign NiosII_clock_2_in_readdata_from_sa = NiosII_clock_2_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  NiosII_clock_2_in_readdata_from_sa <= NiosII_clock_2_in_readdata;
  internal_cpu_data_master_requests_NiosII_clock_2_in <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000010100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign NiosII_clock_2_in_waitrequest_from_sa = NiosII_clock_2_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_NiosII_clock_2_in_waitrequest_from_sa <= NiosII_clock_2_in_waitrequest;
  --NiosII_clock_2_in_arb_share_counter set values, which is an e_mux
  NiosII_clock_2_in_arb_share_set_values <= std_logic_vector'("01");
  --NiosII_clock_2_in_non_bursting_master_requests mux, which is an e_mux
  NiosII_clock_2_in_non_bursting_master_requests <= internal_cpu_data_master_requests_NiosII_clock_2_in;
  --NiosII_clock_2_in_any_bursting_master_saved_grant mux, which is an e_mux
  NiosII_clock_2_in_any_bursting_master_saved_grant <= std_logic'('0');
  --NiosII_clock_2_in_arb_share_counter_next_value assignment, which is an e_assign
  NiosII_clock_2_in_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(NiosII_clock_2_in_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (NiosII_clock_2_in_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(NiosII_clock_2_in_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (NiosII_clock_2_in_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --NiosII_clock_2_in_allgrants all slave grants, which is an e_mux
  NiosII_clock_2_in_allgrants <= NiosII_clock_2_in_grant_vector;
  --NiosII_clock_2_in_end_xfer assignment, which is an e_assign
  NiosII_clock_2_in_end_xfer <= NOT ((NiosII_clock_2_in_waits_for_read OR NiosII_clock_2_in_waits_for_write));
  --end_xfer_arb_share_counter_term_NiosII_clock_2_in arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_NiosII_clock_2_in <= NiosII_clock_2_in_end_xfer AND (((NOT NiosII_clock_2_in_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --NiosII_clock_2_in_arb_share_counter arbitration counter enable, which is an e_assign
  NiosII_clock_2_in_arb_counter_enable <= ((end_xfer_arb_share_counter_term_NiosII_clock_2_in AND NiosII_clock_2_in_allgrants)) OR ((end_xfer_arb_share_counter_term_NiosII_clock_2_in AND NOT NiosII_clock_2_in_non_bursting_master_requests));
  --NiosII_clock_2_in_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_2_in_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(NiosII_clock_2_in_arb_counter_enable) = '1' then 
        NiosII_clock_2_in_arb_share_counter <= NiosII_clock_2_in_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --NiosII_clock_2_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_2_in_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((NiosII_clock_2_in_master_qreq_vector AND end_xfer_arb_share_counter_term_NiosII_clock_2_in)) OR ((end_xfer_arb_share_counter_term_NiosII_clock_2_in AND NOT NiosII_clock_2_in_non_bursting_master_requests)))) = '1' then 
        NiosII_clock_2_in_slavearbiterlockenable <= or_reduce(NiosII_clock_2_in_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master NiosII_clock_2/in arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= NiosII_clock_2_in_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --NiosII_clock_2_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  NiosII_clock_2_in_slavearbiterlockenable2 <= or_reduce(NiosII_clock_2_in_arb_share_counter_next_value);
  --cpu/data_master NiosII_clock_2/in arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= NiosII_clock_2_in_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --NiosII_clock_2_in_any_continuerequest at least one master continues requesting, which is an e_assign
  NiosII_clock_2_in_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_NiosII_clock_2_in <= internal_cpu_data_master_requests_NiosII_clock_2_in AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_NiosII_clock_2_in, which is an e_mux
  cpu_data_master_read_data_valid_NiosII_clock_2_in <= (internal_cpu_data_master_granted_NiosII_clock_2_in AND cpu_data_master_read) AND NOT NiosII_clock_2_in_waits_for_read;
  --NiosII_clock_2_in_writedata mux, which is an e_mux
  NiosII_clock_2_in_writedata <= cpu_data_master_writedata;
  --assign NiosII_clock_2_in_endofpacket_from_sa = NiosII_clock_2_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  NiosII_clock_2_in_endofpacket_from_sa <= NiosII_clock_2_in_endofpacket;
  --master is always granted when requested
  internal_cpu_data_master_granted_NiosII_clock_2_in <= internal_cpu_data_master_qualified_request_NiosII_clock_2_in;
  --cpu/data_master saved-grant NiosII_clock_2/in, which is an e_assign
  cpu_data_master_saved_grant_NiosII_clock_2_in <= internal_cpu_data_master_requests_NiosII_clock_2_in;
  --allow new arb cycle for NiosII_clock_2/in, which is an e_assign
  NiosII_clock_2_in_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  NiosII_clock_2_in_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  NiosII_clock_2_in_master_qreq_vector <= std_logic'('1');
  --NiosII_clock_2_in_reset_n assignment, which is an e_assign
  NiosII_clock_2_in_reset_n <= reset_n;
  --NiosII_clock_2_in_firsttransfer first transaction, which is an e_assign
  NiosII_clock_2_in_firsttransfer <= A_WE_StdLogic((std_logic'(NiosII_clock_2_in_begins_xfer) = '1'), NiosII_clock_2_in_unreg_firsttransfer, NiosII_clock_2_in_reg_firsttransfer);
  --NiosII_clock_2_in_unreg_firsttransfer first transaction, which is an e_assign
  NiosII_clock_2_in_unreg_firsttransfer <= NOT ((NiosII_clock_2_in_slavearbiterlockenable AND NiosII_clock_2_in_any_continuerequest));
  --NiosII_clock_2_in_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      NiosII_clock_2_in_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(NiosII_clock_2_in_begins_xfer) = '1' then 
        NiosII_clock_2_in_reg_firsttransfer <= NiosII_clock_2_in_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --NiosII_clock_2_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  NiosII_clock_2_in_beginbursttransfer_internal <= NiosII_clock_2_in_begins_xfer;
  --NiosII_clock_2_in_read assignment, which is an e_mux
  NiosII_clock_2_in_read <= internal_cpu_data_master_granted_NiosII_clock_2_in AND cpu_data_master_read;
  --NiosII_clock_2_in_write assignment, which is an e_mux
  NiosII_clock_2_in_write <= internal_cpu_data_master_granted_NiosII_clock_2_in AND cpu_data_master_write;
  --NiosII_clock_2_in_address mux, which is an e_mux
  NiosII_clock_2_in_address <= cpu_data_master_address_to_slave (3 DOWNTO 0);
  --slaveid NiosII_clock_2_in_nativeaddress nativeaddress mux, which is an e_mux
  NiosII_clock_2_in_nativeaddress <= A_EXT (A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_NiosII_clock_2_in_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_NiosII_clock_2_in_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_NiosII_clock_2_in_end_xfer <= NiosII_clock_2_in_end_xfer;
    end if;

  end process;

  --NiosII_clock_2_in_waits_for_read in a cycle, which is an e_mux
  NiosII_clock_2_in_waits_for_read <= NiosII_clock_2_in_in_a_read_cycle AND internal_NiosII_clock_2_in_waitrequest_from_sa;
  --NiosII_clock_2_in_in_a_read_cycle assignment, which is an e_assign
  NiosII_clock_2_in_in_a_read_cycle <= internal_cpu_data_master_granted_NiosII_clock_2_in AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= NiosII_clock_2_in_in_a_read_cycle;
  --NiosII_clock_2_in_waits_for_write in a cycle, which is an e_mux
  NiosII_clock_2_in_waits_for_write <= NiosII_clock_2_in_in_a_write_cycle AND internal_NiosII_clock_2_in_waitrequest_from_sa;
  --NiosII_clock_2_in_in_a_write_cycle assignment, which is an e_assign
  NiosII_clock_2_in_in_a_write_cycle <= internal_cpu_data_master_granted_NiosII_clock_2_in AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= NiosII_clock_2_in_in_a_write_cycle;
  wait_for_NiosII_clock_2_in_counter <= std_logic'('0');
  --NiosII_clock_2_in_byteenable byte enable port mux, which is an e_mux
  NiosII_clock_2_in_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_NiosII_clock_2_in)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  NiosII_clock_2_in_waitrequest_from_sa <= internal_NiosII_clock_2_in_waitrequest_from_sa;
  --vhdl renameroo for output signals
  cpu_data_master_granted_NiosII_clock_2_in <= internal_cpu_data_master_granted_NiosII_clock_2_in;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_NiosII_clock_2_in <= internal_cpu_data_master_qualified_request_NiosII_clock_2_in;
  --vhdl renameroo for output signals
  cpu_data_master_requests_NiosII_clock_2_in <= internal_cpu_data_master_requests_NiosII_clock_2_in;
--synthesis translate_off
    --NiosII_clock_2/in enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity NiosII_clock_2_out_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_2_out_address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal NiosII_clock_2_out_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal NiosII_clock_2_out_granted_pll_pll_slave : IN STD_LOGIC;
                 signal NiosII_clock_2_out_qualified_request_pll_pll_slave : IN STD_LOGIC;
                 signal NiosII_clock_2_out_read : IN STD_LOGIC;
                 signal NiosII_clock_2_out_read_data_valid_pll_pll_slave : IN STD_LOGIC;
                 signal NiosII_clock_2_out_requests_pll_pll_slave : IN STD_LOGIC;
                 signal NiosII_clock_2_out_write : IN STD_LOGIC;
                 signal NiosII_clock_2_out_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal d1_pll_pll_slave_end_xfer : IN STD_LOGIC;
                 signal pll_pll_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal NiosII_clock_2_out_address_to_slave : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal NiosII_clock_2_out_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal NiosII_clock_2_out_reset_n : OUT STD_LOGIC;
                 signal NiosII_clock_2_out_waitrequest : OUT STD_LOGIC
              );
end entity NiosII_clock_2_out_arbitrator;


architecture europa of NiosII_clock_2_out_arbitrator is
                signal NiosII_clock_2_out_address_last_time :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal NiosII_clock_2_out_byteenable_last_time :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal NiosII_clock_2_out_read_last_time :  STD_LOGIC;
                signal NiosII_clock_2_out_run :  STD_LOGIC;
                signal NiosII_clock_2_out_write_last_time :  STD_LOGIC;
                signal NiosII_clock_2_out_writedata_last_time :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal internal_NiosII_clock_2_out_address_to_slave :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal internal_NiosII_clock_2_out_waitrequest :  STD_LOGIC;
                signal r_5 :  STD_LOGIC;

begin

  --r_5 master_run cascaded wait assignment, which is an e_assign
  r_5 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001") AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT NiosII_clock_2_out_qualified_request_pll_pll_slave OR NOT ((NiosII_clock_2_out_read OR NiosII_clock_2_out_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_2_out_read OR NiosII_clock_2_out_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT NiosII_clock_2_out_qualified_request_pll_pll_slave OR NOT ((NiosII_clock_2_out_read OR NiosII_clock_2_out_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_2_out_read OR NiosII_clock_2_out_write)))))))))));
  --cascaded wait assignment, which is an e_assign
  NiosII_clock_2_out_run <= r_5;
  --optimize select-logic by passing only those address bits which matter.
  internal_NiosII_clock_2_out_address_to_slave <= NiosII_clock_2_out_address;
  --NiosII_clock_2/out readdata mux, which is an e_mux
  NiosII_clock_2_out_readdata <= pll_pll_slave_readdata_from_sa;
  --actual waitrequest port, which is an e_assign
  internal_NiosII_clock_2_out_waitrequest <= NOT NiosII_clock_2_out_run;
  --NiosII_clock_2_out_reset_n assignment, which is an e_assign
  NiosII_clock_2_out_reset_n <= reset_n;
  --vhdl renameroo for output signals
  NiosII_clock_2_out_address_to_slave <= internal_NiosII_clock_2_out_address_to_slave;
  --vhdl renameroo for output signals
  NiosII_clock_2_out_waitrequest <= internal_NiosII_clock_2_out_waitrequest;
--synthesis translate_off
    --NiosII_clock_2_out_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_2_out_address_last_time <= std_logic_vector'("0000");
      elsif clk'event and clk = '1' then
        NiosII_clock_2_out_address_last_time <= NiosII_clock_2_out_address;
      end if;

    end process;

    --NiosII_clock_2/out waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_NiosII_clock_2_out_waitrequest AND ((NiosII_clock_2_out_read OR NiosII_clock_2_out_write));
      end if;

    end process;

    --NiosII_clock_2_out_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line10 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_2_out_address /= NiosII_clock_2_out_address_last_time))))) = '1' then 
          write(write_line10, now);
          write(write_line10, string'(": "));
          write(write_line10, string'("NiosII_clock_2_out_address did not heed wait!!!"));
          write(output, write_line10.all);
          deallocate (write_line10);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_2_out_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_2_out_byteenable_last_time <= std_logic_vector'("0000");
      elsif clk'event and clk = '1' then
        NiosII_clock_2_out_byteenable_last_time <= NiosII_clock_2_out_byteenable;
      end if;

    end process;

    --NiosII_clock_2_out_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line11 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_2_out_byteenable /= NiosII_clock_2_out_byteenable_last_time))))) = '1' then 
          write(write_line11, now);
          write(write_line11, string'(": "));
          write(write_line11, string'("NiosII_clock_2_out_byteenable did not heed wait!!!"));
          write(output, write_line11.all);
          deallocate (write_line11);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_2_out_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_2_out_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        NiosII_clock_2_out_read_last_time <= NiosII_clock_2_out_read;
      end if;

    end process;

    --NiosII_clock_2_out_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line12 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(NiosII_clock_2_out_read) /= std_logic'(NiosII_clock_2_out_read_last_time)))))) = '1' then 
          write(write_line12, now);
          write(write_line12, string'(": "));
          write(write_line12, string'("NiosII_clock_2_out_read did not heed wait!!!"));
          write(output, write_line12.all);
          deallocate (write_line12);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_2_out_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_2_out_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        NiosII_clock_2_out_write_last_time <= NiosII_clock_2_out_write;
      end if;

    end process;

    --NiosII_clock_2_out_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line13 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(NiosII_clock_2_out_write) /= std_logic'(NiosII_clock_2_out_write_last_time)))))) = '1' then 
          write(write_line13, now);
          write(write_line13, string'(": "));
          write(write_line13, string'("NiosII_clock_2_out_write did not heed wait!!!"));
          write(output, write_line13.all);
          deallocate (write_line13);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --NiosII_clock_2_out_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        NiosII_clock_2_out_writedata_last_time <= std_logic_vector'("00000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        NiosII_clock_2_out_writedata_last_time <= NiosII_clock_2_out_writedata;
      end if;

    end process;

    --NiosII_clock_2_out_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line14 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((NiosII_clock_2_out_writedata /= NiosII_clock_2_out_writedata_last_time)))) AND NiosII_clock_2_out_write)) = '1' then 
          write(write_line14, now);
          write(write_line14, string'(": "));
          write(write_line14, string'("NiosII_clock_2_out_writedata did not heed wait!!!"));
          write(output, write_line14.all);
          deallocate (write_line14);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PWM_1_s1_arbitrator is 
        port (
              -- inputs:
                 signal PWM_1_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal PWM_1_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal PWM_1_s1_chipselect : OUT STD_LOGIC;
                 signal PWM_1_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PWM_1_s1_reset_n : OUT STD_LOGIC;
                 signal PWM_1_s1_write_n : OUT STD_LOGIC;
                 signal PWM_1_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_PWM_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_PWM_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PWM_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_PWM_1_s1 : OUT STD_LOGIC;
                 signal d1_PWM_1_s1_end_xfer : OUT STD_LOGIC
              );
end entity PWM_1_s1_arbitrator;


architecture europa of PWM_1_s1_arbitrator is
                signal PWM_1_s1_allgrants :  STD_LOGIC;
                signal PWM_1_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal PWM_1_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal PWM_1_s1_any_continuerequest :  STD_LOGIC;
                signal PWM_1_s1_arb_counter_enable :  STD_LOGIC;
                signal PWM_1_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_1_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_1_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_1_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal PWM_1_s1_begins_xfer :  STD_LOGIC;
                signal PWM_1_s1_end_xfer :  STD_LOGIC;
                signal PWM_1_s1_firsttransfer :  STD_LOGIC;
                signal PWM_1_s1_grant_vector :  STD_LOGIC;
                signal PWM_1_s1_in_a_read_cycle :  STD_LOGIC;
                signal PWM_1_s1_in_a_write_cycle :  STD_LOGIC;
                signal PWM_1_s1_master_qreq_vector :  STD_LOGIC;
                signal PWM_1_s1_non_bursting_master_requests :  STD_LOGIC;
                signal PWM_1_s1_reg_firsttransfer :  STD_LOGIC;
                signal PWM_1_s1_slavearbiterlockenable :  STD_LOGIC;
                signal PWM_1_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal PWM_1_s1_unreg_firsttransfer :  STD_LOGIC;
                signal PWM_1_s1_waits_for_read :  STD_LOGIC;
                signal PWM_1_s1_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_PWM_1_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_PWM_1_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_PWM_1_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_PWM_1_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_PWM_1_s1 :  STD_LOGIC;
                signal shifted_address_to_PWM_1_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_PWM_1_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT PWM_1_s1_end_xfer;
    end if;

  end process;

  PWM_1_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_PWM_1_s1);
  --assign PWM_1_s1_readdata_from_sa = PWM_1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  PWM_1_s1_readdata_from_sa <= PWM_1_s1_readdata;
  internal_cpu_data_master_requests_PWM_1_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000101010000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --PWM_1_s1_arb_share_counter set values, which is an e_mux
  PWM_1_s1_arb_share_set_values <= std_logic_vector'("01");
  --PWM_1_s1_non_bursting_master_requests mux, which is an e_mux
  PWM_1_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_PWM_1_s1;
  --PWM_1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  PWM_1_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --PWM_1_s1_arb_share_counter_next_value assignment, which is an e_assign
  PWM_1_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(PWM_1_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (PWM_1_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(PWM_1_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (PWM_1_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --PWM_1_s1_allgrants all slave grants, which is an e_mux
  PWM_1_s1_allgrants <= PWM_1_s1_grant_vector;
  --PWM_1_s1_end_xfer assignment, which is an e_assign
  PWM_1_s1_end_xfer <= NOT ((PWM_1_s1_waits_for_read OR PWM_1_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_PWM_1_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_PWM_1_s1 <= PWM_1_s1_end_xfer AND (((NOT PWM_1_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --PWM_1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  PWM_1_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_PWM_1_s1 AND PWM_1_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_PWM_1_s1 AND NOT PWM_1_s1_non_bursting_master_requests));
  --PWM_1_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_1_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(PWM_1_s1_arb_counter_enable) = '1' then 
        PWM_1_s1_arb_share_counter <= PWM_1_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --PWM_1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_1_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((PWM_1_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_PWM_1_s1)) OR ((end_xfer_arb_share_counter_term_PWM_1_s1 AND NOT PWM_1_s1_non_bursting_master_requests)))) = '1' then 
        PWM_1_s1_slavearbiterlockenable <= or_reduce(PWM_1_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master PWM_1/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= PWM_1_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --PWM_1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  PWM_1_s1_slavearbiterlockenable2 <= or_reduce(PWM_1_s1_arb_share_counter_next_value);
  --cpu/data_master PWM_1/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= PWM_1_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --PWM_1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  PWM_1_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_PWM_1_s1 <= internal_cpu_data_master_requests_PWM_1_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_PWM_1_s1, which is an e_mux
  cpu_data_master_read_data_valid_PWM_1_s1 <= (internal_cpu_data_master_granted_PWM_1_s1 AND cpu_data_master_read) AND NOT PWM_1_s1_waits_for_read;
  --PWM_1_s1_writedata mux, which is an e_mux
  PWM_1_s1_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_PWM_1_s1 <= internal_cpu_data_master_qualified_request_PWM_1_s1;
  --cpu/data_master saved-grant PWM_1/s1, which is an e_assign
  cpu_data_master_saved_grant_PWM_1_s1 <= internal_cpu_data_master_requests_PWM_1_s1;
  --allow new arb cycle for PWM_1/s1, which is an e_assign
  PWM_1_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  PWM_1_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  PWM_1_s1_master_qreq_vector <= std_logic'('1');
  --PWM_1_s1_reset_n assignment, which is an e_assign
  PWM_1_s1_reset_n <= reset_n;
  PWM_1_s1_chipselect <= internal_cpu_data_master_granted_PWM_1_s1;
  --PWM_1_s1_firsttransfer first transaction, which is an e_assign
  PWM_1_s1_firsttransfer <= A_WE_StdLogic((std_logic'(PWM_1_s1_begins_xfer) = '1'), PWM_1_s1_unreg_firsttransfer, PWM_1_s1_reg_firsttransfer);
  --PWM_1_s1_unreg_firsttransfer first transaction, which is an e_assign
  PWM_1_s1_unreg_firsttransfer <= NOT ((PWM_1_s1_slavearbiterlockenable AND PWM_1_s1_any_continuerequest));
  --PWM_1_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_1_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(PWM_1_s1_begins_xfer) = '1' then 
        PWM_1_s1_reg_firsttransfer <= PWM_1_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --PWM_1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  PWM_1_s1_beginbursttransfer_internal <= PWM_1_s1_begins_xfer;
  --~PWM_1_s1_write_n assignment, which is an e_mux
  PWM_1_s1_write_n <= NOT ((internal_cpu_data_master_granted_PWM_1_s1 AND cpu_data_master_write));
  shifted_address_to_PWM_1_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --PWM_1_s1_address mux, which is an e_mux
  PWM_1_s1_address <= A_EXT (A_SRL(shifted_address_to_PWM_1_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_PWM_1_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_PWM_1_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_PWM_1_s1_end_xfer <= PWM_1_s1_end_xfer;
    end if;

  end process;

  --PWM_1_s1_waits_for_read in a cycle, which is an e_mux
  PWM_1_s1_waits_for_read <= PWM_1_s1_in_a_read_cycle AND PWM_1_s1_begins_xfer;
  --PWM_1_s1_in_a_read_cycle assignment, which is an e_assign
  PWM_1_s1_in_a_read_cycle <= internal_cpu_data_master_granted_PWM_1_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= PWM_1_s1_in_a_read_cycle;
  --PWM_1_s1_waits_for_write in a cycle, which is an e_mux
  PWM_1_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PWM_1_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --PWM_1_s1_in_a_write_cycle assignment, which is an e_assign
  PWM_1_s1_in_a_write_cycle <= internal_cpu_data_master_granted_PWM_1_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= PWM_1_s1_in_a_write_cycle;
  wait_for_PWM_1_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_PWM_1_s1 <= internal_cpu_data_master_granted_PWM_1_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_PWM_1_s1 <= internal_cpu_data_master_qualified_request_PWM_1_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_PWM_1_s1 <= internal_cpu_data_master_requests_PWM_1_s1;
--synthesis translate_off
    --PWM_1/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PWM_2_s1_arbitrator is 
        port (
              -- inputs:
                 signal PWM_2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal PWM_2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal PWM_2_s1_chipselect : OUT STD_LOGIC;
                 signal PWM_2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PWM_2_s1_reset_n : OUT STD_LOGIC;
                 signal PWM_2_s1_write_n : OUT STD_LOGIC;
                 signal PWM_2_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_PWM_2_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_PWM_2_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PWM_2_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_PWM_2_s1 : OUT STD_LOGIC;
                 signal d1_PWM_2_s1_end_xfer : OUT STD_LOGIC
              );
end entity PWM_2_s1_arbitrator;


architecture europa of PWM_2_s1_arbitrator is
                signal PWM_2_s1_allgrants :  STD_LOGIC;
                signal PWM_2_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal PWM_2_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal PWM_2_s1_any_continuerequest :  STD_LOGIC;
                signal PWM_2_s1_arb_counter_enable :  STD_LOGIC;
                signal PWM_2_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_2_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_2_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_2_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal PWM_2_s1_begins_xfer :  STD_LOGIC;
                signal PWM_2_s1_end_xfer :  STD_LOGIC;
                signal PWM_2_s1_firsttransfer :  STD_LOGIC;
                signal PWM_2_s1_grant_vector :  STD_LOGIC;
                signal PWM_2_s1_in_a_read_cycle :  STD_LOGIC;
                signal PWM_2_s1_in_a_write_cycle :  STD_LOGIC;
                signal PWM_2_s1_master_qreq_vector :  STD_LOGIC;
                signal PWM_2_s1_non_bursting_master_requests :  STD_LOGIC;
                signal PWM_2_s1_reg_firsttransfer :  STD_LOGIC;
                signal PWM_2_s1_slavearbiterlockenable :  STD_LOGIC;
                signal PWM_2_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal PWM_2_s1_unreg_firsttransfer :  STD_LOGIC;
                signal PWM_2_s1_waits_for_read :  STD_LOGIC;
                signal PWM_2_s1_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_PWM_2_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_PWM_2_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_PWM_2_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_PWM_2_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_PWM_2_s1 :  STD_LOGIC;
                signal shifted_address_to_PWM_2_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_PWM_2_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT PWM_2_s1_end_xfer;
    end if;

  end process;

  PWM_2_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_PWM_2_s1);
  --assign PWM_2_s1_readdata_from_sa = PWM_2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  PWM_2_s1_readdata_from_sa <= PWM_2_s1_readdata;
  internal_cpu_data_master_requests_PWM_2_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000101100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --PWM_2_s1_arb_share_counter set values, which is an e_mux
  PWM_2_s1_arb_share_set_values <= std_logic_vector'("01");
  --PWM_2_s1_non_bursting_master_requests mux, which is an e_mux
  PWM_2_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_PWM_2_s1;
  --PWM_2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  PWM_2_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --PWM_2_s1_arb_share_counter_next_value assignment, which is an e_assign
  PWM_2_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(PWM_2_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (PWM_2_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(PWM_2_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (PWM_2_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --PWM_2_s1_allgrants all slave grants, which is an e_mux
  PWM_2_s1_allgrants <= PWM_2_s1_grant_vector;
  --PWM_2_s1_end_xfer assignment, which is an e_assign
  PWM_2_s1_end_xfer <= NOT ((PWM_2_s1_waits_for_read OR PWM_2_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_PWM_2_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_PWM_2_s1 <= PWM_2_s1_end_xfer AND (((NOT PWM_2_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --PWM_2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  PWM_2_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_PWM_2_s1 AND PWM_2_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_PWM_2_s1 AND NOT PWM_2_s1_non_bursting_master_requests));
  --PWM_2_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_2_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(PWM_2_s1_arb_counter_enable) = '1' then 
        PWM_2_s1_arb_share_counter <= PWM_2_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --PWM_2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_2_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((PWM_2_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_PWM_2_s1)) OR ((end_xfer_arb_share_counter_term_PWM_2_s1 AND NOT PWM_2_s1_non_bursting_master_requests)))) = '1' then 
        PWM_2_s1_slavearbiterlockenable <= or_reduce(PWM_2_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master PWM_2/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= PWM_2_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --PWM_2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  PWM_2_s1_slavearbiterlockenable2 <= or_reduce(PWM_2_s1_arb_share_counter_next_value);
  --cpu/data_master PWM_2/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= PWM_2_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --PWM_2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  PWM_2_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_PWM_2_s1 <= internal_cpu_data_master_requests_PWM_2_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_PWM_2_s1, which is an e_mux
  cpu_data_master_read_data_valid_PWM_2_s1 <= (internal_cpu_data_master_granted_PWM_2_s1 AND cpu_data_master_read) AND NOT PWM_2_s1_waits_for_read;
  --PWM_2_s1_writedata mux, which is an e_mux
  PWM_2_s1_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_PWM_2_s1 <= internal_cpu_data_master_qualified_request_PWM_2_s1;
  --cpu/data_master saved-grant PWM_2/s1, which is an e_assign
  cpu_data_master_saved_grant_PWM_2_s1 <= internal_cpu_data_master_requests_PWM_2_s1;
  --allow new arb cycle for PWM_2/s1, which is an e_assign
  PWM_2_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  PWM_2_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  PWM_2_s1_master_qreq_vector <= std_logic'('1');
  --PWM_2_s1_reset_n assignment, which is an e_assign
  PWM_2_s1_reset_n <= reset_n;
  PWM_2_s1_chipselect <= internal_cpu_data_master_granted_PWM_2_s1;
  --PWM_2_s1_firsttransfer first transaction, which is an e_assign
  PWM_2_s1_firsttransfer <= A_WE_StdLogic((std_logic'(PWM_2_s1_begins_xfer) = '1'), PWM_2_s1_unreg_firsttransfer, PWM_2_s1_reg_firsttransfer);
  --PWM_2_s1_unreg_firsttransfer first transaction, which is an e_assign
  PWM_2_s1_unreg_firsttransfer <= NOT ((PWM_2_s1_slavearbiterlockenable AND PWM_2_s1_any_continuerequest));
  --PWM_2_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_2_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(PWM_2_s1_begins_xfer) = '1' then 
        PWM_2_s1_reg_firsttransfer <= PWM_2_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --PWM_2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  PWM_2_s1_beginbursttransfer_internal <= PWM_2_s1_begins_xfer;
  --~PWM_2_s1_write_n assignment, which is an e_mux
  PWM_2_s1_write_n <= NOT ((internal_cpu_data_master_granted_PWM_2_s1 AND cpu_data_master_write));
  shifted_address_to_PWM_2_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --PWM_2_s1_address mux, which is an e_mux
  PWM_2_s1_address <= A_EXT (A_SRL(shifted_address_to_PWM_2_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_PWM_2_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_PWM_2_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_PWM_2_s1_end_xfer <= PWM_2_s1_end_xfer;
    end if;

  end process;

  --PWM_2_s1_waits_for_read in a cycle, which is an e_mux
  PWM_2_s1_waits_for_read <= PWM_2_s1_in_a_read_cycle AND PWM_2_s1_begins_xfer;
  --PWM_2_s1_in_a_read_cycle assignment, which is an e_assign
  PWM_2_s1_in_a_read_cycle <= internal_cpu_data_master_granted_PWM_2_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= PWM_2_s1_in_a_read_cycle;
  --PWM_2_s1_waits_for_write in a cycle, which is an e_mux
  PWM_2_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PWM_2_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --PWM_2_s1_in_a_write_cycle assignment, which is an e_assign
  PWM_2_s1_in_a_write_cycle <= internal_cpu_data_master_granted_PWM_2_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= PWM_2_s1_in_a_write_cycle;
  wait_for_PWM_2_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_PWM_2_s1 <= internal_cpu_data_master_granted_PWM_2_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_PWM_2_s1 <= internal_cpu_data_master_qualified_request_PWM_2_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_PWM_2_s1 <= internal_cpu_data_master_requests_PWM_2_s1;
--synthesis translate_off
    --PWM_2/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PWM_3_s1_arbitrator is 
        port (
              -- inputs:
                 signal PWM_3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal PWM_3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal PWM_3_s1_chipselect : OUT STD_LOGIC;
                 signal PWM_3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PWM_3_s1_reset_n : OUT STD_LOGIC;
                 signal PWM_3_s1_write_n : OUT STD_LOGIC;
                 signal PWM_3_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_PWM_3_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_PWM_3_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PWM_3_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_PWM_3_s1 : OUT STD_LOGIC;
                 signal d1_PWM_3_s1_end_xfer : OUT STD_LOGIC
              );
end entity PWM_3_s1_arbitrator;


architecture europa of PWM_3_s1_arbitrator is
                signal PWM_3_s1_allgrants :  STD_LOGIC;
                signal PWM_3_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal PWM_3_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal PWM_3_s1_any_continuerequest :  STD_LOGIC;
                signal PWM_3_s1_arb_counter_enable :  STD_LOGIC;
                signal PWM_3_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_3_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_3_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_3_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal PWM_3_s1_begins_xfer :  STD_LOGIC;
                signal PWM_3_s1_end_xfer :  STD_LOGIC;
                signal PWM_3_s1_firsttransfer :  STD_LOGIC;
                signal PWM_3_s1_grant_vector :  STD_LOGIC;
                signal PWM_3_s1_in_a_read_cycle :  STD_LOGIC;
                signal PWM_3_s1_in_a_write_cycle :  STD_LOGIC;
                signal PWM_3_s1_master_qreq_vector :  STD_LOGIC;
                signal PWM_3_s1_non_bursting_master_requests :  STD_LOGIC;
                signal PWM_3_s1_reg_firsttransfer :  STD_LOGIC;
                signal PWM_3_s1_slavearbiterlockenable :  STD_LOGIC;
                signal PWM_3_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal PWM_3_s1_unreg_firsttransfer :  STD_LOGIC;
                signal PWM_3_s1_waits_for_read :  STD_LOGIC;
                signal PWM_3_s1_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_PWM_3_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_PWM_3_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_PWM_3_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_PWM_3_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_PWM_3_s1 :  STD_LOGIC;
                signal shifted_address_to_PWM_3_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_PWM_3_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT PWM_3_s1_end_xfer;
    end if;

  end process;

  PWM_3_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_PWM_3_s1);
  --assign PWM_3_s1_readdata_from_sa = PWM_3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  PWM_3_s1_readdata_from_sa <= PWM_3_s1_readdata;
  internal_cpu_data_master_requests_PWM_3_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000101110000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --PWM_3_s1_arb_share_counter set values, which is an e_mux
  PWM_3_s1_arb_share_set_values <= std_logic_vector'("01");
  --PWM_3_s1_non_bursting_master_requests mux, which is an e_mux
  PWM_3_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_PWM_3_s1;
  --PWM_3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  PWM_3_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --PWM_3_s1_arb_share_counter_next_value assignment, which is an e_assign
  PWM_3_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(PWM_3_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (PWM_3_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(PWM_3_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (PWM_3_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --PWM_3_s1_allgrants all slave grants, which is an e_mux
  PWM_3_s1_allgrants <= PWM_3_s1_grant_vector;
  --PWM_3_s1_end_xfer assignment, which is an e_assign
  PWM_3_s1_end_xfer <= NOT ((PWM_3_s1_waits_for_read OR PWM_3_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_PWM_3_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_PWM_3_s1 <= PWM_3_s1_end_xfer AND (((NOT PWM_3_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --PWM_3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  PWM_3_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_PWM_3_s1 AND PWM_3_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_PWM_3_s1 AND NOT PWM_3_s1_non_bursting_master_requests));
  --PWM_3_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_3_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(PWM_3_s1_arb_counter_enable) = '1' then 
        PWM_3_s1_arb_share_counter <= PWM_3_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --PWM_3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_3_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((PWM_3_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_PWM_3_s1)) OR ((end_xfer_arb_share_counter_term_PWM_3_s1 AND NOT PWM_3_s1_non_bursting_master_requests)))) = '1' then 
        PWM_3_s1_slavearbiterlockenable <= or_reduce(PWM_3_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master PWM_3/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= PWM_3_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --PWM_3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  PWM_3_s1_slavearbiterlockenable2 <= or_reduce(PWM_3_s1_arb_share_counter_next_value);
  --cpu/data_master PWM_3/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= PWM_3_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --PWM_3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  PWM_3_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_PWM_3_s1 <= internal_cpu_data_master_requests_PWM_3_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_PWM_3_s1, which is an e_mux
  cpu_data_master_read_data_valid_PWM_3_s1 <= (internal_cpu_data_master_granted_PWM_3_s1 AND cpu_data_master_read) AND NOT PWM_3_s1_waits_for_read;
  --PWM_3_s1_writedata mux, which is an e_mux
  PWM_3_s1_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_PWM_3_s1 <= internal_cpu_data_master_qualified_request_PWM_3_s1;
  --cpu/data_master saved-grant PWM_3/s1, which is an e_assign
  cpu_data_master_saved_grant_PWM_3_s1 <= internal_cpu_data_master_requests_PWM_3_s1;
  --allow new arb cycle for PWM_3/s1, which is an e_assign
  PWM_3_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  PWM_3_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  PWM_3_s1_master_qreq_vector <= std_logic'('1');
  --PWM_3_s1_reset_n assignment, which is an e_assign
  PWM_3_s1_reset_n <= reset_n;
  PWM_3_s1_chipselect <= internal_cpu_data_master_granted_PWM_3_s1;
  --PWM_3_s1_firsttransfer first transaction, which is an e_assign
  PWM_3_s1_firsttransfer <= A_WE_StdLogic((std_logic'(PWM_3_s1_begins_xfer) = '1'), PWM_3_s1_unreg_firsttransfer, PWM_3_s1_reg_firsttransfer);
  --PWM_3_s1_unreg_firsttransfer first transaction, which is an e_assign
  PWM_3_s1_unreg_firsttransfer <= NOT ((PWM_3_s1_slavearbiterlockenable AND PWM_3_s1_any_continuerequest));
  --PWM_3_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_3_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(PWM_3_s1_begins_xfer) = '1' then 
        PWM_3_s1_reg_firsttransfer <= PWM_3_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --PWM_3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  PWM_3_s1_beginbursttransfer_internal <= PWM_3_s1_begins_xfer;
  --~PWM_3_s1_write_n assignment, which is an e_mux
  PWM_3_s1_write_n <= NOT ((internal_cpu_data_master_granted_PWM_3_s1 AND cpu_data_master_write));
  shifted_address_to_PWM_3_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --PWM_3_s1_address mux, which is an e_mux
  PWM_3_s1_address <= A_EXT (A_SRL(shifted_address_to_PWM_3_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_PWM_3_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_PWM_3_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_PWM_3_s1_end_xfer <= PWM_3_s1_end_xfer;
    end if;

  end process;

  --PWM_3_s1_waits_for_read in a cycle, which is an e_mux
  PWM_3_s1_waits_for_read <= PWM_3_s1_in_a_read_cycle AND PWM_3_s1_begins_xfer;
  --PWM_3_s1_in_a_read_cycle assignment, which is an e_assign
  PWM_3_s1_in_a_read_cycle <= internal_cpu_data_master_granted_PWM_3_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= PWM_3_s1_in_a_read_cycle;
  --PWM_3_s1_waits_for_write in a cycle, which is an e_mux
  PWM_3_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PWM_3_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --PWM_3_s1_in_a_write_cycle assignment, which is an e_assign
  PWM_3_s1_in_a_write_cycle <= internal_cpu_data_master_granted_PWM_3_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= PWM_3_s1_in_a_write_cycle;
  wait_for_PWM_3_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_PWM_3_s1 <= internal_cpu_data_master_granted_PWM_3_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_PWM_3_s1 <= internal_cpu_data_master_qualified_request_PWM_3_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_PWM_3_s1 <= internal_cpu_data_master_requests_PWM_3_s1;
--synthesis translate_off
    --PWM_3/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PWM_4_s1_arbitrator is 
        port (
              -- inputs:
                 signal PWM_4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal PWM_4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal PWM_4_s1_chipselect : OUT STD_LOGIC;
                 signal PWM_4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PWM_4_s1_reset_n : OUT STD_LOGIC;
                 signal PWM_4_s1_write_n : OUT STD_LOGIC;
                 signal PWM_4_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_PWM_4_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_PWM_4_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PWM_4_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_PWM_4_s1 : OUT STD_LOGIC;
                 signal d1_PWM_4_s1_end_xfer : OUT STD_LOGIC
              );
end entity PWM_4_s1_arbitrator;


architecture europa of PWM_4_s1_arbitrator is
                signal PWM_4_s1_allgrants :  STD_LOGIC;
                signal PWM_4_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal PWM_4_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal PWM_4_s1_any_continuerequest :  STD_LOGIC;
                signal PWM_4_s1_arb_counter_enable :  STD_LOGIC;
                signal PWM_4_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_4_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_4_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_4_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal PWM_4_s1_begins_xfer :  STD_LOGIC;
                signal PWM_4_s1_end_xfer :  STD_LOGIC;
                signal PWM_4_s1_firsttransfer :  STD_LOGIC;
                signal PWM_4_s1_grant_vector :  STD_LOGIC;
                signal PWM_4_s1_in_a_read_cycle :  STD_LOGIC;
                signal PWM_4_s1_in_a_write_cycle :  STD_LOGIC;
                signal PWM_4_s1_master_qreq_vector :  STD_LOGIC;
                signal PWM_4_s1_non_bursting_master_requests :  STD_LOGIC;
                signal PWM_4_s1_reg_firsttransfer :  STD_LOGIC;
                signal PWM_4_s1_slavearbiterlockenable :  STD_LOGIC;
                signal PWM_4_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal PWM_4_s1_unreg_firsttransfer :  STD_LOGIC;
                signal PWM_4_s1_waits_for_read :  STD_LOGIC;
                signal PWM_4_s1_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_PWM_4_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_PWM_4_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_PWM_4_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_PWM_4_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_PWM_4_s1 :  STD_LOGIC;
                signal shifted_address_to_PWM_4_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_PWM_4_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT PWM_4_s1_end_xfer;
    end if;

  end process;

  PWM_4_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_PWM_4_s1);
  --assign PWM_4_s1_readdata_from_sa = PWM_4_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  PWM_4_s1_readdata_from_sa <= PWM_4_s1_readdata;
  internal_cpu_data_master_requests_PWM_4_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000110000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --PWM_4_s1_arb_share_counter set values, which is an e_mux
  PWM_4_s1_arb_share_set_values <= std_logic_vector'("01");
  --PWM_4_s1_non_bursting_master_requests mux, which is an e_mux
  PWM_4_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_PWM_4_s1;
  --PWM_4_s1_any_bursting_master_saved_grant mux, which is an e_mux
  PWM_4_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --PWM_4_s1_arb_share_counter_next_value assignment, which is an e_assign
  PWM_4_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(PWM_4_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (PWM_4_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(PWM_4_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (PWM_4_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --PWM_4_s1_allgrants all slave grants, which is an e_mux
  PWM_4_s1_allgrants <= PWM_4_s1_grant_vector;
  --PWM_4_s1_end_xfer assignment, which is an e_assign
  PWM_4_s1_end_xfer <= NOT ((PWM_4_s1_waits_for_read OR PWM_4_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_PWM_4_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_PWM_4_s1 <= PWM_4_s1_end_xfer AND (((NOT PWM_4_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --PWM_4_s1_arb_share_counter arbitration counter enable, which is an e_assign
  PWM_4_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_PWM_4_s1 AND PWM_4_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_PWM_4_s1 AND NOT PWM_4_s1_non_bursting_master_requests));
  --PWM_4_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_4_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(PWM_4_s1_arb_counter_enable) = '1' then 
        PWM_4_s1_arb_share_counter <= PWM_4_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --PWM_4_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_4_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((PWM_4_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_PWM_4_s1)) OR ((end_xfer_arb_share_counter_term_PWM_4_s1 AND NOT PWM_4_s1_non_bursting_master_requests)))) = '1' then 
        PWM_4_s1_slavearbiterlockenable <= or_reduce(PWM_4_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master PWM_4/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= PWM_4_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --PWM_4_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  PWM_4_s1_slavearbiterlockenable2 <= or_reduce(PWM_4_s1_arb_share_counter_next_value);
  --cpu/data_master PWM_4/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= PWM_4_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --PWM_4_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  PWM_4_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_PWM_4_s1 <= internal_cpu_data_master_requests_PWM_4_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_PWM_4_s1, which is an e_mux
  cpu_data_master_read_data_valid_PWM_4_s1 <= (internal_cpu_data_master_granted_PWM_4_s1 AND cpu_data_master_read) AND NOT PWM_4_s1_waits_for_read;
  --PWM_4_s1_writedata mux, which is an e_mux
  PWM_4_s1_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_PWM_4_s1 <= internal_cpu_data_master_qualified_request_PWM_4_s1;
  --cpu/data_master saved-grant PWM_4/s1, which is an e_assign
  cpu_data_master_saved_grant_PWM_4_s1 <= internal_cpu_data_master_requests_PWM_4_s1;
  --allow new arb cycle for PWM_4/s1, which is an e_assign
  PWM_4_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  PWM_4_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  PWM_4_s1_master_qreq_vector <= std_logic'('1');
  --PWM_4_s1_reset_n assignment, which is an e_assign
  PWM_4_s1_reset_n <= reset_n;
  PWM_4_s1_chipselect <= internal_cpu_data_master_granted_PWM_4_s1;
  --PWM_4_s1_firsttransfer first transaction, which is an e_assign
  PWM_4_s1_firsttransfer <= A_WE_StdLogic((std_logic'(PWM_4_s1_begins_xfer) = '1'), PWM_4_s1_unreg_firsttransfer, PWM_4_s1_reg_firsttransfer);
  --PWM_4_s1_unreg_firsttransfer first transaction, which is an e_assign
  PWM_4_s1_unreg_firsttransfer <= NOT ((PWM_4_s1_slavearbiterlockenable AND PWM_4_s1_any_continuerequest));
  --PWM_4_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PWM_4_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(PWM_4_s1_begins_xfer) = '1' then 
        PWM_4_s1_reg_firsttransfer <= PWM_4_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --PWM_4_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  PWM_4_s1_beginbursttransfer_internal <= PWM_4_s1_begins_xfer;
  --~PWM_4_s1_write_n assignment, which is an e_mux
  PWM_4_s1_write_n <= NOT ((internal_cpu_data_master_granted_PWM_4_s1 AND cpu_data_master_write));
  shifted_address_to_PWM_4_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --PWM_4_s1_address mux, which is an e_mux
  PWM_4_s1_address <= A_EXT (A_SRL(shifted_address_to_PWM_4_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_PWM_4_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_PWM_4_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_PWM_4_s1_end_xfer <= PWM_4_s1_end_xfer;
    end if;

  end process;

  --PWM_4_s1_waits_for_read in a cycle, which is an e_mux
  PWM_4_s1_waits_for_read <= PWM_4_s1_in_a_read_cycle AND PWM_4_s1_begins_xfer;
  --PWM_4_s1_in_a_read_cycle assignment, which is an e_assign
  PWM_4_s1_in_a_read_cycle <= internal_cpu_data_master_granted_PWM_4_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= PWM_4_s1_in_a_read_cycle;
  --PWM_4_s1_waits_for_write in a cycle, which is an e_mux
  PWM_4_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PWM_4_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --PWM_4_s1_in_a_write_cycle assignment, which is an e_assign
  PWM_4_s1_in_a_write_cycle <= internal_cpu_data_master_granted_PWM_4_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= PWM_4_s1_in_a_write_cycle;
  wait_for_PWM_4_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_PWM_4_s1 <= internal_cpu_data_master_granted_PWM_4_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_PWM_4_s1 <= internal_cpu_data_master_qualified_request_PWM_4_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_PWM_4_s1 <= internal_cpu_data_master_requests_PWM_4_s1;
--synthesis translate_off
    --PWM_4/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_jtag_debug_module_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_debugaccess : IN STD_LOGIC;
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC;
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_resetrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal cpu_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_jtag_debug_module_chipselect : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_write : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_jtag_debug_module_end_xfer : OUT STD_LOGIC
              );
end entity cpu_jtag_debug_module_arbitrator;


architecture europa of cpu_jtag_debug_module_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_jtag_debug_module_allgrants :  STD_LOGIC;
                signal cpu_jtag_debug_module_allow_new_arb_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_any_bursting_master_saved_grant :  STD_LOGIC;
                signal cpu_jtag_debug_module_any_continuerequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_counter_enable :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arbitration_holdoff_internal :  STD_LOGIC;
                signal cpu_jtag_debug_module_beginbursttransfer_internal :  STD_LOGIC;
                signal cpu_jtag_debug_module_begins_xfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_jtag_debug_module_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_in_a_read_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_in_a_write_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_non_bursting_master_requests :  STD_LOGIC;
                signal cpu_jtag_debug_module_reg_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_slavearbiterlockenable :  STD_LOGIC;
                signal cpu_jtag_debug_module_slavearbiterlockenable2 :  STD_LOGIC;
                signal cpu_jtag_debug_module_unreg_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_waits_for_read :  STD_LOGIC;
                signal cpu_jtag_debug_module_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_cpu_jtag_debug_module :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_data_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module :  STD_LOGIC;
                signal shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_cpu_jtag_debug_module_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT cpu_jtag_debug_module_end_xfer;
    end if;

  end process;

  cpu_jtag_debug_module_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_cpu_jtag_debug_module OR internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  --assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_jtag_debug_module_readdata_from_sa <= cpu_jtag_debug_module_readdata;
  internal_cpu_data_master_requests_cpu_jtag_debug_module <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000000000001000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  cpu_jtag_debug_module_arb_share_set_values <= std_logic_vector'("01");
  --cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  cpu_jtag_debug_module_non_bursting_master_requests <= ((internal_cpu_data_master_requests_cpu_jtag_debug_module OR internal_cpu_instruction_master_requests_cpu_jtag_debug_module) OR internal_cpu_data_master_requests_cpu_jtag_debug_module) OR internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  cpu_jtag_debug_module_any_bursting_master_saved_grant <= std_logic'('0');
  --cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  cpu_jtag_debug_module_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (cpu_jtag_debug_module_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(cpu_jtag_debug_module_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (cpu_jtag_debug_module_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  cpu_jtag_debug_module_allgrants <= (((or_reduce(cpu_jtag_debug_module_grant_vector)) OR (or_reduce(cpu_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_jtag_debug_module_grant_vector));
  --cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  cpu_jtag_debug_module_end_xfer <= NOT ((cpu_jtag_debug_module_waits_for_read OR cpu_jtag_debug_module_waits_for_write));
  --end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_cpu_jtag_debug_module <= cpu_jtag_debug_module_end_xfer AND (((NOT cpu_jtag_debug_module_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  cpu_jtag_debug_module_arb_counter_enable <= ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND cpu_jtag_debug_module_allgrants)) OR ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND NOT cpu_jtag_debug_module_non_bursting_master_requests));
  --cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_arb_counter_enable) = '1' then 
        cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(cpu_jtag_debug_module_master_qreq_vector) AND end_xfer_arb_share_counter_term_cpu_jtag_debug_module)) OR ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND NOT cpu_jtag_debug_module_non_bursting_master_requests)))) = '1' then 
        cpu_jtag_debug_module_slavearbiterlockenable <= or_reduce(cpu_jtag_debug_module_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= cpu_jtag_debug_module_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  cpu_jtag_debug_module_slavearbiterlockenable2 <= or_reduce(cpu_jtag_debug_module_arb_share_counter_next_value);
  --cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= cpu_jtag_debug_module_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= cpu_jtag_debug_module_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= cpu_jtag_debug_module_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_cpu_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_cpu_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module AND internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  cpu_jtag_debug_module_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_data_master_requests_cpu_jtag_debug_module AND NOT ((((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))))) OR cpu_instruction_master_arbiterlock));
  --local readdatavalid cpu_data_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  cpu_data_master_read_data_valid_cpu_jtag_debug_module <= (internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_read) AND NOT cpu_jtag_debug_module_waits_for_read;
  --cpu_jtag_debug_module_writedata mux, which is an e_mux
  cpu_jtag_debug_module_writedata <= cpu_data_master_writedata;
  internal_cpu_instruction_master_requests_cpu_jtag_debug_module <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(26 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000000000001000000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_cpu_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_cpu_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module AND internal_cpu_data_master_requests_cpu_jtag_debug_module;
  internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_instruction_master_requests_cpu_jtag_debug_module AND NOT ((((cpu_instruction_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))))) OR cpu_data_master_arbiterlock));
  --local readdatavalid cpu_instruction_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  cpu_instruction_master_read_data_valid_cpu_jtag_debug_module <= (internal_cpu_instruction_master_granted_cpu_jtag_debug_module AND cpu_instruction_master_read) AND NOT cpu_jtag_debug_module_waits_for_read;
  --allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  --cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  internal_cpu_instruction_master_granted_cpu_jtag_debug_module <= cpu_jtag_debug_module_grant_vector(0);
  --cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  cpu_instruction_master_saved_grant_cpu_jtag_debug_module <= cpu_jtag_debug_module_arb_winner(0) AND internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_cpu_jtag_debug_module;
  --cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  internal_cpu_data_master_granted_cpu_jtag_debug_module <= cpu_jtag_debug_module_grant_vector(1);
  --cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  cpu_data_master_saved_grant_cpu_jtag_debug_module <= cpu_jtag_debug_module_arb_winner(1) AND internal_cpu_data_master_requests_cpu_jtag_debug_module;
  --cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  cpu_jtag_debug_module_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((cpu_jtag_debug_module_master_qreq_vector & cpu_jtag_debug_module_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT cpu_jtag_debug_module_master_qreq_vector & NOT cpu_jtag_debug_module_master_qreq_vector))) + (std_logic_vector'("000") & (cpu_jtag_debug_module_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  cpu_jtag_debug_module_arb_winner <= A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_allow_new_arb_cycle AND or_reduce(cpu_jtag_debug_module_grant_vector)))) = '1'), cpu_jtag_debug_module_grant_vector, cpu_jtag_debug_module_saved_chosen_master_vector);
  --saved cpu_jtag_debug_module_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_allow_new_arb_cycle) = '1' then 
        cpu_jtag_debug_module_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(cpu_jtag_debug_module_grant_vector)) = '1'), cpu_jtag_debug_module_grant_vector, cpu_jtag_debug_module_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  cpu_jtag_debug_module_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((cpu_jtag_debug_module_chosen_master_double_vector(1) OR cpu_jtag_debug_module_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((cpu_jtag_debug_module_chosen_master_double_vector(0) OR cpu_jtag_debug_module_chosen_master_double_vector(2)))));
  --cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  cpu_jtag_debug_module_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(cpu_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(cpu_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --cpu/jtag_debug_module's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(cpu_jtag_debug_module_grant_vector)) = '1' then 
        cpu_jtag_debug_module_arb_addend <= A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_end_xfer) = '1'), cpu_jtag_debug_module_chosen_master_rot_left, cpu_jtag_debug_module_grant_vector);
      end if;
    end if;

  end process;

  cpu_jtag_debug_module_begintransfer <= cpu_jtag_debug_module_begins_xfer;
  --assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_jtag_debug_module_resetrequest_from_sa <= cpu_jtag_debug_module_resetrequest;
  cpu_jtag_debug_module_chipselect <= internal_cpu_data_master_granted_cpu_jtag_debug_module OR internal_cpu_instruction_master_granted_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  cpu_jtag_debug_module_firsttransfer <= A_WE_StdLogic((std_logic'(cpu_jtag_debug_module_begins_xfer) = '1'), cpu_jtag_debug_module_unreg_firsttransfer, cpu_jtag_debug_module_reg_firsttransfer);
  --cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  cpu_jtag_debug_module_unreg_firsttransfer <= NOT ((cpu_jtag_debug_module_slavearbiterlockenable AND cpu_jtag_debug_module_any_continuerequest));
  --cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_begins_xfer) = '1' then 
        cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  cpu_jtag_debug_module_beginbursttransfer_internal <= cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  cpu_jtag_debug_module_arbitration_holdoff_internal <= cpu_jtag_debug_module_begins_xfer AND cpu_jtag_debug_module_firsttransfer;
  --cpu_jtag_debug_module_write assignment, which is an e_mux
  cpu_jtag_debug_module_write <= internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_write;
  shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --cpu_jtag_debug_module_address mux, which is an e_mux
  cpu_jtag_debug_module_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (A_SRL(shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master <= cpu_instruction_master_address_to_slave;
  --d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_cpu_jtag_debug_module_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
    end if;

  end process;

  --cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  cpu_jtag_debug_module_waits_for_read <= cpu_jtag_debug_module_in_a_read_cycle AND cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  cpu_jtag_debug_module_in_a_read_cycle <= ((internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_cpu_jtag_debug_module AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= cpu_jtag_debug_module_in_a_read_cycle;
  --cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  cpu_jtag_debug_module_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  cpu_jtag_debug_module_in_a_write_cycle <= internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= cpu_jtag_debug_module_in_a_write_cycle;
  wait_for_cpu_jtag_debug_module_counter <= std_logic'('0');
  --cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  cpu_jtag_debug_module_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --debugaccess mux, which is an e_mux
  cpu_jtag_debug_module_debugaccess <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_debugaccess))), std_logic_vector'("00000000000000000000000000000000")));
  --vhdl renameroo for output signals
  cpu_data_master_granted_cpu_jtag_debug_module <= internal_cpu_data_master_granted_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_data_master_qualified_request_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_data_master_requests_cpu_jtag_debug_module <= internal_cpu_data_master_requests_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_cpu_jtag_debug_module <= internal_cpu_instruction_master_granted_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_cpu_jtag_debug_module <= internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
--synthesis translate_off
    --cpu/jtag_debug_module enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line15 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_cpu_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_cpu_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line15, now);
          write(write_line15, string'(": "));
          write(write_line15, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line15.all);
          deallocate (write_line15);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line16 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_cpu_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_cpu_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line16, now);
          write(write_line16, string'(": "));
          write(write_line16, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line16.all);
          deallocate (write_line16);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cpu_custom_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa : IN STD_LOGIC;
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custom_instruction_master_multi_start : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_select : OUT STD_LOGIC;
                 signal cpu_custom_instruction_master_multi_done : OUT STD_LOGIC;
                 signal cpu_custom_instruction_master_multi_result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custom_instruction_master_reset_n : OUT STD_LOGIC;
                 signal cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1 : OUT STD_LOGIC
              );
end entity cpu_custom_instruction_master_arbitrator;


architecture europa of cpu_custom_instruction_master_arbitrator is
                signal internal_cpu_altera_nios_custom_instr_floating_point_inst_s1_select :  STD_LOGIC;

begin

  internal_cpu_altera_nios_custom_instr_floating_point_inst_s1_select <= std_logic'('1');
  cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1 <= internal_cpu_altera_nios_custom_instr_floating_point_inst_s1_select AND cpu_custom_instruction_master_multi_start;
  --cpu_custom_instruction_master_multi_result mux, which is an e_mux
  cpu_custom_instruction_master_multi_result <= A_REP(internal_cpu_altera_nios_custom_instr_floating_point_inst_s1_select, 32) AND cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa;
  --multi_done mux, which is an e_mux
  cpu_custom_instruction_master_multi_done <= internal_cpu_altera_nios_custom_instr_floating_point_inst_s1_select AND cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa;
  --cpu_custom_instruction_master_reset_n local reset_n, which is an e_assign
  cpu_custom_instruction_master_reset_n <= reset_n;
  --vhdl renameroo for output signals
  cpu_altera_nios_custom_instr_floating_point_inst_s1_select <= internal_cpu_altera_nios_custom_instr_floating_point_inst_s1_select;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_data_master_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_1_in_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_1_in_waitrequest_from_sa : IN STD_LOGIC;
                 signal NiosII_clock_2_in_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal NiosII_clock_2_in_waitrequest_from_sa : IN STD_LOGIC;
                 signal PWM_1_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PWM_2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PWM_3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PWM_4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_byteenable_NiosII_clock_1_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_granted_NiosII_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_granted_NiosII_clock_2_in : IN STD_LOGIC;
                 signal cpu_data_master_granted_PWM_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_PWM_2_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_PWM_3_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_PWM_4_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_granted_data_tx_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_duty_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_duty_2_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_duty_3_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_duty_4_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_ac_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_ac_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_ac_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_gy_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_gy_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_gy_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_ma_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_ma_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_ma_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_entrada_temp_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_out_test_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_sample_time_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_sysid_control_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_timer_ONOF_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_uart_gps_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_uart_xbee_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_NiosII_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_NiosII_clock_2_in : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_PWM_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_PWM_2_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_PWM_3_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_PWM_4_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_data_tx_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_duty_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_duty_2_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_duty_3_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_duty_4_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ac_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_gy_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ma_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_temp_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_out_test_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_sample_time_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_sysid_control_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_timer_ONOF_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_uart_gps_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_uart_xbee_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_NiosII_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_NiosII_clock_2_in : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PWM_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PWM_2_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PWM_3_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PWM_4_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_data_tx_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_duty_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_duty_2_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_duty_3_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_duty_4_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ac_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_gy_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ma_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_temp_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_out_test_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sample_time_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sysid_control_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_timer_ONOF_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_uart_gps_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_uart_xbee_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_NiosII_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_requests_NiosII_clock_2_in : IN STD_LOGIC;
                 signal cpu_data_master_requests_PWM_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_PWM_2_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_PWM_3_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_PWM_4_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_requests_data_tx_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_duty_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_duty_2_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_duty_3_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_duty_4_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ac_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ac_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ac_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_gy_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_gy_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_gy_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ma_eje_X_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ma_eje_Y_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ma_eje_Z_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_entrada_temp_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_out_test_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_sample_time_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_sysid_control_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_timer_ONOF_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_uart_gps_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_uart_xbee_s1 : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_NiosII_clock_1_in_end_xfer : IN STD_LOGIC;
                 signal d1_NiosII_clock_2_in_end_xfer : IN STD_LOGIC;
                 signal d1_PWM_1_s1_end_xfer : IN STD_LOGIC;
                 signal d1_PWM_2_s1_end_xfer : IN STD_LOGIC;
                 signal d1_PWM_3_s1_end_xfer : IN STD_LOGIC;
                 signal d1_PWM_4_s1_end_xfer : IN STD_LOGIC;
                 signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_data_tx_s1_end_xfer : IN STD_LOGIC;
                 signal d1_duty_1_s1_end_xfer : IN STD_LOGIC;
                 signal d1_duty_2_s1_end_xfer : IN STD_LOGIC;
                 signal d1_duty_3_s1_end_xfer : IN STD_LOGIC;
                 signal d1_duty_4_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_ac_eje_X_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_ac_eje_Y_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_ac_eje_Z_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_gy_eje_X_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_gy_eje_Y_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_gy_eje_Z_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_ma_eje_X_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_ma_eje_Y_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_ma_eje_Z_s1_end_xfer : IN STD_LOGIC;
                 signal d1_entrada_temp_s1_end_xfer : IN STD_LOGIC;
                 signal d1_epcs_flash_controller_epcs_control_port_end_xfer : IN STD_LOGIC;
                 signal d1_jtag_uart_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                 signal d1_out_test_s1_end_xfer : IN STD_LOGIC;
                 signal d1_sample_time_s1_end_xfer : IN STD_LOGIC;
                 signal d1_sysid_control_slave_end_xfer : IN STD_LOGIC;
                 signal d1_timer_ONOF_s1_end_xfer : IN STD_LOGIC;
                 signal d1_uart_gps_s1_end_xfer : IN STD_LOGIC;
                 signal d1_uart_xbee_s1_end_xfer : IN STD_LOGIC;
                 signal data_tx_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal duty_1_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal duty_2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal duty_3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal duty_4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ac_eje_X_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ac_eje_Y_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ac_eje_Z_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_gy_eje_X_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_gy_eje_Y_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_gy_eje_Z_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ma_eje_X_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ma_eje_Y_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ma_eje_Z_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_temp_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal epcs_flash_controller_epcs_control_port_irq_from_sa : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal out_test_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal sample_time_s1_irq_from_sa : IN STD_LOGIC;
                 signal sample_time_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sysid_control_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal timer_ONOF_s1_irq_from_sa : IN STD_LOGIC;
                 signal timer_ONOF_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_gps_s1_irq_from_sa : IN STD_LOGIC;
                 signal uart_gps_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_xbee_s1_irq_from_sa : IN STD_LOGIC;
                 signal uart_xbee_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_latency_counter : OUT STD_LOGIC;
                 signal cpu_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_data_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_data_master_arbitrator;


architecture europa of cpu_data_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_data_master_address_last_time :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_data_master_byteenable_last_time :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_data_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_data_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_data_master_read_last_time :  STD_LOGIC;
                signal cpu_data_master_run :  STD_LOGIC;
                signal cpu_data_master_write_last_time :  STD_LOGIC;
                signal cpu_data_master_writedata_last_time :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal internal_cpu_data_master_address_to_slave :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal internal_cpu_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_data_master_latency_counter :  STD_LOGIC;
                signal internal_cpu_data_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_data_master_latency_counter :  STD_LOGIC;
                signal p1_dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_cpu_data_master_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_2 :  STD_LOGIC;
                signal r_3 :  STD_LOGIC;
                signal r_4 :  STD_LOGIC;
                signal r_5 :  STD_LOGIC;
                signal r_6 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((cpu_data_master_qualified_request_NiosII_clock_1_in OR (((cpu_data_master_write AND NOT(or_reduce(cpu_data_master_byteenable_NiosII_clock_1_in))) AND internal_cpu_data_master_dbs_address(1)))) OR NOT cpu_data_master_requests_NiosII_clock_1_in)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_NiosII_clock_1_in OR NOT cpu_data_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT NiosII_clock_1_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_NiosII_clock_1_in OR NOT cpu_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT NiosII_clock_1_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_NiosII_clock_2_in OR NOT cpu_data_master_requests_NiosII_clock_2_in)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_NiosII_clock_2_in OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT NiosII_clock_2_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_NiosII_clock_2_in OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT NiosII_clock_2_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_PWM_1_s1 OR NOT cpu_data_master_requests_PWM_1_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PWM_1_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_PWM_1_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PWM_1_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_PWM_2_s1 OR NOT cpu_data_master_requests_PWM_2_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PWM_2_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_PWM_2_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PWM_2_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_PWM_3_s1 OR NOT cpu_data_master_requests_PWM_3_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PWM_3_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_PWM_3_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PWM_3_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_data_master_run <= (((((r_0 AND r_1) AND r_2) AND r_3) AND r_4) AND r_5) AND r_6;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_PWM_4_s1 OR NOT cpu_data_master_requests_PWM_4_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PWM_4_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_PWM_4_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PWM_4_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_requests_cpu_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_cpu_jtag_debug_module OR NOT cpu_data_master_qualified_request_cpu_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_data_tx_s1 OR NOT cpu_data_master_requests_data_tx_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_data_tx_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_data_tx_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_data_tx_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_duty_1_s1 OR NOT cpu_data_master_requests_duty_1_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_duty_1_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_duty_1_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_duty_1_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_duty_2_s1 OR NOT cpu_data_master_requests_duty_2_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_duty_2_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_duty_2_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))));
  --r_2 master_run cascaded wait assignment, which is an e_assign
  r_2 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_duty_2_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_duty_3_s1 OR NOT cpu_data_master_requests_duty_3_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_duty_3_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_duty_3_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_duty_3_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_duty_4_s1 OR NOT cpu_data_master_requests_duty_4_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_duty_4_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_duty_4_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_duty_4_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_ac_eje_X_s1 OR NOT cpu_data_master_requests_entrada_ac_eje_X_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ac_eje_X_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_ac_eje_X_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ac_eje_X_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 OR NOT cpu_data_master_requests_entrada_ac_eje_Y_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_ac_eje_Y_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 OR NOT cpu_data_master_requests_entrada_ac_eje_Z_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_ac_eje_Z_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))));
  --r_3 master_run cascaded wait assignment, which is an e_assign
  r_3 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_gy_eje_X_s1 OR NOT cpu_data_master_requests_entrada_gy_eje_X_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_gy_eje_X_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_gy_eje_X_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_gy_eje_X_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 OR NOT cpu_data_master_requests_entrada_gy_eje_Y_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_gy_eje_Y_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 OR NOT cpu_data_master_requests_entrada_gy_eje_Z_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_gy_eje_Z_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_ma_eje_X_s1 OR NOT cpu_data_master_requests_entrada_ma_eje_X_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ma_eje_X_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_ma_eje_X_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ma_eje_X_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 OR NOT cpu_data_master_requests_entrada_ma_eje_Y_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_ma_eje_Y_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))));
  --r_4 master_run cascaded wait assignment, which is an e_assign
  r_4 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 OR NOT cpu_data_master_requests_entrada_ma_eje_Z_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_ma_eje_Z_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_entrada_temp_s1 OR NOT cpu_data_master_requests_entrada_temp_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_temp_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_entrada_temp_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_entrada_temp_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT cpu_data_master_requests_epcs_flash_controller_epcs_control_port)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_epcs_flash_controller_epcs_control_port OR NOT cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT cpu_data_master_requests_jtag_uart_avalon_jtag_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_out_test_s1 OR NOT cpu_data_master_requests_out_test_s1)))))));
  --r_5 master_run cascaded wait assignment, which is an e_assign
  r_5 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_out_test_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_out_test_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_out_test_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_sample_time_s1 OR NOT cpu_data_master_requests_sample_time_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_sample_time_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_sample_time_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_sample_time_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_sysid_control_slave OR NOT cpu_data_master_requests_sysid_control_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_sysid_control_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_sysid_control_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_sysid_control_slave OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_timer_ONOF_s1 OR NOT cpu_data_master_requests_timer_ONOF_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_timer_ONOF_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_timer_ONOF_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_timer_ONOF_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_uart_gps_s1 OR NOT cpu_data_master_requests_uart_gps_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_uart_gps_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_uart_gps_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_uart_gps_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_uart_gps_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_uart_xbee_s1 OR NOT cpu_data_master_requests_uart_xbee_s1)))))));
  --r_6 master_run cascaded wait assignment, which is an e_assign
  r_6 <= Vector_To_Std_Logic(((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_uart_xbee_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_uart_xbee_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_uart_xbee_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_uart_xbee_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_data_master_address_to_slave <= cpu_data_master_address(26 DOWNTO 0);
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic((((((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_requests_NiosII_clock_1_in)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(cpu_data_master_byteenable_NiosII_clock_1_in))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_data_master_granted_NiosII_clock_1_in AND cpu_data_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT NiosII_clock_1_in_waitrequest_from_sa)))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_data_master_granted_NiosII_clock_1_in AND cpu_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT NiosII_clock_1_in_waitrequest_from_sa)))))));
  --cpu_data_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_data_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_data_master_read_but_no_slave_selected <= (cpu_data_master_read AND cpu_data_master_run) AND NOT cpu_data_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_data_master_is_granted_some_slave <= ((((((((((((((((((((((((((((cpu_data_master_granted_NiosII_clock_1_in OR cpu_data_master_granted_NiosII_clock_2_in) OR cpu_data_master_granted_PWM_1_s1) OR cpu_data_master_granted_PWM_2_s1) OR cpu_data_master_granted_PWM_3_s1) OR cpu_data_master_granted_PWM_4_s1) OR cpu_data_master_granted_cpu_jtag_debug_module) OR cpu_data_master_granted_data_tx_s1) OR cpu_data_master_granted_duty_1_s1) OR cpu_data_master_granted_duty_2_s1) OR cpu_data_master_granted_duty_3_s1) OR cpu_data_master_granted_duty_4_s1) OR cpu_data_master_granted_entrada_ac_eje_X_s1) OR cpu_data_master_granted_entrada_ac_eje_Y_s1) OR cpu_data_master_granted_entrada_ac_eje_Z_s1) OR cpu_data_master_granted_entrada_gy_eje_X_s1) OR cpu_data_master_granted_entrada_gy_eje_Y_s1) OR cpu_data_master_granted_entrada_gy_eje_Z_s1) OR cpu_data_master_granted_entrada_ma_eje_X_s1) OR cpu_data_master_granted_entrada_ma_eje_Y_s1) OR cpu_data_master_granted_entrada_ma_eje_Z_s1) OR cpu_data_master_granted_entrada_temp_s1) OR cpu_data_master_granted_epcs_flash_controller_epcs_control_port) OR cpu_data_master_granted_jtag_uart_avalon_jtag_slave) OR cpu_data_master_granted_out_test_s1) OR cpu_data_master_granted_sample_time_s1) OR cpu_data_master_granted_sysid_control_slave) OR cpu_data_master_granted_timer_ONOF_s1) OR cpu_data_master_granted_uart_gps_s1) OR cpu_data_master_granted_uart_xbee_s1;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_data_master_readdatavalid <= std_logic'('0');
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_data_master_readdatavalid <= ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((cpu_data_master_read_but_no_slave_selected OR pre_flush_cpu_data_master_readdatavalid) OR ((cpu_data_master_read_data_valid_NiosII_clock_1_in AND dbs_counter_overflow))) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_NiosII_clock_2_in) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_PWM_1_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_PWM_2_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_PWM_3_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_PWM_4_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_cpu_jtag_debug_module) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_data_tx_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_duty_1_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_duty_2_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_duty_3_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_duty_4_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_ac_eje_X_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_gy_eje_X_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_ma_eje_X_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_entrada_temp_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_out_test_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_sample_time_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_sysid_control_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_timer_ONOF_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_uart_gps_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_uart_xbee_s1;
  --input to dbs-16 stored 0, which is an e_mux
  p1_dbs_16_reg_segment_0 <= NiosII_clock_1_in_readdata_from_sa;
  --dbs register for dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_data_master_dbs_address(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
      end if;
    end if;

  end process;

  --cpu/data_master readdata mux, which is an e_mux
  cpu_data_master_readdata <= ((((((((((((((((((((((((((((((A_REP(NOT ((cpu_data_master_qualified_request_NiosII_clock_1_in AND cpu_data_master_read)) , 32) OR Std_Logic_Vector'(NiosII_clock_1_in_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_NiosII_clock_2_in AND cpu_data_master_read)) , 32) OR NiosII_clock_2_in_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_PWM_1_s1 AND cpu_data_master_read)) , 32) OR PWM_1_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_PWM_2_s1 AND cpu_data_master_read)) , 32) OR PWM_2_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_PWM_3_s1 AND cpu_data_master_read)) , 32) OR PWM_3_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_PWM_4_s1 AND cpu_data_master_read)) , 32) OR PWM_4_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_cpu_jtag_debug_module AND cpu_data_master_read)) , 32) OR cpu_jtag_debug_module_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_data_tx_s1 AND cpu_data_master_read)) , 32) OR data_tx_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_duty_1_s1 AND cpu_data_master_read)) , 32) OR duty_1_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_duty_2_s1 AND cpu_data_master_read)) , 32) OR duty_2_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_duty_3_s1 AND cpu_data_master_read)) , 32) OR duty_3_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_duty_4_s1 AND cpu_data_master_read)) , 32) OR duty_4_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_ac_eje_X_s1 AND cpu_data_master_read)) , 32) OR entrada_ac_eje_X_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 AND cpu_data_master_read)) , 32) OR entrada_ac_eje_Y_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 AND cpu_data_master_read)) , 32) OR entrada_ac_eje_Z_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_gy_eje_X_s1 AND cpu_data_master_read)) , 32) OR entrada_gy_eje_X_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 AND cpu_data_master_read)) , 32) OR entrada_gy_eje_Y_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 AND cpu_data_master_read)) , 32) OR entrada_gy_eje_Z_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_ma_eje_X_s1 AND cpu_data_master_read)) , 32) OR entrada_ma_eje_X_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 AND cpu_data_master_read)) , 32) OR entrada_ma_eje_Y_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 AND cpu_data_master_read)) , 32) OR entrada_ma_eje_Z_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_entrada_temp_s1 AND cpu_data_master_read)) , 32) OR entrada_temp_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port AND cpu_data_master_read)) , 32) OR epcs_flash_controller_epcs_control_port_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave AND cpu_data_master_read)) , 32) OR jtag_uart_avalon_jtag_slave_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_out_test_s1 AND cpu_data_master_read)) , 32) OR out_test_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_sample_time_s1 AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (sample_time_s1_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_sysid_control_slave AND cpu_data_master_read)) , 32) OR sysid_control_slave_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_timer_ONOF_s1 AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (timer_ONOF_s1_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_uart_gps_s1 AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (uart_gps_s1_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_uart_xbee_s1 AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (uart_xbee_s1_readdata_from_sa))));
  --mux write dbs 1, which is an e_mux
  cpu_data_master_dbs_write_16 <= A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_dbs_address(1))) = '1'), cpu_data_master_writedata(31 DOWNTO 16), cpu_data_master_writedata(15 DOWNTO 0));
  --actual waitrequest port, which is an e_assign
  internal_cpu_data_master_waitrequest <= NOT cpu_data_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_latency_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      internal_cpu_data_master_latency_counter <= p1_cpu_data_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_data_master_latency_counter <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((cpu_data_master_run AND cpu_data_master_read))) = '1'), (std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(latency_load_value))), A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_latency_counter)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_latency_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  --read latency load values, which is an e_mux
  latency_load_value <= std_logic'('0');
  --dbs count increment, which is an e_mux
  cpu_data_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_data_master_requests_NiosII_clock_1_in)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000")), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_data_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_data_master_dbs_address)) + (std_logic_vector'("0") & (cpu_data_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_data_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --irq assign, which is an e_assign
  cpu_data_master_irq <= Std_Logic_Vector'(A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(timer_ONOF_s1_irq_from_sa) & A_ToStdLogicVector(uart_xbee_s1_irq_from_sa) & A_ToStdLogicVector(uart_gps_s1_irq_from_sa) & A_ToStdLogicVector(epcs_flash_controller_epcs_control_port_irq_from_sa) & A_ToStdLogicVector(sample_time_s1_irq_from_sa) & A_ToStdLogicVector(jtag_uart_avalon_jtag_slave_irq_from_sa));
  --vhdl renameroo for output signals
  cpu_data_master_address_to_slave <= internal_cpu_data_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_data_master_dbs_address <= internal_cpu_data_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_data_master_latency_counter <= internal_cpu_data_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_data_master_waitrequest <= internal_cpu_data_master_waitrequest;
--synthesis translate_off
    --cpu_data_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_address_last_time <= std_logic_vector'("000000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_data_master_address_last_time <= cpu_data_master_address;
      end if;

    end process;

    --cpu/data_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_data_master_waitrequest AND ((cpu_data_master_read OR cpu_data_master_write));
      end if;

    end process;

    --cpu_data_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line17 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_data_master_address /= cpu_data_master_address_last_time))))) = '1' then 
          write(write_line17, now);
          write(write_line17, string'(": "));
          write(write_line17, string'("cpu_data_master_address did not heed wait!!!"));
          write(output, write_line17.all);
          deallocate (write_line17);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_data_master_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_byteenable_last_time <= std_logic_vector'("0000");
      elsif clk'event and clk = '1' then
        cpu_data_master_byteenable_last_time <= cpu_data_master_byteenable;
      end if;

    end process;

    --cpu_data_master_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line18 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_data_master_byteenable /= cpu_data_master_byteenable_last_time))))) = '1' then 
          write(write_line18, now);
          write(write_line18, string'(": "));
          write(write_line18, string'("cpu_data_master_byteenable did not heed wait!!!"));
          write(output, write_line18.all);
          deallocate (write_line18);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_data_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_data_master_read_last_time <= cpu_data_master_read;
      end if;

    end process;

    --cpu_data_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line19 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_data_master_read) /= std_logic'(cpu_data_master_read_last_time)))))) = '1' then 
          write(write_line19, now);
          write(write_line19, string'(": "));
          write(write_line19, string'("cpu_data_master_read did not heed wait!!!"));
          write(output, write_line19.all);
          deallocate (write_line19);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_data_master_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_data_master_write_last_time <= cpu_data_master_write;
      end if;

    end process;

    --cpu_data_master_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line20 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_data_master_write) /= std_logic'(cpu_data_master_write_last_time)))))) = '1' then 
          write(write_line20, now);
          write(write_line20, string'(": "));
          write(write_line20, string'("cpu_data_master_write did not heed wait!!!"));
          write(output, write_line20.all);
          deallocate (write_line20);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_data_master_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_writedata_last_time <= std_logic_vector'("00000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_data_master_writedata_last_time <= cpu_data_master_writedata;
      end if;

    end process;

    --cpu_data_master_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line21 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((cpu_data_master_writedata /= cpu_data_master_writedata_last_time)))) AND cpu_data_master_write)) = '1' then 
          write(write_line21, now);
          write(write_line21, string'(": "));
          write(write_line21, string'("cpu_data_master_writedata did not heed wait!!!"));
          write(output, write_line21.all);
          deallocate (write_line21);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_0_in_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_0_in_waitrequest_from_sa : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_instruction_master_address : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_instruction_master_granted_NiosII_clock_0_in : IN STD_LOGIC;
                 signal cpu_instruction_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_NiosII_clock_0_in : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_NiosII_clock_0_in : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_NiosII_clock_0_in : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_NiosII_clock_0_in_end_xfer : IN STD_LOGIC;
                 signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_epcs_flash_controller_epcs_control_port_end_xfer : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : OUT STD_LOGIC;
                 signal cpu_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_instruction_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_instruction_master_arbitrator;


architecture europa of cpu_instruction_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_instruction_master_address_last_time :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_instruction_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_instruction_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_instruction_master_read_last_time :  STD_LOGIC;
                signal cpu_instruction_master_run :  STD_LOGIC;
                signal dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal internal_cpu_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal internal_cpu_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_instruction_master_latency_counter :  STD_LOGIC;
                signal internal_cpu_instruction_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_instruction_master_latency_counter :  STD_LOGIC;
                signal p1_dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_cpu_instruction_master_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_4 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_NiosII_clock_0_in OR NOT cpu_instruction_master_requests_NiosII_clock_0_in)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_NiosII_clock_0_in OR NOT cpu_instruction_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT NiosII_clock_0_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_instruction_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_instruction_master_run <= (r_0 AND r_1) AND r_4;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_instruction_master_requests_cpu_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_cpu_jtag_debug_module OR NOT cpu_instruction_master_qualified_request_cpu_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))));
  --r_4 master_run cascaded wait assignment, which is an e_assign
  r_4 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port OR NOT cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT (cpu_instruction_master_read))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_instruction_master_read))))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_instruction_master_address_to_slave <= cpu_instruction_master_address(26 DOWNTO 0);
  --cpu_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_instruction_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_instruction_master_read_but_no_slave_selected <= (cpu_instruction_master_read AND cpu_instruction_master_run) AND NOT cpu_instruction_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_instruction_master_is_granted_some_slave <= (cpu_instruction_master_granted_NiosII_clock_0_in OR cpu_instruction_master_granted_cpu_jtag_debug_module) OR cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_instruction_master_readdatavalid <= std_logic'('0');
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_instruction_master_readdatavalid <= (((((((cpu_instruction_master_read_but_no_slave_selected OR pre_flush_cpu_instruction_master_readdatavalid) OR ((cpu_instruction_master_read_data_valid_NiosII_clock_0_in AND dbs_counter_overflow))) OR cpu_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_instruction_master_readdatavalid) OR cpu_instruction_master_read_data_valid_cpu_jtag_debug_module) OR cpu_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_instruction_master_readdatavalid) OR cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port;
  --input to dbs-16 stored 0, which is an e_mux
  p1_dbs_16_reg_segment_0 <= NiosII_clock_0_in_readdata_from_sa;
  --dbs register for dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_instruction_master_dbs_address(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
      end if;
    end if;

  end process;

  --cpu/instruction_master readdata mux, which is an e_mux
  cpu_instruction_master_readdata <= (((A_REP(NOT ((cpu_instruction_master_qualified_request_NiosII_clock_0_in AND cpu_instruction_master_read)) , 32) OR Std_Logic_Vector'(NiosII_clock_0_in_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0))) AND ((A_REP(NOT ((cpu_instruction_master_qualified_request_cpu_jtag_debug_module AND cpu_instruction_master_read)) , 32) OR cpu_jtag_debug_module_readdata_from_sa))) AND ((A_REP(NOT ((cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port AND cpu_instruction_master_read)) , 32) OR epcs_flash_controller_epcs_control_port_readdata_from_sa));
  --actual waitrequest port, which is an e_assign
  internal_cpu_instruction_master_waitrequest <= NOT cpu_instruction_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_instruction_master_latency_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      internal_cpu_instruction_master_latency_counter <= p1_cpu_instruction_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_instruction_master_latency_counter <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((cpu_instruction_master_run AND cpu_instruction_master_read))) = '1'), (std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(latency_load_value))), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_latency_counter)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_latency_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  --read latency load values, which is an e_mux
  latency_load_value <= std_logic'('0');
  --dbs count increment, which is an e_mux
  cpu_instruction_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_instruction_master_requests_NiosII_clock_0_in)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000")), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_instruction_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_instruction_master_dbs_address)) + (std_logic_vector'("0") & (cpu_instruction_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_instruction_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_instruction_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_instruction_master_granted_NiosII_clock_0_in AND cpu_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT NiosII_clock_0_in_waitrequest_from_sa)))));
  --vhdl renameroo for output signals
  cpu_instruction_master_address_to_slave <= internal_cpu_instruction_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_instruction_master_dbs_address <= internal_cpu_instruction_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_instruction_master_latency_counter <= internal_cpu_instruction_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_instruction_master_waitrequest <= internal_cpu_instruction_master_waitrequest;
--synthesis translate_off
    --cpu_instruction_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_instruction_master_address_last_time <= std_logic_vector'("000000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
      end if;

    end process;

    --cpu/instruction_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_instruction_master_waitrequest AND (cpu_instruction_master_read);
      end if;

    end process;

    --cpu_instruction_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line22 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_instruction_master_address /= cpu_instruction_master_address_last_time))))) = '1' then 
          write(write_line22, now);
          write(write_line22, string'(": "));
          write(write_line22, string'("cpu_instruction_master_address did not heed wait!!!"));
          write(output, write_line22.all);
          deallocate (write_line22);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_instruction_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_instruction_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
      end if;

    end process;

    --cpu_instruction_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line23 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_instruction_master_read) /= std_logic'(cpu_instruction_master_read_last_time)))))) = '1' then 
          write(write_line23, now);
          write(write_line23, string'(": "));
          write(write_line23, string'("cpu_instruction_master_read did not heed wait!!!"));
          write(output, write_line23.all);
          deallocate (write_line23);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cpu_altera_nios_custom_instr_floating_point_inst_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_done : IN STD_LOGIC;
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_select : IN STD_LOGIC;
                 signal cpu_custom_instruction_master_multi_clk_en : IN STD_LOGIC;
                 signal cpu_custom_instruction_master_multi_dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custom_instruction_master_multi_datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custom_instruction_master_multi_n : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_clk_en : OUT STD_LOGIC;
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_dataa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_datab : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa : OUT STD_LOGIC;
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_reset : OUT STD_LOGIC;
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_altera_nios_custom_instr_floating_point_inst_s1_start : OUT STD_LOGIC
              );
end entity cpu_altera_nios_custom_instr_floating_point_inst_s1_arbitrator;


architecture europa of cpu_altera_nios_custom_instr_floating_point_inst_s1_arbitrator is

begin

  cpu_altera_nios_custom_instr_floating_point_inst_s1_clk_en <= cpu_custom_instruction_master_multi_clk_en;
  cpu_altera_nios_custom_instr_floating_point_inst_s1_dataa <= cpu_custom_instruction_master_multi_dataa;
  cpu_altera_nios_custom_instr_floating_point_inst_s1_datab <= cpu_custom_instruction_master_multi_datab;
  cpu_altera_nios_custom_instr_floating_point_inst_s1_n <= cpu_custom_instruction_master_multi_n (1 DOWNTO 0);
  cpu_altera_nios_custom_instr_floating_point_inst_s1_start <= cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1;
  --assign cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa = cpu_altera_nios_custom_instr_floating_point_inst_s1_result so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa <= cpu_altera_nios_custom_instr_floating_point_inst_s1_result;
  --assign cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa = cpu_altera_nios_custom_instr_floating_point_inst_s1_done so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa <= cpu_altera_nios_custom_instr_floating_point_inst_s1_done;
  --cpu_altera_nios_custom_instr_floating_point_inst/s1 local reset_n, which is an e_assign
  cpu_altera_nios_custom_instr_floating_point_inst_s1_reset <= NOT reset_n;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity data_tx_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal data_tx_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_data_tx_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_data_tx_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_data_tx_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_data_tx_s1 : OUT STD_LOGIC;
                 signal d1_data_tx_s1_end_xfer : OUT STD_LOGIC;
                 signal data_tx_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal data_tx_s1_chipselect : OUT STD_LOGIC;
                 signal data_tx_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal data_tx_s1_reset_n : OUT STD_LOGIC;
                 signal data_tx_s1_write_n : OUT STD_LOGIC;
                 signal data_tx_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity data_tx_s1_arbitrator;


architecture europa of data_tx_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_data_tx_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal data_tx_s1_allgrants :  STD_LOGIC;
                signal data_tx_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal data_tx_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal data_tx_s1_any_continuerequest :  STD_LOGIC;
                signal data_tx_s1_arb_counter_enable :  STD_LOGIC;
                signal data_tx_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal data_tx_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal data_tx_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal data_tx_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal data_tx_s1_begins_xfer :  STD_LOGIC;
                signal data_tx_s1_end_xfer :  STD_LOGIC;
                signal data_tx_s1_firsttransfer :  STD_LOGIC;
                signal data_tx_s1_grant_vector :  STD_LOGIC;
                signal data_tx_s1_in_a_read_cycle :  STD_LOGIC;
                signal data_tx_s1_in_a_write_cycle :  STD_LOGIC;
                signal data_tx_s1_master_qreq_vector :  STD_LOGIC;
                signal data_tx_s1_non_bursting_master_requests :  STD_LOGIC;
                signal data_tx_s1_reg_firsttransfer :  STD_LOGIC;
                signal data_tx_s1_slavearbiterlockenable :  STD_LOGIC;
                signal data_tx_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal data_tx_s1_unreg_firsttransfer :  STD_LOGIC;
                signal data_tx_s1_waits_for_read :  STD_LOGIC;
                signal data_tx_s1_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_data_tx_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_data_tx_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_data_tx_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_data_tx_s1 :  STD_LOGIC;
                signal shifted_address_to_data_tx_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_data_tx_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT data_tx_s1_end_xfer;
    end if;

  end process;

  data_tx_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_data_tx_s1);
  --assign data_tx_s1_readdata_from_sa = data_tx_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  data_tx_s1_readdata_from_sa <= data_tx_s1_readdata;
  internal_cpu_data_master_requests_data_tx_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000111010000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --data_tx_s1_arb_share_counter set values, which is an e_mux
  data_tx_s1_arb_share_set_values <= std_logic_vector'("01");
  --data_tx_s1_non_bursting_master_requests mux, which is an e_mux
  data_tx_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_data_tx_s1;
  --data_tx_s1_any_bursting_master_saved_grant mux, which is an e_mux
  data_tx_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --data_tx_s1_arb_share_counter_next_value assignment, which is an e_assign
  data_tx_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(data_tx_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (data_tx_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(data_tx_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (data_tx_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --data_tx_s1_allgrants all slave grants, which is an e_mux
  data_tx_s1_allgrants <= data_tx_s1_grant_vector;
  --data_tx_s1_end_xfer assignment, which is an e_assign
  data_tx_s1_end_xfer <= NOT ((data_tx_s1_waits_for_read OR data_tx_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_data_tx_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_data_tx_s1 <= data_tx_s1_end_xfer AND (((NOT data_tx_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --data_tx_s1_arb_share_counter arbitration counter enable, which is an e_assign
  data_tx_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_data_tx_s1 AND data_tx_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_data_tx_s1 AND NOT data_tx_s1_non_bursting_master_requests));
  --data_tx_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_tx_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(data_tx_s1_arb_counter_enable) = '1' then 
        data_tx_s1_arb_share_counter <= data_tx_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --data_tx_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_tx_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((data_tx_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_data_tx_s1)) OR ((end_xfer_arb_share_counter_term_data_tx_s1 AND NOT data_tx_s1_non_bursting_master_requests)))) = '1' then 
        data_tx_s1_slavearbiterlockenable <= or_reduce(data_tx_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master data_tx/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= data_tx_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --data_tx_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  data_tx_s1_slavearbiterlockenable2 <= or_reduce(data_tx_s1_arb_share_counter_next_value);
  --cpu/data_master data_tx/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= data_tx_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --data_tx_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  data_tx_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_data_tx_s1 <= internal_cpu_data_master_requests_data_tx_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_data_tx_s1, which is an e_mux
  cpu_data_master_read_data_valid_data_tx_s1 <= (internal_cpu_data_master_granted_data_tx_s1 AND cpu_data_master_read) AND NOT data_tx_s1_waits_for_read;
  --data_tx_s1_writedata mux, which is an e_mux
  data_tx_s1_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_data_tx_s1 <= internal_cpu_data_master_qualified_request_data_tx_s1;
  --cpu/data_master saved-grant data_tx/s1, which is an e_assign
  cpu_data_master_saved_grant_data_tx_s1 <= internal_cpu_data_master_requests_data_tx_s1;
  --allow new arb cycle for data_tx/s1, which is an e_assign
  data_tx_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  data_tx_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  data_tx_s1_master_qreq_vector <= std_logic'('1');
  --data_tx_s1_reset_n assignment, which is an e_assign
  data_tx_s1_reset_n <= reset_n;
  data_tx_s1_chipselect <= internal_cpu_data_master_granted_data_tx_s1;
  --data_tx_s1_firsttransfer first transaction, which is an e_assign
  data_tx_s1_firsttransfer <= A_WE_StdLogic((std_logic'(data_tx_s1_begins_xfer) = '1'), data_tx_s1_unreg_firsttransfer, data_tx_s1_reg_firsttransfer);
  --data_tx_s1_unreg_firsttransfer first transaction, which is an e_assign
  data_tx_s1_unreg_firsttransfer <= NOT ((data_tx_s1_slavearbiterlockenable AND data_tx_s1_any_continuerequest));
  --data_tx_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_tx_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(data_tx_s1_begins_xfer) = '1' then 
        data_tx_s1_reg_firsttransfer <= data_tx_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --data_tx_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  data_tx_s1_beginbursttransfer_internal <= data_tx_s1_begins_xfer;
  --~data_tx_s1_write_n assignment, which is an e_mux
  data_tx_s1_write_n <= NOT ((internal_cpu_data_master_granted_data_tx_s1 AND cpu_data_master_write));
  shifted_address_to_data_tx_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --data_tx_s1_address mux, which is an e_mux
  data_tx_s1_address <= A_EXT (A_SRL(shifted_address_to_data_tx_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_data_tx_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_data_tx_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_data_tx_s1_end_xfer <= data_tx_s1_end_xfer;
    end if;

  end process;

  --data_tx_s1_waits_for_read in a cycle, which is an e_mux
  data_tx_s1_waits_for_read <= data_tx_s1_in_a_read_cycle AND data_tx_s1_begins_xfer;
  --data_tx_s1_in_a_read_cycle assignment, which is an e_assign
  data_tx_s1_in_a_read_cycle <= internal_cpu_data_master_granted_data_tx_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= data_tx_s1_in_a_read_cycle;
  --data_tx_s1_waits_for_write in a cycle, which is an e_mux
  data_tx_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(data_tx_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --data_tx_s1_in_a_write_cycle assignment, which is an e_assign
  data_tx_s1_in_a_write_cycle <= internal_cpu_data_master_granted_data_tx_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= data_tx_s1_in_a_write_cycle;
  wait_for_data_tx_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_data_tx_s1 <= internal_cpu_data_master_granted_data_tx_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_data_tx_s1 <= internal_cpu_data_master_qualified_request_data_tx_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_data_tx_s1 <= internal_cpu_data_master_requests_data_tx_s1;
--synthesis translate_off
    --data_tx/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity duty_1_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal duty_1_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_duty_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_duty_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_duty_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_duty_1_s1 : OUT STD_LOGIC;
                 signal d1_duty_1_s1_end_xfer : OUT STD_LOGIC;
                 signal duty_1_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal duty_1_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal duty_1_s1_reset_n : OUT STD_LOGIC
              );
end entity duty_1_s1_arbitrator;


architecture europa of duty_1_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_duty_1_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal duty_1_s1_allgrants :  STD_LOGIC;
                signal duty_1_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal duty_1_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal duty_1_s1_any_continuerequest :  STD_LOGIC;
                signal duty_1_s1_arb_counter_enable :  STD_LOGIC;
                signal duty_1_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_1_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_1_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_1_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal duty_1_s1_begins_xfer :  STD_LOGIC;
                signal duty_1_s1_end_xfer :  STD_LOGIC;
                signal duty_1_s1_firsttransfer :  STD_LOGIC;
                signal duty_1_s1_grant_vector :  STD_LOGIC;
                signal duty_1_s1_in_a_read_cycle :  STD_LOGIC;
                signal duty_1_s1_in_a_write_cycle :  STD_LOGIC;
                signal duty_1_s1_master_qreq_vector :  STD_LOGIC;
                signal duty_1_s1_non_bursting_master_requests :  STD_LOGIC;
                signal duty_1_s1_reg_firsttransfer :  STD_LOGIC;
                signal duty_1_s1_slavearbiterlockenable :  STD_LOGIC;
                signal duty_1_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal duty_1_s1_unreg_firsttransfer :  STD_LOGIC;
                signal duty_1_s1_waits_for_read :  STD_LOGIC;
                signal duty_1_s1_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_duty_1_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_duty_1_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_duty_1_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_duty_1_s1 :  STD_LOGIC;
                signal shifted_address_to_duty_1_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_duty_1_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT duty_1_s1_end_xfer;
    end if;

  end process;

  duty_1_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_duty_1_s1);
  --assign duty_1_s1_readdata_from_sa = duty_1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  duty_1_s1_readdata_from_sa <= duty_1_s1_readdata;
  internal_cpu_data_master_requests_duty_1_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000110010000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --duty_1_s1_arb_share_counter set values, which is an e_mux
  duty_1_s1_arb_share_set_values <= std_logic_vector'("01");
  --duty_1_s1_non_bursting_master_requests mux, which is an e_mux
  duty_1_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_duty_1_s1;
  --duty_1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  duty_1_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --duty_1_s1_arb_share_counter_next_value assignment, which is an e_assign
  duty_1_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(duty_1_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (duty_1_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(duty_1_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (duty_1_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --duty_1_s1_allgrants all slave grants, which is an e_mux
  duty_1_s1_allgrants <= duty_1_s1_grant_vector;
  --duty_1_s1_end_xfer assignment, which is an e_assign
  duty_1_s1_end_xfer <= NOT ((duty_1_s1_waits_for_read OR duty_1_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_duty_1_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_duty_1_s1 <= duty_1_s1_end_xfer AND (((NOT duty_1_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --duty_1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  duty_1_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_duty_1_s1 AND duty_1_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_duty_1_s1 AND NOT duty_1_s1_non_bursting_master_requests));
  --duty_1_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_1_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(duty_1_s1_arb_counter_enable) = '1' then 
        duty_1_s1_arb_share_counter <= duty_1_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --duty_1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_1_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((duty_1_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_duty_1_s1)) OR ((end_xfer_arb_share_counter_term_duty_1_s1 AND NOT duty_1_s1_non_bursting_master_requests)))) = '1' then 
        duty_1_s1_slavearbiterlockenable <= or_reduce(duty_1_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master duty_1/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= duty_1_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --duty_1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  duty_1_s1_slavearbiterlockenable2 <= or_reduce(duty_1_s1_arb_share_counter_next_value);
  --cpu/data_master duty_1/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= duty_1_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --duty_1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  duty_1_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_duty_1_s1 <= internal_cpu_data_master_requests_duty_1_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_duty_1_s1, which is an e_mux
  cpu_data_master_read_data_valid_duty_1_s1 <= (internal_cpu_data_master_granted_duty_1_s1 AND cpu_data_master_read) AND NOT duty_1_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_duty_1_s1 <= internal_cpu_data_master_qualified_request_duty_1_s1;
  --cpu/data_master saved-grant duty_1/s1, which is an e_assign
  cpu_data_master_saved_grant_duty_1_s1 <= internal_cpu_data_master_requests_duty_1_s1;
  --allow new arb cycle for duty_1/s1, which is an e_assign
  duty_1_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  duty_1_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  duty_1_s1_master_qreq_vector <= std_logic'('1');
  --duty_1_s1_reset_n assignment, which is an e_assign
  duty_1_s1_reset_n <= reset_n;
  --duty_1_s1_firsttransfer first transaction, which is an e_assign
  duty_1_s1_firsttransfer <= A_WE_StdLogic((std_logic'(duty_1_s1_begins_xfer) = '1'), duty_1_s1_unreg_firsttransfer, duty_1_s1_reg_firsttransfer);
  --duty_1_s1_unreg_firsttransfer first transaction, which is an e_assign
  duty_1_s1_unreg_firsttransfer <= NOT ((duty_1_s1_slavearbiterlockenable AND duty_1_s1_any_continuerequest));
  --duty_1_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_1_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(duty_1_s1_begins_xfer) = '1' then 
        duty_1_s1_reg_firsttransfer <= duty_1_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --duty_1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  duty_1_s1_beginbursttransfer_internal <= duty_1_s1_begins_xfer;
  shifted_address_to_duty_1_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --duty_1_s1_address mux, which is an e_mux
  duty_1_s1_address <= A_EXT (A_SRL(shifted_address_to_duty_1_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_duty_1_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_duty_1_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_duty_1_s1_end_xfer <= duty_1_s1_end_xfer;
    end if;

  end process;

  --duty_1_s1_waits_for_read in a cycle, which is an e_mux
  duty_1_s1_waits_for_read <= duty_1_s1_in_a_read_cycle AND duty_1_s1_begins_xfer;
  --duty_1_s1_in_a_read_cycle assignment, which is an e_assign
  duty_1_s1_in_a_read_cycle <= internal_cpu_data_master_granted_duty_1_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= duty_1_s1_in_a_read_cycle;
  --duty_1_s1_waits_for_write in a cycle, which is an e_mux
  duty_1_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(duty_1_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --duty_1_s1_in_a_write_cycle assignment, which is an e_assign
  duty_1_s1_in_a_write_cycle <= internal_cpu_data_master_granted_duty_1_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= duty_1_s1_in_a_write_cycle;
  wait_for_duty_1_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_duty_1_s1 <= internal_cpu_data_master_granted_duty_1_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_duty_1_s1 <= internal_cpu_data_master_qualified_request_duty_1_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_duty_1_s1 <= internal_cpu_data_master_requests_duty_1_s1;
--synthesis translate_off
    --duty_1/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity duty_2_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal duty_2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_duty_2_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_duty_2_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_duty_2_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_duty_2_s1 : OUT STD_LOGIC;
                 signal d1_duty_2_s1_end_xfer : OUT STD_LOGIC;
                 signal duty_2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal duty_2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal duty_2_s1_reset_n : OUT STD_LOGIC
              );
end entity duty_2_s1_arbitrator;


architecture europa of duty_2_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_duty_2_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal duty_2_s1_allgrants :  STD_LOGIC;
                signal duty_2_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal duty_2_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal duty_2_s1_any_continuerequest :  STD_LOGIC;
                signal duty_2_s1_arb_counter_enable :  STD_LOGIC;
                signal duty_2_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_2_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_2_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_2_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal duty_2_s1_begins_xfer :  STD_LOGIC;
                signal duty_2_s1_end_xfer :  STD_LOGIC;
                signal duty_2_s1_firsttransfer :  STD_LOGIC;
                signal duty_2_s1_grant_vector :  STD_LOGIC;
                signal duty_2_s1_in_a_read_cycle :  STD_LOGIC;
                signal duty_2_s1_in_a_write_cycle :  STD_LOGIC;
                signal duty_2_s1_master_qreq_vector :  STD_LOGIC;
                signal duty_2_s1_non_bursting_master_requests :  STD_LOGIC;
                signal duty_2_s1_reg_firsttransfer :  STD_LOGIC;
                signal duty_2_s1_slavearbiterlockenable :  STD_LOGIC;
                signal duty_2_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal duty_2_s1_unreg_firsttransfer :  STD_LOGIC;
                signal duty_2_s1_waits_for_read :  STD_LOGIC;
                signal duty_2_s1_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_duty_2_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_duty_2_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_duty_2_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_duty_2_s1 :  STD_LOGIC;
                signal shifted_address_to_duty_2_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_duty_2_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT duty_2_s1_end_xfer;
    end if;

  end process;

  duty_2_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_duty_2_s1);
  --assign duty_2_s1_readdata_from_sa = duty_2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  duty_2_s1_readdata_from_sa <= duty_2_s1_readdata;
  internal_cpu_data_master_requests_duty_2_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000110100000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --duty_2_s1_arb_share_counter set values, which is an e_mux
  duty_2_s1_arb_share_set_values <= std_logic_vector'("01");
  --duty_2_s1_non_bursting_master_requests mux, which is an e_mux
  duty_2_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_duty_2_s1;
  --duty_2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  duty_2_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --duty_2_s1_arb_share_counter_next_value assignment, which is an e_assign
  duty_2_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(duty_2_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (duty_2_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(duty_2_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (duty_2_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --duty_2_s1_allgrants all slave grants, which is an e_mux
  duty_2_s1_allgrants <= duty_2_s1_grant_vector;
  --duty_2_s1_end_xfer assignment, which is an e_assign
  duty_2_s1_end_xfer <= NOT ((duty_2_s1_waits_for_read OR duty_2_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_duty_2_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_duty_2_s1 <= duty_2_s1_end_xfer AND (((NOT duty_2_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --duty_2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  duty_2_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_duty_2_s1 AND duty_2_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_duty_2_s1 AND NOT duty_2_s1_non_bursting_master_requests));
  --duty_2_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_2_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(duty_2_s1_arb_counter_enable) = '1' then 
        duty_2_s1_arb_share_counter <= duty_2_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --duty_2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_2_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((duty_2_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_duty_2_s1)) OR ((end_xfer_arb_share_counter_term_duty_2_s1 AND NOT duty_2_s1_non_bursting_master_requests)))) = '1' then 
        duty_2_s1_slavearbiterlockenable <= or_reduce(duty_2_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master duty_2/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= duty_2_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --duty_2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  duty_2_s1_slavearbiterlockenable2 <= or_reduce(duty_2_s1_arb_share_counter_next_value);
  --cpu/data_master duty_2/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= duty_2_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --duty_2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  duty_2_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_duty_2_s1 <= internal_cpu_data_master_requests_duty_2_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_duty_2_s1, which is an e_mux
  cpu_data_master_read_data_valid_duty_2_s1 <= (internal_cpu_data_master_granted_duty_2_s1 AND cpu_data_master_read) AND NOT duty_2_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_duty_2_s1 <= internal_cpu_data_master_qualified_request_duty_2_s1;
  --cpu/data_master saved-grant duty_2/s1, which is an e_assign
  cpu_data_master_saved_grant_duty_2_s1 <= internal_cpu_data_master_requests_duty_2_s1;
  --allow new arb cycle for duty_2/s1, which is an e_assign
  duty_2_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  duty_2_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  duty_2_s1_master_qreq_vector <= std_logic'('1');
  --duty_2_s1_reset_n assignment, which is an e_assign
  duty_2_s1_reset_n <= reset_n;
  --duty_2_s1_firsttransfer first transaction, which is an e_assign
  duty_2_s1_firsttransfer <= A_WE_StdLogic((std_logic'(duty_2_s1_begins_xfer) = '1'), duty_2_s1_unreg_firsttransfer, duty_2_s1_reg_firsttransfer);
  --duty_2_s1_unreg_firsttransfer first transaction, which is an e_assign
  duty_2_s1_unreg_firsttransfer <= NOT ((duty_2_s1_slavearbiterlockenable AND duty_2_s1_any_continuerequest));
  --duty_2_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_2_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(duty_2_s1_begins_xfer) = '1' then 
        duty_2_s1_reg_firsttransfer <= duty_2_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --duty_2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  duty_2_s1_beginbursttransfer_internal <= duty_2_s1_begins_xfer;
  shifted_address_to_duty_2_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --duty_2_s1_address mux, which is an e_mux
  duty_2_s1_address <= A_EXT (A_SRL(shifted_address_to_duty_2_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_duty_2_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_duty_2_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_duty_2_s1_end_xfer <= duty_2_s1_end_xfer;
    end if;

  end process;

  --duty_2_s1_waits_for_read in a cycle, which is an e_mux
  duty_2_s1_waits_for_read <= duty_2_s1_in_a_read_cycle AND duty_2_s1_begins_xfer;
  --duty_2_s1_in_a_read_cycle assignment, which is an e_assign
  duty_2_s1_in_a_read_cycle <= internal_cpu_data_master_granted_duty_2_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= duty_2_s1_in_a_read_cycle;
  --duty_2_s1_waits_for_write in a cycle, which is an e_mux
  duty_2_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(duty_2_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --duty_2_s1_in_a_write_cycle assignment, which is an e_assign
  duty_2_s1_in_a_write_cycle <= internal_cpu_data_master_granted_duty_2_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= duty_2_s1_in_a_write_cycle;
  wait_for_duty_2_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_duty_2_s1 <= internal_cpu_data_master_granted_duty_2_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_duty_2_s1 <= internal_cpu_data_master_qualified_request_duty_2_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_duty_2_s1 <= internal_cpu_data_master_requests_duty_2_s1;
--synthesis translate_off
    --duty_2/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity duty_3_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal duty_3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_duty_3_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_duty_3_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_duty_3_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_duty_3_s1 : OUT STD_LOGIC;
                 signal d1_duty_3_s1_end_xfer : OUT STD_LOGIC;
                 signal duty_3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal duty_3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal duty_3_s1_reset_n : OUT STD_LOGIC
              );
end entity duty_3_s1_arbitrator;


architecture europa of duty_3_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_duty_3_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal duty_3_s1_allgrants :  STD_LOGIC;
                signal duty_3_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal duty_3_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal duty_3_s1_any_continuerequest :  STD_LOGIC;
                signal duty_3_s1_arb_counter_enable :  STD_LOGIC;
                signal duty_3_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_3_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_3_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_3_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal duty_3_s1_begins_xfer :  STD_LOGIC;
                signal duty_3_s1_end_xfer :  STD_LOGIC;
                signal duty_3_s1_firsttransfer :  STD_LOGIC;
                signal duty_3_s1_grant_vector :  STD_LOGIC;
                signal duty_3_s1_in_a_read_cycle :  STD_LOGIC;
                signal duty_3_s1_in_a_write_cycle :  STD_LOGIC;
                signal duty_3_s1_master_qreq_vector :  STD_LOGIC;
                signal duty_3_s1_non_bursting_master_requests :  STD_LOGIC;
                signal duty_3_s1_reg_firsttransfer :  STD_LOGIC;
                signal duty_3_s1_slavearbiterlockenable :  STD_LOGIC;
                signal duty_3_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal duty_3_s1_unreg_firsttransfer :  STD_LOGIC;
                signal duty_3_s1_waits_for_read :  STD_LOGIC;
                signal duty_3_s1_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_duty_3_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_duty_3_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_duty_3_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_duty_3_s1 :  STD_LOGIC;
                signal shifted_address_to_duty_3_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_duty_3_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT duty_3_s1_end_xfer;
    end if;

  end process;

  duty_3_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_duty_3_s1);
  --assign duty_3_s1_readdata_from_sa = duty_3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  duty_3_s1_readdata_from_sa <= duty_3_s1_readdata;
  internal_cpu_data_master_requests_duty_3_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000110110000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --duty_3_s1_arb_share_counter set values, which is an e_mux
  duty_3_s1_arb_share_set_values <= std_logic_vector'("01");
  --duty_3_s1_non_bursting_master_requests mux, which is an e_mux
  duty_3_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_duty_3_s1;
  --duty_3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  duty_3_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --duty_3_s1_arb_share_counter_next_value assignment, which is an e_assign
  duty_3_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(duty_3_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (duty_3_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(duty_3_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (duty_3_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --duty_3_s1_allgrants all slave grants, which is an e_mux
  duty_3_s1_allgrants <= duty_3_s1_grant_vector;
  --duty_3_s1_end_xfer assignment, which is an e_assign
  duty_3_s1_end_xfer <= NOT ((duty_3_s1_waits_for_read OR duty_3_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_duty_3_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_duty_3_s1 <= duty_3_s1_end_xfer AND (((NOT duty_3_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --duty_3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  duty_3_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_duty_3_s1 AND duty_3_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_duty_3_s1 AND NOT duty_3_s1_non_bursting_master_requests));
  --duty_3_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_3_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(duty_3_s1_arb_counter_enable) = '1' then 
        duty_3_s1_arb_share_counter <= duty_3_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --duty_3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_3_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((duty_3_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_duty_3_s1)) OR ((end_xfer_arb_share_counter_term_duty_3_s1 AND NOT duty_3_s1_non_bursting_master_requests)))) = '1' then 
        duty_3_s1_slavearbiterlockenable <= or_reduce(duty_3_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master duty_3/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= duty_3_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --duty_3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  duty_3_s1_slavearbiterlockenable2 <= or_reduce(duty_3_s1_arb_share_counter_next_value);
  --cpu/data_master duty_3/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= duty_3_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --duty_3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  duty_3_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_duty_3_s1 <= internal_cpu_data_master_requests_duty_3_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_duty_3_s1, which is an e_mux
  cpu_data_master_read_data_valid_duty_3_s1 <= (internal_cpu_data_master_granted_duty_3_s1 AND cpu_data_master_read) AND NOT duty_3_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_duty_3_s1 <= internal_cpu_data_master_qualified_request_duty_3_s1;
  --cpu/data_master saved-grant duty_3/s1, which is an e_assign
  cpu_data_master_saved_grant_duty_3_s1 <= internal_cpu_data_master_requests_duty_3_s1;
  --allow new arb cycle for duty_3/s1, which is an e_assign
  duty_3_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  duty_3_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  duty_3_s1_master_qreq_vector <= std_logic'('1');
  --duty_3_s1_reset_n assignment, which is an e_assign
  duty_3_s1_reset_n <= reset_n;
  --duty_3_s1_firsttransfer first transaction, which is an e_assign
  duty_3_s1_firsttransfer <= A_WE_StdLogic((std_logic'(duty_3_s1_begins_xfer) = '1'), duty_3_s1_unreg_firsttransfer, duty_3_s1_reg_firsttransfer);
  --duty_3_s1_unreg_firsttransfer first transaction, which is an e_assign
  duty_3_s1_unreg_firsttransfer <= NOT ((duty_3_s1_slavearbiterlockenable AND duty_3_s1_any_continuerequest));
  --duty_3_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_3_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(duty_3_s1_begins_xfer) = '1' then 
        duty_3_s1_reg_firsttransfer <= duty_3_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --duty_3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  duty_3_s1_beginbursttransfer_internal <= duty_3_s1_begins_xfer;
  shifted_address_to_duty_3_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --duty_3_s1_address mux, which is an e_mux
  duty_3_s1_address <= A_EXT (A_SRL(shifted_address_to_duty_3_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_duty_3_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_duty_3_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_duty_3_s1_end_xfer <= duty_3_s1_end_xfer;
    end if;

  end process;

  --duty_3_s1_waits_for_read in a cycle, which is an e_mux
  duty_3_s1_waits_for_read <= duty_3_s1_in_a_read_cycle AND duty_3_s1_begins_xfer;
  --duty_3_s1_in_a_read_cycle assignment, which is an e_assign
  duty_3_s1_in_a_read_cycle <= internal_cpu_data_master_granted_duty_3_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= duty_3_s1_in_a_read_cycle;
  --duty_3_s1_waits_for_write in a cycle, which is an e_mux
  duty_3_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(duty_3_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --duty_3_s1_in_a_write_cycle assignment, which is an e_assign
  duty_3_s1_in_a_write_cycle <= internal_cpu_data_master_granted_duty_3_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= duty_3_s1_in_a_write_cycle;
  wait_for_duty_3_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_duty_3_s1 <= internal_cpu_data_master_granted_duty_3_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_duty_3_s1 <= internal_cpu_data_master_qualified_request_duty_3_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_duty_3_s1 <= internal_cpu_data_master_requests_duty_3_s1;
--synthesis translate_off
    --duty_3/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity duty_4_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal duty_4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_duty_4_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_duty_4_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_duty_4_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_duty_4_s1 : OUT STD_LOGIC;
                 signal d1_duty_4_s1_end_xfer : OUT STD_LOGIC;
                 signal duty_4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal duty_4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal duty_4_s1_reset_n : OUT STD_LOGIC
              );
end entity duty_4_s1_arbitrator;


architecture europa of duty_4_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_duty_4_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal duty_4_s1_allgrants :  STD_LOGIC;
                signal duty_4_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal duty_4_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal duty_4_s1_any_continuerequest :  STD_LOGIC;
                signal duty_4_s1_arb_counter_enable :  STD_LOGIC;
                signal duty_4_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_4_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_4_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_4_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal duty_4_s1_begins_xfer :  STD_LOGIC;
                signal duty_4_s1_end_xfer :  STD_LOGIC;
                signal duty_4_s1_firsttransfer :  STD_LOGIC;
                signal duty_4_s1_grant_vector :  STD_LOGIC;
                signal duty_4_s1_in_a_read_cycle :  STD_LOGIC;
                signal duty_4_s1_in_a_write_cycle :  STD_LOGIC;
                signal duty_4_s1_master_qreq_vector :  STD_LOGIC;
                signal duty_4_s1_non_bursting_master_requests :  STD_LOGIC;
                signal duty_4_s1_reg_firsttransfer :  STD_LOGIC;
                signal duty_4_s1_slavearbiterlockenable :  STD_LOGIC;
                signal duty_4_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal duty_4_s1_unreg_firsttransfer :  STD_LOGIC;
                signal duty_4_s1_waits_for_read :  STD_LOGIC;
                signal duty_4_s1_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_duty_4_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_duty_4_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_duty_4_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_duty_4_s1 :  STD_LOGIC;
                signal shifted_address_to_duty_4_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_duty_4_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT duty_4_s1_end_xfer;
    end if;

  end process;

  duty_4_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_duty_4_s1);
  --assign duty_4_s1_readdata_from_sa = duty_4_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  duty_4_s1_readdata_from_sa <= duty_4_s1_readdata;
  internal_cpu_data_master_requests_duty_4_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000111000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --duty_4_s1_arb_share_counter set values, which is an e_mux
  duty_4_s1_arb_share_set_values <= std_logic_vector'("01");
  --duty_4_s1_non_bursting_master_requests mux, which is an e_mux
  duty_4_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_duty_4_s1;
  --duty_4_s1_any_bursting_master_saved_grant mux, which is an e_mux
  duty_4_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --duty_4_s1_arb_share_counter_next_value assignment, which is an e_assign
  duty_4_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(duty_4_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (duty_4_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(duty_4_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (duty_4_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --duty_4_s1_allgrants all slave grants, which is an e_mux
  duty_4_s1_allgrants <= duty_4_s1_grant_vector;
  --duty_4_s1_end_xfer assignment, which is an e_assign
  duty_4_s1_end_xfer <= NOT ((duty_4_s1_waits_for_read OR duty_4_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_duty_4_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_duty_4_s1 <= duty_4_s1_end_xfer AND (((NOT duty_4_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --duty_4_s1_arb_share_counter arbitration counter enable, which is an e_assign
  duty_4_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_duty_4_s1 AND duty_4_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_duty_4_s1 AND NOT duty_4_s1_non_bursting_master_requests));
  --duty_4_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_4_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(duty_4_s1_arb_counter_enable) = '1' then 
        duty_4_s1_arb_share_counter <= duty_4_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --duty_4_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_4_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((duty_4_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_duty_4_s1)) OR ((end_xfer_arb_share_counter_term_duty_4_s1 AND NOT duty_4_s1_non_bursting_master_requests)))) = '1' then 
        duty_4_s1_slavearbiterlockenable <= or_reduce(duty_4_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master duty_4/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= duty_4_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --duty_4_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  duty_4_s1_slavearbiterlockenable2 <= or_reduce(duty_4_s1_arb_share_counter_next_value);
  --cpu/data_master duty_4/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= duty_4_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --duty_4_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  duty_4_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_duty_4_s1 <= internal_cpu_data_master_requests_duty_4_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_duty_4_s1, which is an e_mux
  cpu_data_master_read_data_valid_duty_4_s1 <= (internal_cpu_data_master_granted_duty_4_s1 AND cpu_data_master_read) AND NOT duty_4_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_duty_4_s1 <= internal_cpu_data_master_qualified_request_duty_4_s1;
  --cpu/data_master saved-grant duty_4/s1, which is an e_assign
  cpu_data_master_saved_grant_duty_4_s1 <= internal_cpu_data_master_requests_duty_4_s1;
  --allow new arb cycle for duty_4/s1, which is an e_assign
  duty_4_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  duty_4_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  duty_4_s1_master_qreq_vector <= std_logic'('1');
  --duty_4_s1_reset_n assignment, which is an e_assign
  duty_4_s1_reset_n <= reset_n;
  --duty_4_s1_firsttransfer first transaction, which is an e_assign
  duty_4_s1_firsttransfer <= A_WE_StdLogic((std_logic'(duty_4_s1_begins_xfer) = '1'), duty_4_s1_unreg_firsttransfer, duty_4_s1_reg_firsttransfer);
  --duty_4_s1_unreg_firsttransfer first transaction, which is an e_assign
  duty_4_s1_unreg_firsttransfer <= NOT ((duty_4_s1_slavearbiterlockenable AND duty_4_s1_any_continuerequest));
  --duty_4_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      duty_4_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(duty_4_s1_begins_xfer) = '1' then 
        duty_4_s1_reg_firsttransfer <= duty_4_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --duty_4_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  duty_4_s1_beginbursttransfer_internal <= duty_4_s1_begins_xfer;
  shifted_address_to_duty_4_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --duty_4_s1_address mux, which is an e_mux
  duty_4_s1_address <= A_EXT (A_SRL(shifted_address_to_duty_4_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_duty_4_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_duty_4_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_duty_4_s1_end_xfer <= duty_4_s1_end_xfer;
    end if;

  end process;

  --duty_4_s1_waits_for_read in a cycle, which is an e_mux
  duty_4_s1_waits_for_read <= duty_4_s1_in_a_read_cycle AND duty_4_s1_begins_xfer;
  --duty_4_s1_in_a_read_cycle assignment, which is an e_assign
  duty_4_s1_in_a_read_cycle <= internal_cpu_data_master_granted_duty_4_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= duty_4_s1_in_a_read_cycle;
  --duty_4_s1_waits_for_write in a cycle, which is an e_mux
  duty_4_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(duty_4_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --duty_4_s1_in_a_write_cycle assignment, which is an e_assign
  duty_4_s1_in_a_write_cycle <= internal_cpu_data_master_granted_duty_4_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= duty_4_s1_in_a_write_cycle;
  wait_for_duty_4_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_duty_4_s1 <= internal_cpu_data_master_granted_duty_4_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_duty_4_s1 <= internal_cpu_data_master_qualified_request_duty_4_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_duty_4_s1 <= internal_cpu_data_master_requests_duty_4_s1;
--synthesis translate_off
    --duty_4/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_ac_eje_X_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_ac_eje_X_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_ac_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ac_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ac_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ac_eje_X_s1 : OUT STD_LOGIC;
                 signal d1_entrada_ac_eje_X_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_ac_eje_X_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_ac_eje_X_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ac_eje_X_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_ac_eje_X_s1_arbitrator;


architecture europa of entrada_ac_eje_X_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_allgrants :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_X_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_X_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_X_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_begins_xfer :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_end_xfer :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_grant_vector :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_waits_for_read :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_ac_eje_X_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_ac_eje_X_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_ac_eje_X_s1_end_xfer;
    end if;

  end process;

  entrada_ac_eje_X_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_ac_eje_X_s1);
  --assign entrada_ac_eje_X_s1_readdata_from_sa = entrada_ac_eje_X_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_ac_eje_X_s1_readdata_from_sa <= entrada_ac_eje_X_s1_readdata;
  internal_cpu_data_master_requests_entrada_ac_eje_X_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000010110000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_ac_eje_X_s1_arb_share_counter set values, which is an e_mux
  entrada_ac_eje_X_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_ac_eje_X_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_ac_eje_X_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_ac_eje_X_s1;
  --entrada_ac_eje_X_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_ac_eje_X_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_ac_eje_X_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_ac_eje_X_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_ac_eje_X_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ac_eje_X_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_ac_eje_X_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ac_eje_X_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_ac_eje_X_s1_allgrants all slave grants, which is an e_mux
  entrada_ac_eje_X_s1_allgrants <= entrada_ac_eje_X_s1_grant_vector;
  --entrada_ac_eje_X_s1_end_xfer assignment, which is an e_assign
  entrada_ac_eje_X_s1_end_xfer <= NOT ((entrada_ac_eje_X_s1_waits_for_read OR entrada_ac_eje_X_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_ac_eje_X_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_ac_eje_X_s1 <= entrada_ac_eje_X_s1_end_xfer AND (((NOT entrada_ac_eje_X_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_ac_eje_X_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_ac_eje_X_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_ac_eje_X_s1 AND entrada_ac_eje_X_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_ac_eje_X_s1 AND NOT entrada_ac_eje_X_s1_non_bursting_master_requests));
  --entrada_ac_eje_X_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_X_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ac_eje_X_s1_arb_counter_enable) = '1' then 
        entrada_ac_eje_X_s1_arb_share_counter <= entrada_ac_eje_X_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_ac_eje_X_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_X_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_ac_eje_X_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_ac_eje_X_s1)) OR ((end_xfer_arb_share_counter_term_entrada_ac_eje_X_s1 AND NOT entrada_ac_eje_X_s1_non_bursting_master_requests)))) = '1' then 
        entrada_ac_eje_X_s1_slavearbiterlockenable <= or_reduce(entrada_ac_eje_X_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_ac_eje_X/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_ac_eje_X_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_ac_eje_X_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_ac_eje_X_s1_slavearbiterlockenable2 <= or_reduce(entrada_ac_eje_X_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_ac_eje_X/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_ac_eje_X_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_ac_eje_X_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_ac_eje_X_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_ac_eje_X_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_X_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_ac_eje_X_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_ac_eje_X_s1 <= (internal_cpu_data_master_granted_entrada_ac_eje_X_s1 AND cpu_data_master_read) AND NOT entrada_ac_eje_X_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_ac_eje_X_s1 <= internal_cpu_data_master_qualified_request_entrada_ac_eje_X_s1;
  --cpu/data_master saved-grant entrada_ac_eje_X/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_ac_eje_X_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_X_s1;
  --allow new arb cycle for entrada_ac_eje_X/s1, which is an e_assign
  entrada_ac_eje_X_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_ac_eje_X_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_ac_eje_X_s1_master_qreq_vector <= std_logic'('1');
  --entrada_ac_eje_X_s1_reset_n assignment, which is an e_assign
  entrada_ac_eje_X_s1_reset_n <= reset_n;
  --entrada_ac_eje_X_s1_firsttransfer first transaction, which is an e_assign
  entrada_ac_eje_X_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_ac_eje_X_s1_begins_xfer) = '1'), entrada_ac_eje_X_s1_unreg_firsttransfer, entrada_ac_eje_X_s1_reg_firsttransfer);
  --entrada_ac_eje_X_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_ac_eje_X_s1_unreg_firsttransfer <= NOT ((entrada_ac_eje_X_s1_slavearbiterlockenable AND entrada_ac_eje_X_s1_any_continuerequest));
  --entrada_ac_eje_X_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_X_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ac_eje_X_s1_begins_xfer) = '1' then 
        entrada_ac_eje_X_s1_reg_firsttransfer <= entrada_ac_eje_X_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_ac_eje_X_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_ac_eje_X_s1_beginbursttransfer_internal <= entrada_ac_eje_X_s1_begins_xfer;
  shifted_address_to_entrada_ac_eje_X_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_ac_eje_X_s1_address mux, which is an e_mux
  entrada_ac_eje_X_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_ac_eje_X_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_ac_eje_X_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_ac_eje_X_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_ac_eje_X_s1_end_xfer <= entrada_ac_eje_X_s1_end_xfer;
    end if;

  end process;

  --entrada_ac_eje_X_s1_waits_for_read in a cycle, which is an e_mux
  entrada_ac_eje_X_s1_waits_for_read <= entrada_ac_eje_X_s1_in_a_read_cycle AND entrada_ac_eje_X_s1_begins_xfer;
  --entrada_ac_eje_X_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_ac_eje_X_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_ac_eje_X_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_ac_eje_X_s1_in_a_read_cycle;
  --entrada_ac_eje_X_s1_waits_for_write in a cycle, which is an e_mux
  entrada_ac_eje_X_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_ac_eje_X_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_ac_eje_X_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_ac_eje_X_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_ac_eje_X_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_ac_eje_X_s1_in_a_write_cycle;
  wait_for_entrada_ac_eje_X_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_ac_eje_X_s1 <= internal_cpu_data_master_granted_entrada_ac_eje_X_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_ac_eje_X_s1 <= internal_cpu_data_master_qualified_request_entrada_ac_eje_X_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_ac_eje_X_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_X_s1;
--synthesis translate_off
    --entrada_ac_eje_X/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_ac_eje_Y_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_ac_eje_Y_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_ac_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ac_eje_Y_s1 : OUT STD_LOGIC;
                 signal d1_entrada_ac_eje_Y_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_ac_eje_Y_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_ac_eje_Y_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ac_eje_Y_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_ac_eje_Y_s1_arbitrator;


architecture europa of entrada_ac_eje_Y_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_allgrants :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_Y_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_Y_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_Y_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_begins_xfer :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_end_xfer :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_grant_vector :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_waits_for_read :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_ac_eje_Y_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_ac_eje_Y_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_ac_eje_Y_s1_end_xfer;
    end if;

  end process;

  entrada_ac_eje_Y_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_ac_eje_Y_s1);
  --assign entrada_ac_eje_Y_s1_readdata_from_sa = entrada_ac_eje_Y_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_ac_eje_Y_s1_readdata_from_sa <= entrada_ac_eje_Y_s1_readdata;
  internal_cpu_data_master_requests_entrada_ac_eje_Y_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000011000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_ac_eje_Y_s1_arb_share_counter set values, which is an e_mux
  entrada_ac_eje_Y_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_ac_eje_Y_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_ac_eje_Y_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_ac_eje_Y_s1;
  --entrada_ac_eje_Y_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_ac_eje_Y_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_ac_eje_Y_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_ac_eje_Y_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_ac_eje_Y_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ac_eje_Y_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_ac_eje_Y_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ac_eje_Y_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_ac_eje_Y_s1_allgrants all slave grants, which is an e_mux
  entrada_ac_eje_Y_s1_allgrants <= entrada_ac_eje_Y_s1_grant_vector;
  --entrada_ac_eje_Y_s1_end_xfer assignment, which is an e_assign
  entrada_ac_eje_Y_s1_end_xfer <= NOT ((entrada_ac_eje_Y_s1_waits_for_read OR entrada_ac_eje_Y_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_ac_eje_Y_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_ac_eje_Y_s1 <= entrada_ac_eje_Y_s1_end_xfer AND (((NOT entrada_ac_eje_Y_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_ac_eje_Y_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_ac_eje_Y_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_ac_eje_Y_s1 AND entrada_ac_eje_Y_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_ac_eje_Y_s1 AND NOT entrada_ac_eje_Y_s1_non_bursting_master_requests));
  --entrada_ac_eje_Y_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_Y_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ac_eje_Y_s1_arb_counter_enable) = '1' then 
        entrada_ac_eje_Y_s1_arb_share_counter <= entrada_ac_eje_Y_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_ac_eje_Y_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_Y_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_ac_eje_Y_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_ac_eje_Y_s1)) OR ((end_xfer_arb_share_counter_term_entrada_ac_eje_Y_s1 AND NOT entrada_ac_eje_Y_s1_non_bursting_master_requests)))) = '1' then 
        entrada_ac_eje_Y_s1_slavearbiterlockenable <= or_reduce(entrada_ac_eje_Y_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_ac_eje_Y/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_ac_eje_Y_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_ac_eje_Y_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_ac_eje_Y_s1_slavearbiterlockenable2 <= or_reduce(entrada_ac_eje_Y_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_ac_eje_Y/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_ac_eje_Y_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_ac_eje_Y_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_ac_eje_Y_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_Y_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1 <= (internal_cpu_data_master_granted_entrada_ac_eje_Y_s1 AND cpu_data_master_read) AND NOT entrada_ac_eje_Y_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_ac_eje_Y_s1 <= internal_cpu_data_master_qualified_request_entrada_ac_eje_Y_s1;
  --cpu/data_master saved-grant entrada_ac_eje_Y/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_ac_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_Y_s1;
  --allow new arb cycle for entrada_ac_eje_Y/s1, which is an e_assign
  entrada_ac_eje_Y_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_ac_eje_Y_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_ac_eje_Y_s1_master_qreq_vector <= std_logic'('1');
  --entrada_ac_eje_Y_s1_reset_n assignment, which is an e_assign
  entrada_ac_eje_Y_s1_reset_n <= reset_n;
  --entrada_ac_eje_Y_s1_firsttransfer first transaction, which is an e_assign
  entrada_ac_eje_Y_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_ac_eje_Y_s1_begins_xfer) = '1'), entrada_ac_eje_Y_s1_unreg_firsttransfer, entrada_ac_eje_Y_s1_reg_firsttransfer);
  --entrada_ac_eje_Y_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_ac_eje_Y_s1_unreg_firsttransfer <= NOT ((entrada_ac_eje_Y_s1_slavearbiterlockenable AND entrada_ac_eje_Y_s1_any_continuerequest));
  --entrada_ac_eje_Y_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_Y_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ac_eje_Y_s1_begins_xfer) = '1' then 
        entrada_ac_eje_Y_s1_reg_firsttransfer <= entrada_ac_eje_Y_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_ac_eje_Y_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_ac_eje_Y_s1_beginbursttransfer_internal <= entrada_ac_eje_Y_s1_begins_xfer;
  shifted_address_to_entrada_ac_eje_Y_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_ac_eje_Y_s1_address mux, which is an e_mux
  entrada_ac_eje_Y_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_ac_eje_Y_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_ac_eje_Y_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_ac_eje_Y_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_ac_eje_Y_s1_end_xfer <= entrada_ac_eje_Y_s1_end_xfer;
    end if;

  end process;

  --entrada_ac_eje_Y_s1_waits_for_read in a cycle, which is an e_mux
  entrada_ac_eje_Y_s1_waits_for_read <= entrada_ac_eje_Y_s1_in_a_read_cycle AND entrada_ac_eje_Y_s1_begins_xfer;
  --entrada_ac_eje_Y_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_ac_eje_Y_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_ac_eje_Y_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_ac_eje_Y_s1_in_a_read_cycle;
  --entrada_ac_eje_Y_s1_waits_for_write in a cycle, which is an e_mux
  entrada_ac_eje_Y_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_ac_eje_Y_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_ac_eje_Y_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_ac_eje_Y_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_ac_eje_Y_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_ac_eje_Y_s1_in_a_write_cycle;
  wait_for_entrada_ac_eje_Y_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_ac_eje_Y_s1 <= internal_cpu_data_master_granted_entrada_ac_eje_Y_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 <= internal_cpu_data_master_qualified_request_entrada_ac_eje_Y_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_ac_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_Y_s1;
--synthesis translate_off
    --entrada_ac_eje_Y/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_ac_eje_Z_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_ac_eje_Z_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_ac_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ac_eje_Z_s1 : OUT STD_LOGIC;
                 signal d1_entrada_ac_eje_Z_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_ac_eje_Z_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_ac_eje_Z_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ac_eje_Z_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_ac_eje_Z_s1_arbitrator;


architecture europa of entrada_ac_eje_Z_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_allgrants :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_Z_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_Z_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_Z_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_begins_xfer :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_end_xfer :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_grant_vector :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_waits_for_read :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_ac_eje_Z_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_ac_eje_Z_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_ac_eje_Z_s1_end_xfer;
    end if;

  end process;

  entrada_ac_eje_Z_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_ac_eje_Z_s1);
  --assign entrada_ac_eje_Z_s1_readdata_from_sa = entrada_ac_eje_Z_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_ac_eje_Z_s1_readdata_from_sa <= entrada_ac_eje_Z_s1_readdata;
  internal_cpu_data_master_requests_entrada_ac_eje_Z_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000011010000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_ac_eje_Z_s1_arb_share_counter set values, which is an e_mux
  entrada_ac_eje_Z_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_ac_eje_Z_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_ac_eje_Z_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_ac_eje_Z_s1;
  --entrada_ac_eje_Z_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_ac_eje_Z_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_ac_eje_Z_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_ac_eje_Z_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_ac_eje_Z_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ac_eje_Z_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_ac_eje_Z_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ac_eje_Z_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_ac_eje_Z_s1_allgrants all slave grants, which is an e_mux
  entrada_ac_eje_Z_s1_allgrants <= entrada_ac_eje_Z_s1_grant_vector;
  --entrada_ac_eje_Z_s1_end_xfer assignment, which is an e_assign
  entrada_ac_eje_Z_s1_end_xfer <= NOT ((entrada_ac_eje_Z_s1_waits_for_read OR entrada_ac_eje_Z_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_ac_eje_Z_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_ac_eje_Z_s1 <= entrada_ac_eje_Z_s1_end_xfer AND (((NOT entrada_ac_eje_Z_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_ac_eje_Z_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_ac_eje_Z_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_ac_eje_Z_s1 AND entrada_ac_eje_Z_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_ac_eje_Z_s1 AND NOT entrada_ac_eje_Z_s1_non_bursting_master_requests));
  --entrada_ac_eje_Z_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_Z_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ac_eje_Z_s1_arb_counter_enable) = '1' then 
        entrada_ac_eje_Z_s1_arb_share_counter <= entrada_ac_eje_Z_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_ac_eje_Z_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_Z_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_ac_eje_Z_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_ac_eje_Z_s1)) OR ((end_xfer_arb_share_counter_term_entrada_ac_eje_Z_s1 AND NOT entrada_ac_eje_Z_s1_non_bursting_master_requests)))) = '1' then 
        entrada_ac_eje_Z_s1_slavearbiterlockenable <= or_reduce(entrada_ac_eje_Z_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_ac_eje_Z/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_ac_eje_Z_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_ac_eje_Z_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_ac_eje_Z_s1_slavearbiterlockenable2 <= or_reduce(entrada_ac_eje_Z_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_ac_eje_Z/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_ac_eje_Z_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_ac_eje_Z_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_ac_eje_Z_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_Z_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1 <= (internal_cpu_data_master_granted_entrada_ac_eje_Z_s1 AND cpu_data_master_read) AND NOT entrada_ac_eje_Z_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_ac_eje_Z_s1 <= internal_cpu_data_master_qualified_request_entrada_ac_eje_Z_s1;
  --cpu/data_master saved-grant entrada_ac_eje_Z/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_ac_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_Z_s1;
  --allow new arb cycle for entrada_ac_eje_Z/s1, which is an e_assign
  entrada_ac_eje_Z_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_ac_eje_Z_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_ac_eje_Z_s1_master_qreq_vector <= std_logic'('1');
  --entrada_ac_eje_Z_s1_reset_n assignment, which is an e_assign
  entrada_ac_eje_Z_s1_reset_n <= reset_n;
  --entrada_ac_eje_Z_s1_firsttransfer first transaction, which is an e_assign
  entrada_ac_eje_Z_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_ac_eje_Z_s1_begins_xfer) = '1'), entrada_ac_eje_Z_s1_unreg_firsttransfer, entrada_ac_eje_Z_s1_reg_firsttransfer);
  --entrada_ac_eje_Z_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_ac_eje_Z_s1_unreg_firsttransfer <= NOT ((entrada_ac_eje_Z_s1_slavearbiterlockenable AND entrada_ac_eje_Z_s1_any_continuerequest));
  --entrada_ac_eje_Z_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ac_eje_Z_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ac_eje_Z_s1_begins_xfer) = '1' then 
        entrada_ac_eje_Z_s1_reg_firsttransfer <= entrada_ac_eje_Z_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_ac_eje_Z_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_ac_eje_Z_s1_beginbursttransfer_internal <= entrada_ac_eje_Z_s1_begins_xfer;
  shifted_address_to_entrada_ac_eje_Z_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_ac_eje_Z_s1_address mux, which is an e_mux
  entrada_ac_eje_Z_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_ac_eje_Z_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_ac_eje_Z_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_ac_eje_Z_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_ac_eje_Z_s1_end_xfer <= entrada_ac_eje_Z_s1_end_xfer;
    end if;

  end process;

  --entrada_ac_eje_Z_s1_waits_for_read in a cycle, which is an e_mux
  entrada_ac_eje_Z_s1_waits_for_read <= entrada_ac_eje_Z_s1_in_a_read_cycle AND entrada_ac_eje_Z_s1_begins_xfer;
  --entrada_ac_eje_Z_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_ac_eje_Z_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_ac_eje_Z_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_ac_eje_Z_s1_in_a_read_cycle;
  --entrada_ac_eje_Z_s1_waits_for_write in a cycle, which is an e_mux
  entrada_ac_eje_Z_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_ac_eje_Z_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_ac_eje_Z_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_ac_eje_Z_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_ac_eje_Z_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_ac_eje_Z_s1_in_a_write_cycle;
  wait_for_entrada_ac_eje_Z_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_ac_eje_Z_s1 <= internal_cpu_data_master_granted_entrada_ac_eje_Z_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 <= internal_cpu_data_master_qualified_request_entrada_ac_eje_Z_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_ac_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_ac_eje_Z_s1;
--synthesis translate_off
    --entrada_ac_eje_Z/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_gy_eje_X_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_gy_eje_X_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_gy_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_gy_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_gy_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_gy_eje_X_s1 : OUT STD_LOGIC;
                 signal d1_entrada_gy_eje_X_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_gy_eje_X_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_gy_eje_X_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_gy_eje_X_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_gy_eje_X_s1_arbitrator;


architecture europa of entrada_gy_eje_X_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_allgrants :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_X_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_X_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_X_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_begins_xfer :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_end_xfer :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_grant_vector :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_waits_for_read :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_gy_eje_X_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_gy_eje_X_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_gy_eje_X_s1_end_xfer;
    end if;

  end process;

  entrada_gy_eje_X_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_gy_eje_X_s1);
  --assign entrada_gy_eje_X_s1_readdata_from_sa = entrada_gy_eje_X_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_gy_eje_X_s1_readdata_from_sa <= entrada_gy_eje_X_s1_readdata;
  internal_cpu_data_master_requests_entrada_gy_eje_X_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000100010000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_gy_eje_X_s1_arb_share_counter set values, which is an e_mux
  entrada_gy_eje_X_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_gy_eje_X_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_gy_eje_X_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_gy_eje_X_s1;
  --entrada_gy_eje_X_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_gy_eje_X_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_gy_eje_X_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_gy_eje_X_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_gy_eje_X_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_gy_eje_X_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_gy_eje_X_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_gy_eje_X_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_gy_eje_X_s1_allgrants all slave grants, which is an e_mux
  entrada_gy_eje_X_s1_allgrants <= entrada_gy_eje_X_s1_grant_vector;
  --entrada_gy_eje_X_s1_end_xfer assignment, which is an e_assign
  entrada_gy_eje_X_s1_end_xfer <= NOT ((entrada_gy_eje_X_s1_waits_for_read OR entrada_gy_eje_X_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_gy_eje_X_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_gy_eje_X_s1 <= entrada_gy_eje_X_s1_end_xfer AND (((NOT entrada_gy_eje_X_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_gy_eje_X_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_gy_eje_X_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_gy_eje_X_s1 AND entrada_gy_eje_X_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_gy_eje_X_s1 AND NOT entrada_gy_eje_X_s1_non_bursting_master_requests));
  --entrada_gy_eje_X_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_X_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_gy_eje_X_s1_arb_counter_enable) = '1' then 
        entrada_gy_eje_X_s1_arb_share_counter <= entrada_gy_eje_X_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_gy_eje_X_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_X_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_gy_eje_X_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_gy_eje_X_s1)) OR ((end_xfer_arb_share_counter_term_entrada_gy_eje_X_s1 AND NOT entrada_gy_eje_X_s1_non_bursting_master_requests)))) = '1' then 
        entrada_gy_eje_X_s1_slavearbiterlockenable <= or_reduce(entrada_gy_eje_X_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_gy_eje_X/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_gy_eje_X_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_gy_eje_X_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_gy_eje_X_s1_slavearbiterlockenable2 <= or_reduce(entrada_gy_eje_X_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_gy_eje_X/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_gy_eje_X_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_gy_eje_X_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_gy_eje_X_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_gy_eje_X_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_X_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_gy_eje_X_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_gy_eje_X_s1 <= (internal_cpu_data_master_granted_entrada_gy_eje_X_s1 AND cpu_data_master_read) AND NOT entrada_gy_eje_X_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_gy_eje_X_s1 <= internal_cpu_data_master_qualified_request_entrada_gy_eje_X_s1;
  --cpu/data_master saved-grant entrada_gy_eje_X/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_gy_eje_X_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_X_s1;
  --allow new arb cycle for entrada_gy_eje_X/s1, which is an e_assign
  entrada_gy_eje_X_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_gy_eje_X_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_gy_eje_X_s1_master_qreq_vector <= std_logic'('1');
  --entrada_gy_eje_X_s1_reset_n assignment, which is an e_assign
  entrada_gy_eje_X_s1_reset_n <= reset_n;
  --entrada_gy_eje_X_s1_firsttransfer first transaction, which is an e_assign
  entrada_gy_eje_X_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_gy_eje_X_s1_begins_xfer) = '1'), entrada_gy_eje_X_s1_unreg_firsttransfer, entrada_gy_eje_X_s1_reg_firsttransfer);
  --entrada_gy_eje_X_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_gy_eje_X_s1_unreg_firsttransfer <= NOT ((entrada_gy_eje_X_s1_slavearbiterlockenable AND entrada_gy_eje_X_s1_any_continuerequest));
  --entrada_gy_eje_X_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_X_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_gy_eje_X_s1_begins_xfer) = '1' then 
        entrada_gy_eje_X_s1_reg_firsttransfer <= entrada_gy_eje_X_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_gy_eje_X_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_gy_eje_X_s1_beginbursttransfer_internal <= entrada_gy_eje_X_s1_begins_xfer;
  shifted_address_to_entrada_gy_eje_X_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_gy_eje_X_s1_address mux, which is an e_mux
  entrada_gy_eje_X_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_gy_eje_X_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_gy_eje_X_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_gy_eje_X_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_gy_eje_X_s1_end_xfer <= entrada_gy_eje_X_s1_end_xfer;
    end if;

  end process;

  --entrada_gy_eje_X_s1_waits_for_read in a cycle, which is an e_mux
  entrada_gy_eje_X_s1_waits_for_read <= entrada_gy_eje_X_s1_in_a_read_cycle AND entrada_gy_eje_X_s1_begins_xfer;
  --entrada_gy_eje_X_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_gy_eje_X_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_gy_eje_X_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_gy_eje_X_s1_in_a_read_cycle;
  --entrada_gy_eje_X_s1_waits_for_write in a cycle, which is an e_mux
  entrada_gy_eje_X_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_gy_eje_X_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_gy_eje_X_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_gy_eje_X_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_gy_eje_X_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_gy_eje_X_s1_in_a_write_cycle;
  wait_for_entrada_gy_eje_X_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_gy_eje_X_s1 <= internal_cpu_data_master_granted_entrada_gy_eje_X_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_gy_eje_X_s1 <= internal_cpu_data_master_qualified_request_entrada_gy_eje_X_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_gy_eje_X_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_X_s1;
--synthesis translate_off
    --entrada_gy_eje_X/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_gy_eje_Y_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_gy_eje_Y_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_gy_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_gy_eje_Y_s1 : OUT STD_LOGIC;
                 signal d1_entrada_gy_eje_Y_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_gy_eje_Y_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_gy_eje_Y_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_gy_eje_Y_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_gy_eje_Y_s1_arbitrator;


architecture europa of entrada_gy_eje_Y_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_allgrants :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_Y_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_Y_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_Y_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_begins_xfer :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_end_xfer :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_grant_vector :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_waits_for_read :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_gy_eje_Y_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_gy_eje_Y_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_gy_eje_Y_s1_end_xfer;
    end if;

  end process;

  entrada_gy_eje_Y_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_gy_eje_Y_s1);
  --assign entrada_gy_eje_Y_s1_readdata_from_sa = entrada_gy_eje_Y_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_gy_eje_Y_s1_readdata_from_sa <= entrada_gy_eje_Y_s1_readdata;
  internal_cpu_data_master_requests_entrada_gy_eje_Y_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000100100000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_gy_eje_Y_s1_arb_share_counter set values, which is an e_mux
  entrada_gy_eje_Y_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_gy_eje_Y_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_gy_eje_Y_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_gy_eje_Y_s1;
  --entrada_gy_eje_Y_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_gy_eje_Y_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_gy_eje_Y_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_gy_eje_Y_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_gy_eje_Y_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_gy_eje_Y_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_gy_eje_Y_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_gy_eje_Y_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_gy_eje_Y_s1_allgrants all slave grants, which is an e_mux
  entrada_gy_eje_Y_s1_allgrants <= entrada_gy_eje_Y_s1_grant_vector;
  --entrada_gy_eje_Y_s1_end_xfer assignment, which is an e_assign
  entrada_gy_eje_Y_s1_end_xfer <= NOT ((entrada_gy_eje_Y_s1_waits_for_read OR entrada_gy_eje_Y_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_gy_eje_Y_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_gy_eje_Y_s1 <= entrada_gy_eje_Y_s1_end_xfer AND (((NOT entrada_gy_eje_Y_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_gy_eje_Y_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_gy_eje_Y_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_gy_eje_Y_s1 AND entrada_gy_eje_Y_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_gy_eje_Y_s1 AND NOT entrada_gy_eje_Y_s1_non_bursting_master_requests));
  --entrada_gy_eje_Y_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_Y_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_gy_eje_Y_s1_arb_counter_enable) = '1' then 
        entrada_gy_eje_Y_s1_arb_share_counter <= entrada_gy_eje_Y_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_gy_eje_Y_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_Y_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_gy_eje_Y_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_gy_eje_Y_s1)) OR ((end_xfer_arb_share_counter_term_entrada_gy_eje_Y_s1 AND NOT entrada_gy_eje_Y_s1_non_bursting_master_requests)))) = '1' then 
        entrada_gy_eje_Y_s1_slavearbiterlockenable <= or_reduce(entrada_gy_eje_Y_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_gy_eje_Y/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_gy_eje_Y_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_gy_eje_Y_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_gy_eje_Y_s1_slavearbiterlockenable2 <= or_reduce(entrada_gy_eje_Y_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_gy_eje_Y/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_gy_eje_Y_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_gy_eje_Y_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_gy_eje_Y_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_Y_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1 <= (internal_cpu_data_master_granted_entrada_gy_eje_Y_s1 AND cpu_data_master_read) AND NOT entrada_gy_eje_Y_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_gy_eje_Y_s1 <= internal_cpu_data_master_qualified_request_entrada_gy_eje_Y_s1;
  --cpu/data_master saved-grant entrada_gy_eje_Y/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_gy_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_Y_s1;
  --allow new arb cycle for entrada_gy_eje_Y/s1, which is an e_assign
  entrada_gy_eje_Y_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_gy_eje_Y_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_gy_eje_Y_s1_master_qreq_vector <= std_logic'('1');
  --entrada_gy_eje_Y_s1_reset_n assignment, which is an e_assign
  entrada_gy_eje_Y_s1_reset_n <= reset_n;
  --entrada_gy_eje_Y_s1_firsttransfer first transaction, which is an e_assign
  entrada_gy_eje_Y_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_gy_eje_Y_s1_begins_xfer) = '1'), entrada_gy_eje_Y_s1_unreg_firsttransfer, entrada_gy_eje_Y_s1_reg_firsttransfer);
  --entrada_gy_eje_Y_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_gy_eje_Y_s1_unreg_firsttransfer <= NOT ((entrada_gy_eje_Y_s1_slavearbiterlockenable AND entrada_gy_eje_Y_s1_any_continuerequest));
  --entrada_gy_eje_Y_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_Y_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_gy_eje_Y_s1_begins_xfer) = '1' then 
        entrada_gy_eje_Y_s1_reg_firsttransfer <= entrada_gy_eje_Y_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_gy_eje_Y_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_gy_eje_Y_s1_beginbursttransfer_internal <= entrada_gy_eje_Y_s1_begins_xfer;
  shifted_address_to_entrada_gy_eje_Y_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_gy_eje_Y_s1_address mux, which is an e_mux
  entrada_gy_eje_Y_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_gy_eje_Y_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_gy_eje_Y_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_gy_eje_Y_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_gy_eje_Y_s1_end_xfer <= entrada_gy_eje_Y_s1_end_xfer;
    end if;

  end process;

  --entrada_gy_eje_Y_s1_waits_for_read in a cycle, which is an e_mux
  entrada_gy_eje_Y_s1_waits_for_read <= entrada_gy_eje_Y_s1_in_a_read_cycle AND entrada_gy_eje_Y_s1_begins_xfer;
  --entrada_gy_eje_Y_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_gy_eje_Y_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_gy_eje_Y_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_gy_eje_Y_s1_in_a_read_cycle;
  --entrada_gy_eje_Y_s1_waits_for_write in a cycle, which is an e_mux
  entrada_gy_eje_Y_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_gy_eje_Y_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_gy_eje_Y_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_gy_eje_Y_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_gy_eje_Y_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_gy_eje_Y_s1_in_a_write_cycle;
  wait_for_entrada_gy_eje_Y_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_gy_eje_Y_s1 <= internal_cpu_data_master_granted_entrada_gy_eje_Y_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 <= internal_cpu_data_master_qualified_request_entrada_gy_eje_Y_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_gy_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_Y_s1;
--synthesis translate_off
    --entrada_gy_eje_Y/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_gy_eje_Z_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_gy_eje_Z_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_gy_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_gy_eje_Z_s1 : OUT STD_LOGIC;
                 signal d1_entrada_gy_eje_Z_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_gy_eje_Z_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_gy_eje_Z_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_gy_eje_Z_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_gy_eje_Z_s1_arbitrator;


architecture europa of entrada_gy_eje_Z_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_allgrants :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_Z_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_Z_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_Z_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_begins_xfer :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_end_xfer :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_grant_vector :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_waits_for_read :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_gy_eje_Z_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_gy_eje_Z_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_gy_eje_Z_s1_end_xfer;
    end if;

  end process;

  entrada_gy_eje_Z_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_gy_eje_Z_s1);
  --assign entrada_gy_eje_Z_s1_readdata_from_sa = entrada_gy_eje_Z_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_gy_eje_Z_s1_readdata_from_sa <= entrada_gy_eje_Z_s1_readdata;
  internal_cpu_data_master_requests_entrada_gy_eje_Z_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000100110000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_gy_eje_Z_s1_arb_share_counter set values, which is an e_mux
  entrada_gy_eje_Z_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_gy_eje_Z_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_gy_eje_Z_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_gy_eje_Z_s1;
  --entrada_gy_eje_Z_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_gy_eje_Z_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_gy_eje_Z_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_gy_eje_Z_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_gy_eje_Z_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_gy_eje_Z_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_gy_eje_Z_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_gy_eje_Z_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_gy_eje_Z_s1_allgrants all slave grants, which is an e_mux
  entrada_gy_eje_Z_s1_allgrants <= entrada_gy_eje_Z_s1_grant_vector;
  --entrada_gy_eje_Z_s1_end_xfer assignment, which is an e_assign
  entrada_gy_eje_Z_s1_end_xfer <= NOT ((entrada_gy_eje_Z_s1_waits_for_read OR entrada_gy_eje_Z_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_gy_eje_Z_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_gy_eje_Z_s1 <= entrada_gy_eje_Z_s1_end_xfer AND (((NOT entrada_gy_eje_Z_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_gy_eje_Z_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_gy_eje_Z_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_gy_eje_Z_s1 AND entrada_gy_eje_Z_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_gy_eje_Z_s1 AND NOT entrada_gy_eje_Z_s1_non_bursting_master_requests));
  --entrada_gy_eje_Z_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_Z_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_gy_eje_Z_s1_arb_counter_enable) = '1' then 
        entrada_gy_eje_Z_s1_arb_share_counter <= entrada_gy_eje_Z_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_gy_eje_Z_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_Z_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_gy_eje_Z_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_gy_eje_Z_s1)) OR ((end_xfer_arb_share_counter_term_entrada_gy_eje_Z_s1 AND NOT entrada_gy_eje_Z_s1_non_bursting_master_requests)))) = '1' then 
        entrada_gy_eje_Z_s1_slavearbiterlockenable <= or_reduce(entrada_gy_eje_Z_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_gy_eje_Z/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_gy_eje_Z_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_gy_eje_Z_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_gy_eje_Z_s1_slavearbiterlockenable2 <= or_reduce(entrada_gy_eje_Z_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_gy_eje_Z/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_gy_eje_Z_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_gy_eje_Z_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_gy_eje_Z_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_Z_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1 <= (internal_cpu_data_master_granted_entrada_gy_eje_Z_s1 AND cpu_data_master_read) AND NOT entrada_gy_eje_Z_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_gy_eje_Z_s1 <= internal_cpu_data_master_qualified_request_entrada_gy_eje_Z_s1;
  --cpu/data_master saved-grant entrada_gy_eje_Z/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_gy_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_Z_s1;
  --allow new arb cycle for entrada_gy_eje_Z/s1, which is an e_assign
  entrada_gy_eje_Z_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_gy_eje_Z_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_gy_eje_Z_s1_master_qreq_vector <= std_logic'('1');
  --entrada_gy_eje_Z_s1_reset_n assignment, which is an e_assign
  entrada_gy_eje_Z_s1_reset_n <= reset_n;
  --entrada_gy_eje_Z_s1_firsttransfer first transaction, which is an e_assign
  entrada_gy_eje_Z_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_gy_eje_Z_s1_begins_xfer) = '1'), entrada_gy_eje_Z_s1_unreg_firsttransfer, entrada_gy_eje_Z_s1_reg_firsttransfer);
  --entrada_gy_eje_Z_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_gy_eje_Z_s1_unreg_firsttransfer <= NOT ((entrada_gy_eje_Z_s1_slavearbiterlockenable AND entrada_gy_eje_Z_s1_any_continuerequest));
  --entrada_gy_eje_Z_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_gy_eje_Z_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_gy_eje_Z_s1_begins_xfer) = '1' then 
        entrada_gy_eje_Z_s1_reg_firsttransfer <= entrada_gy_eje_Z_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_gy_eje_Z_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_gy_eje_Z_s1_beginbursttransfer_internal <= entrada_gy_eje_Z_s1_begins_xfer;
  shifted_address_to_entrada_gy_eje_Z_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_gy_eje_Z_s1_address mux, which is an e_mux
  entrada_gy_eje_Z_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_gy_eje_Z_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_gy_eje_Z_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_gy_eje_Z_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_gy_eje_Z_s1_end_xfer <= entrada_gy_eje_Z_s1_end_xfer;
    end if;

  end process;

  --entrada_gy_eje_Z_s1_waits_for_read in a cycle, which is an e_mux
  entrada_gy_eje_Z_s1_waits_for_read <= entrada_gy_eje_Z_s1_in_a_read_cycle AND entrada_gy_eje_Z_s1_begins_xfer;
  --entrada_gy_eje_Z_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_gy_eje_Z_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_gy_eje_Z_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_gy_eje_Z_s1_in_a_read_cycle;
  --entrada_gy_eje_Z_s1_waits_for_write in a cycle, which is an e_mux
  entrada_gy_eje_Z_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_gy_eje_Z_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_gy_eje_Z_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_gy_eje_Z_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_gy_eje_Z_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_gy_eje_Z_s1_in_a_write_cycle;
  wait_for_entrada_gy_eje_Z_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_gy_eje_Z_s1 <= internal_cpu_data_master_granted_entrada_gy_eje_Z_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 <= internal_cpu_data_master_qualified_request_entrada_gy_eje_Z_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_gy_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_gy_eje_Z_s1;
--synthesis translate_off
    --entrada_gy_eje_Z/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_ma_eje_X_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_ma_eje_X_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_ma_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ma_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ma_eje_X_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ma_eje_X_s1 : OUT STD_LOGIC;
                 signal d1_entrada_ma_eje_X_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_ma_eje_X_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_ma_eje_X_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ma_eje_X_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_ma_eje_X_s1_arbitrator;


architecture europa of entrada_ma_eje_X_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_allgrants :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_X_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_X_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_X_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_begins_xfer :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_end_xfer :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_grant_vector :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_waits_for_read :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_ma_eje_X_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_ma_eje_X_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_ma_eje_X_s1_end_xfer;
    end if;

  end process;

  entrada_ma_eje_X_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_ma_eje_X_s1);
  --assign entrada_ma_eje_X_s1_readdata_from_sa = entrada_ma_eje_X_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_ma_eje_X_s1_readdata_from_sa <= entrada_ma_eje_X_s1_readdata;
  internal_cpu_data_master_requests_entrada_ma_eje_X_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000011100000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_ma_eje_X_s1_arb_share_counter set values, which is an e_mux
  entrada_ma_eje_X_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_ma_eje_X_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_ma_eje_X_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_ma_eje_X_s1;
  --entrada_ma_eje_X_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_ma_eje_X_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_ma_eje_X_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_ma_eje_X_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_ma_eje_X_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ma_eje_X_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_ma_eje_X_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ma_eje_X_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_ma_eje_X_s1_allgrants all slave grants, which is an e_mux
  entrada_ma_eje_X_s1_allgrants <= entrada_ma_eje_X_s1_grant_vector;
  --entrada_ma_eje_X_s1_end_xfer assignment, which is an e_assign
  entrada_ma_eje_X_s1_end_xfer <= NOT ((entrada_ma_eje_X_s1_waits_for_read OR entrada_ma_eje_X_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_ma_eje_X_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_ma_eje_X_s1 <= entrada_ma_eje_X_s1_end_xfer AND (((NOT entrada_ma_eje_X_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_ma_eje_X_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_ma_eje_X_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_ma_eje_X_s1 AND entrada_ma_eje_X_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_ma_eje_X_s1 AND NOT entrada_ma_eje_X_s1_non_bursting_master_requests));
  --entrada_ma_eje_X_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_X_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ma_eje_X_s1_arb_counter_enable) = '1' then 
        entrada_ma_eje_X_s1_arb_share_counter <= entrada_ma_eje_X_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_ma_eje_X_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_X_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_ma_eje_X_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_ma_eje_X_s1)) OR ((end_xfer_arb_share_counter_term_entrada_ma_eje_X_s1 AND NOT entrada_ma_eje_X_s1_non_bursting_master_requests)))) = '1' then 
        entrada_ma_eje_X_s1_slavearbiterlockenable <= or_reduce(entrada_ma_eje_X_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_ma_eje_X/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_ma_eje_X_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_ma_eje_X_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_ma_eje_X_s1_slavearbiterlockenable2 <= or_reduce(entrada_ma_eje_X_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_ma_eje_X/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_ma_eje_X_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_ma_eje_X_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_ma_eje_X_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_ma_eje_X_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_X_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_ma_eje_X_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_ma_eje_X_s1 <= (internal_cpu_data_master_granted_entrada_ma_eje_X_s1 AND cpu_data_master_read) AND NOT entrada_ma_eje_X_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_ma_eje_X_s1 <= internal_cpu_data_master_qualified_request_entrada_ma_eje_X_s1;
  --cpu/data_master saved-grant entrada_ma_eje_X/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_ma_eje_X_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_X_s1;
  --allow new arb cycle for entrada_ma_eje_X/s1, which is an e_assign
  entrada_ma_eje_X_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_ma_eje_X_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_ma_eje_X_s1_master_qreq_vector <= std_logic'('1');
  --entrada_ma_eje_X_s1_reset_n assignment, which is an e_assign
  entrada_ma_eje_X_s1_reset_n <= reset_n;
  --entrada_ma_eje_X_s1_firsttransfer first transaction, which is an e_assign
  entrada_ma_eje_X_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_ma_eje_X_s1_begins_xfer) = '1'), entrada_ma_eje_X_s1_unreg_firsttransfer, entrada_ma_eje_X_s1_reg_firsttransfer);
  --entrada_ma_eje_X_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_ma_eje_X_s1_unreg_firsttransfer <= NOT ((entrada_ma_eje_X_s1_slavearbiterlockenable AND entrada_ma_eje_X_s1_any_continuerequest));
  --entrada_ma_eje_X_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_X_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ma_eje_X_s1_begins_xfer) = '1' then 
        entrada_ma_eje_X_s1_reg_firsttransfer <= entrada_ma_eje_X_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_ma_eje_X_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_ma_eje_X_s1_beginbursttransfer_internal <= entrada_ma_eje_X_s1_begins_xfer;
  shifted_address_to_entrada_ma_eje_X_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_ma_eje_X_s1_address mux, which is an e_mux
  entrada_ma_eje_X_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_ma_eje_X_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_ma_eje_X_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_ma_eje_X_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_ma_eje_X_s1_end_xfer <= entrada_ma_eje_X_s1_end_xfer;
    end if;

  end process;

  --entrada_ma_eje_X_s1_waits_for_read in a cycle, which is an e_mux
  entrada_ma_eje_X_s1_waits_for_read <= entrada_ma_eje_X_s1_in_a_read_cycle AND entrada_ma_eje_X_s1_begins_xfer;
  --entrada_ma_eje_X_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_ma_eje_X_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_ma_eje_X_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_ma_eje_X_s1_in_a_read_cycle;
  --entrada_ma_eje_X_s1_waits_for_write in a cycle, which is an e_mux
  entrada_ma_eje_X_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_ma_eje_X_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_ma_eje_X_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_ma_eje_X_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_ma_eje_X_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_ma_eje_X_s1_in_a_write_cycle;
  wait_for_entrada_ma_eje_X_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_ma_eje_X_s1 <= internal_cpu_data_master_granted_entrada_ma_eje_X_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_ma_eje_X_s1 <= internal_cpu_data_master_qualified_request_entrada_ma_eje_X_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_ma_eje_X_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_X_s1;
--synthesis translate_off
    --entrada_ma_eje_X/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_ma_eje_Y_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_ma_eje_Y_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_ma_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ma_eje_Y_s1 : OUT STD_LOGIC;
                 signal d1_entrada_ma_eje_Y_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_ma_eje_Y_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_ma_eje_Y_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ma_eje_Y_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_ma_eje_Y_s1_arbitrator;


architecture europa of entrada_ma_eje_Y_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_allgrants :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_Y_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_Y_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_Y_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_begins_xfer :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_end_xfer :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_grant_vector :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_waits_for_read :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_ma_eje_Y_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_ma_eje_Y_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_ma_eje_Y_s1_end_xfer;
    end if;

  end process;

  entrada_ma_eje_Y_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_ma_eje_Y_s1);
  --assign entrada_ma_eje_Y_s1_readdata_from_sa = entrada_ma_eje_Y_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_ma_eje_Y_s1_readdata_from_sa <= entrada_ma_eje_Y_s1_readdata;
  internal_cpu_data_master_requests_entrada_ma_eje_Y_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000011110000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_ma_eje_Y_s1_arb_share_counter set values, which is an e_mux
  entrada_ma_eje_Y_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_ma_eje_Y_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_ma_eje_Y_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_ma_eje_Y_s1;
  --entrada_ma_eje_Y_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_ma_eje_Y_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_ma_eje_Y_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_ma_eje_Y_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_ma_eje_Y_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ma_eje_Y_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_ma_eje_Y_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ma_eje_Y_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_ma_eje_Y_s1_allgrants all slave grants, which is an e_mux
  entrada_ma_eje_Y_s1_allgrants <= entrada_ma_eje_Y_s1_grant_vector;
  --entrada_ma_eje_Y_s1_end_xfer assignment, which is an e_assign
  entrada_ma_eje_Y_s1_end_xfer <= NOT ((entrada_ma_eje_Y_s1_waits_for_read OR entrada_ma_eje_Y_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_ma_eje_Y_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_ma_eje_Y_s1 <= entrada_ma_eje_Y_s1_end_xfer AND (((NOT entrada_ma_eje_Y_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_ma_eje_Y_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_ma_eje_Y_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_ma_eje_Y_s1 AND entrada_ma_eje_Y_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_ma_eje_Y_s1 AND NOT entrada_ma_eje_Y_s1_non_bursting_master_requests));
  --entrada_ma_eje_Y_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_Y_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ma_eje_Y_s1_arb_counter_enable) = '1' then 
        entrada_ma_eje_Y_s1_arb_share_counter <= entrada_ma_eje_Y_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_ma_eje_Y_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_Y_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_ma_eje_Y_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_ma_eje_Y_s1)) OR ((end_xfer_arb_share_counter_term_entrada_ma_eje_Y_s1 AND NOT entrada_ma_eje_Y_s1_non_bursting_master_requests)))) = '1' then 
        entrada_ma_eje_Y_s1_slavearbiterlockenable <= or_reduce(entrada_ma_eje_Y_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_ma_eje_Y/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_ma_eje_Y_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_ma_eje_Y_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_ma_eje_Y_s1_slavearbiterlockenable2 <= or_reduce(entrada_ma_eje_Y_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_ma_eje_Y/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_ma_eje_Y_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_ma_eje_Y_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_ma_eje_Y_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_Y_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1 <= (internal_cpu_data_master_granted_entrada_ma_eje_Y_s1 AND cpu_data_master_read) AND NOT entrada_ma_eje_Y_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_ma_eje_Y_s1 <= internal_cpu_data_master_qualified_request_entrada_ma_eje_Y_s1;
  --cpu/data_master saved-grant entrada_ma_eje_Y/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_ma_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_Y_s1;
  --allow new arb cycle for entrada_ma_eje_Y/s1, which is an e_assign
  entrada_ma_eje_Y_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_ma_eje_Y_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_ma_eje_Y_s1_master_qreq_vector <= std_logic'('1');
  --entrada_ma_eje_Y_s1_reset_n assignment, which is an e_assign
  entrada_ma_eje_Y_s1_reset_n <= reset_n;
  --entrada_ma_eje_Y_s1_firsttransfer first transaction, which is an e_assign
  entrada_ma_eje_Y_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_ma_eje_Y_s1_begins_xfer) = '1'), entrada_ma_eje_Y_s1_unreg_firsttransfer, entrada_ma_eje_Y_s1_reg_firsttransfer);
  --entrada_ma_eje_Y_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_ma_eje_Y_s1_unreg_firsttransfer <= NOT ((entrada_ma_eje_Y_s1_slavearbiterlockenable AND entrada_ma_eje_Y_s1_any_continuerequest));
  --entrada_ma_eje_Y_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_Y_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ma_eje_Y_s1_begins_xfer) = '1' then 
        entrada_ma_eje_Y_s1_reg_firsttransfer <= entrada_ma_eje_Y_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_ma_eje_Y_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_ma_eje_Y_s1_beginbursttransfer_internal <= entrada_ma_eje_Y_s1_begins_xfer;
  shifted_address_to_entrada_ma_eje_Y_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_ma_eje_Y_s1_address mux, which is an e_mux
  entrada_ma_eje_Y_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_ma_eje_Y_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_ma_eje_Y_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_ma_eje_Y_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_ma_eje_Y_s1_end_xfer <= entrada_ma_eje_Y_s1_end_xfer;
    end if;

  end process;

  --entrada_ma_eje_Y_s1_waits_for_read in a cycle, which is an e_mux
  entrada_ma_eje_Y_s1_waits_for_read <= entrada_ma_eje_Y_s1_in_a_read_cycle AND entrada_ma_eje_Y_s1_begins_xfer;
  --entrada_ma_eje_Y_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_ma_eje_Y_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_ma_eje_Y_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_ma_eje_Y_s1_in_a_read_cycle;
  --entrada_ma_eje_Y_s1_waits_for_write in a cycle, which is an e_mux
  entrada_ma_eje_Y_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_ma_eje_Y_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_ma_eje_Y_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_ma_eje_Y_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_ma_eje_Y_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_ma_eje_Y_s1_in_a_write_cycle;
  wait_for_entrada_ma_eje_Y_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_ma_eje_Y_s1 <= internal_cpu_data_master_granted_entrada_ma_eje_Y_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 <= internal_cpu_data_master_qualified_request_entrada_ma_eje_Y_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_ma_eje_Y_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_Y_s1;
--synthesis translate_off
    --entrada_ma_eje_Y/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_ma_eje_Z_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_ma_eje_Z_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_ma_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_ma_eje_Z_s1 : OUT STD_LOGIC;
                 signal d1_entrada_ma_eje_Z_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_ma_eje_Z_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_ma_eje_Z_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_ma_eje_Z_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_ma_eje_Z_s1_arbitrator;


architecture europa of entrada_ma_eje_Z_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_allgrants :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_Z_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_Z_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_Z_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_begins_xfer :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_end_xfer :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_grant_vector :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_waits_for_read :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_ma_eje_Z_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_ma_eje_Z_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_ma_eje_Z_s1_end_xfer;
    end if;

  end process;

  entrada_ma_eje_Z_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_ma_eje_Z_s1);
  --assign entrada_ma_eje_Z_s1_readdata_from_sa = entrada_ma_eje_Z_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_ma_eje_Z_s1_readdata_from_sa <= entrada_ma_eje_Z_s1_readdata;
  internal_cpu_data_master_requests_entrada_ma_eje_Z_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000100000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_ma_eje_Z_s1_arb_share_counter set values, which is an e_mux
  entrada_ma_eje_Z_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_ma_eje_Z_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_ma_eje_Z_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_ma_eje_Z_s1;
  --entrada_ma_eje_Z_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_ma_eje_Z_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_ma_eje_Z_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_ma_eje_Z_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_ma_eje_Z_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ma_eje_Z_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_ma_eje_Z_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_ma_eje_Z_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_ma_eje_Z_s1_allgrants all slave grants, which is an e_mux
  entrada_ma_eje_Z_s1_allgrants <= entrada_ma_eje_Z_s1_grant_vector;
  --entrada_ma_eje_Z_s1_end_xfer assignment, which is an e_assign
  entrada_ma_eje_Z_s1_end_xfer <= NOT ((entrada_ma_eje_Z_s1_waits_for_read OR entrada_ma_eje_Z_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_ma_eje_Z_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_ma_eje_Z_s1 <= entrada_ma_eje_Z_s1_end_xfer AND (((NOT entrada_ma_eje_Z_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_ma_eje_Z_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_ma_eje_Z_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_ma_eje_Z_s1 AND entrada_ma_eje_Z_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_ma_eje_Z_s1 AND NOT entrada_ma_eje_Z_s1_non_bursting_master_requests));
  --entrada_ma_eje_Z_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_Z_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ma_eje_Z_s1_arb_counter_enable) = '1' then 
        entrada_ma_eje_Z_s1_arb_share_counter <= entrada_ma_eje_Z_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_ma_eje_Z_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_Z_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_ma_eje_Z_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_ma_eje_Z_s1)) OR ((end_xfer_arb_share_counter_term_entrada_ma_eje_Z_s1 AND NOT entrada_ma_eje_Z_s1_non_bursting_master_requests)))) = '1' then 
        entrada_ma_eje_Z_s1_slavearbiterlockenable <= or_reduce(entrada_ma_eje_Z_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_ma_eje_Z/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_ma_eje_Z_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_ma_eje_Z_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_ma_eje_Z_s1_slavearbiterlockenable2 <= or_reduce(entrada_ma_eje_Z_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_ma_eje_Z/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_ma_eje_Z_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_ma_eje_Z_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_ma_eje_Z_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_Z_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1 <= (internal_cpu_data_master_granted_entrada_ma_eje_Z_s1 AND cpu_data_master_read) AND NOT entrada_ma_eje_Z_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_ma_eje_Z_s1 <= internal_cpu_data_master_qualified_request_entrada_ma_eje_Z_s1;
  --cpu/data_master saved-grant entrada_ma_eje_Z/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_ma_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_Z_s1;
  --allow new arb cycle for entrada_ma_eje_Z/s1, which is an e_assign
  entrada_ma_eje_Z_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_ma_eje_Z_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_ma_eje_Z_s1_master_qreq_vector <= std_logic'('1');
  --entrada_ma_eje_Z_s1_reset_n assignment, which is an e_assign
  entrada_ma_eje_Z_s1_reset_n <= reset_n;
  --entrada_ma_eje_Z_s1_firsttransfer first transaction, which is an e_assign
  entrada_ma_eje_Z_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_ma_eje_Z_s1_begins_xfer) = '1'), entrada_ma_eje_Z_s1_unreg_firsttransfer, entrada_ma_eje_Z_s1_reg_firsttransfer);
  --entrada_ma_eje_Z_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_ma_eje_Z_s1_unreg_firsttransfer <= NOT ((entrada_ma_eje_Z_s1_slavearbiterlockenable AND entrada_ma_eje_Z_s1_any_continuerequest));
  --entrada_ma_eje_Z_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_ma_eje_Z_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_ma_eje_Z_s1_begins_xfer) = '1' then 
        entrada_ma_eje_Z_s1_reg_firsttransfer <= entrada_ma_eje_Z_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_ma_eje_Z_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_ma_eje_Z_s1_beginbursttransfer_internal <= entrada_ma_eje_Z_s1_begins_xfer;
  shifted_address_to_entrada_ma_eje_Z_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_ma_eje_Z_s1_address mux, which is an e_mux
  entrada_ma_eje_Z_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_ma_eje_Z_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_ma_eje_Z_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_ma_eje_Z_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_ma_eje_Z_s1_end_xfer <= entrada_ma_eje_Z_s1_end_xfer;
    end if;

  end process;

  --entrada_ma_eje_Z_s1_waits_for_read in a cycle, which is an e_mux
  entrada_ma_eje_Z_s1_waits_for_read <= entrada_ma_eje_Z_s1_in_a_read_cycle AND entrada_ma_eje_Z_s1_begins_xfer;
  --entrada_ma_eje_Z_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_ma_eje_Z_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_ma_eje_Z_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_ma_eje_Z_s1_in_a_read_cycle;
  --entrada_ma_eje_Z_s1_waits_for_write in a cycle, which is an e_mux
  entrada_ma_eje_Z_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_ma_eje_Z_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_ma_eje_Z_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_ma_eje_Z_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_ma_eje_Z_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_ma_eje_Z_s1_in_a_write_cycle;
  wait_for_entrada_ma_eje_Z_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_ma_eje_Z_s1 <= internal_cpu_data_master_granted_entrada_ma_eje_Z_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 <= internal_cpu_data_master_qualified_request_entrada_ma_eje_Z_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_ma_eje_Z_s1 <= internal_cpu_data_master_requests_entrada_ma_eje_Z_s1;
--synthesis translate_off
    --entrada_ma_eje_Z/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity entrada_temp_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal entrada_temp_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_entrada_temp_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_entrada_temp_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_entrada_temp_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_entrada_temp_s1 : OUT STD_LOGIC;
                 signal d1_entrada_temp_s1_end_xfer : OUT STD_LOGIC;
                 signal entrada_temp_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal entrada_temp_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal entrada_temp_s1_reset_n : OUT STD_LOGIC
              );
end entity entrada_temp_s1_arbitrator;


architecture europa of entrada_temp_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_entrada_temp_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_entrada_temp_s1 :  STD_LOGIC;
                signal entrada_temp_s1_allgrants :  STD_LOGIC;
                signal entrada_temp_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal entrada_temp_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal entrada_temp_s1_any_continuerequest :  STD_LOGIC;
                signal entrada_temp_s1_arb_counter_enable :  STD_LOGIC;
                signal entrada_temp_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_temp_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_temp_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_temp_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal entrada_temp_s1_begins_xfer :  STD_LOGIC;
                signal entrada_temp_s1_end_xfer :  STD_LOGIC;
                signal entrada_temp_s1_firsttransfer :  STD_LOGIC;
                signal entrada_temp_s1_grant_vector :  STD_LOGIC;
                signal entrada_temp_s1_in_a_read_cycle :  STD_LOGIC;
                signal entrada_temp_s1_in_a_write_cycle :  STD_LOGIC;
                signal entrada_temp_s1_master_qreq_vector :  STD_LOGIC;
                signal entrada_temp_s1_non_bursting_master_requests :  STD_LOGIC;
                signal entrada_temp_s1_reg_firsttransfer :  STD_LOGIC;
                signal entrada_temp_s1_slavearbiterlockenable :  STD_LOGIC;
                signal entrada_temp_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal entrada_temp_s1_unreg_firsttransfer :  STD_LOGIC;
                signal entrada_temp_s1_waits_for_read :  STD_LOGIC;
                signal entrada_temp_s1_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_entrada_temp_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_entrada_temp_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_entrada_temp_s1 :  STD_LOGIC;
                signal shifted_address_to_entrada_temp_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_entrada_temp_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT entrada_temp_s1_end_xfer;
    end if;

  end process;

  entrada_temp_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_entrada_temp_s1);
  --assign entrada_temp_s1_readdata_from_sa = entrada_temp_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  entrada_temp_s1_readdata_from_sa <= entrada_temp_s1_readdata;
  internal_cpu_data_master_requests_entrada_temp_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000000000010000101000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --entrada_temp_s1_arb_share_counter set values, which is an e_mux
  entrada_temp_s1_arb_share_set_values <= std_logic_vector'("01");
  --entrada_temp_s1_non_bursting_master_requests mux, which is an e_mux
  entrada_temp_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_entrada_temp_s1;
  --entrada_temp_s1_any_bursting_master_saved_grant mux, which is an e_mux
  entrada_temp_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --entrada_temp_s1_arb_share_counter_next_value assignment, which is an e_assign
  entrada_temp_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(entrada_temp_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_temp_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(entrada_temp_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (entrada_temp_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --entrada_temp_s1_allgrants all slave grants, which is an e_mux
  entrada_temp_s1_allgrants <= entrada_temp_s1_grant_vector;
  --entrada_temp_s1_end_xfer assignment, which is an e_assign
  entrada_temp_s1_end_xfer <= NOT ((entrada_temp_s1_waits_for_read OR entrada_temp_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_entrada_temp_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_entrada_temp_s1 <= entrada_temp_s1_end_xfer AND (((NOT entrada_temp_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --entrada_temp_s1_arb_share_counter arbitration counter enable, which is an e_assign
  entrada_temp_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_entrada_temp_s1 AND entrada_temp_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_entrada_temp_s1 AND NOT entrada_temp_s1_non_bursting_master_requests));
  --entrada_temp_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_temp_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_temp_s1_arb_counter_enable) = '1' then 
        entrada_temp_s1_arb_share_counter <= entrada_temp_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --entrada_temp_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_temp_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((entrada_temp_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_entrada_temp_s1)) OR ((end_xfer_arb_share_counter_term_entrada_temp_s1 AND NOT entrada_temp_s1_non_bursting_master_requests)))) = '1' then 
        entrada_temp_s1_slavearbiterlockenable <= or_reduce(entrada_temp_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master entrada_temp/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= entrada_temp_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --entrada_temp_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  entrada_temp_s1_slavearbiterlockenable2 <= or_reduce(entrada_temp_s1_arb_share_counter_next_value);
  --cpu/data_master entrada_temp/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= entrada_temp_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --entrada_temp_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  entrada_temp_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_entrada_temp_s1 <= internal_cpu_data_master_requests_entrada_temp_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_entrada_temp_s1, which is an e_mux
  cpu_data_master_read_data_valid_entrada_temp_s1 <= (internal_cpu_data_master_granted_entrada_temp_s1 AND cpu_data_master_read) AND NOT entrada_temp_s1_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_entrada_temp_s1 <= internal_cpu_data_master_qualified_request_entrada_temp_s1;
  --cpu/data_master saved-grant entrada_temp/s1, which is an e_assign
  cpu_data_master_saved_grant_entrada_temp_s1 <= internal_cpu_data_master_requests_entrada_temp_s1;
  --allow new arb cycle for entrada_temp/s1, which is an e_assign
  entrada_temp_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  entrada_temp_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  entrada_temp_s1_master_qreq_vector <= std_logic'('1');
  --entrada_temp_s1_reset_n assignment, which is an e_assign
  entrada_temp_s1_reset_n <= reset_n;
  --entrada_temp_s1_firsttransfer first transaction, which is an e_assign
  entrada_temp_s1_firsttransfer <= A_WE_StdLogic((std_logic'(entrada_temp_s1_begins_xfer) = '1'), entrada_temp_s1_unreg_firsttransfer, entrada_temp_s1_reg_firsttransfer);
  --entrada_temp_s1_unreg_firsttransfer first transaction, which is an e_assign
  entrada_temp_s1_unreg_firsttransfer <= NOT ((entrada_temp_s1_slavearbiterlockenable AND entrada_temp_s1_any_continuerequest));
  --entrada_temp_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      entrada_temp_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(entrada_temp_s1_begins_xfer) = '1' then 
        entrada_temp_s1_reg_firsttransfer <= entrada_temp_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --entrada_temp_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  entrada_temp_s1_beginbursttransfer_internal <= entrada_temp_s1_begins_xfer;
  shifted_address_to_entrada_temp_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --entrada_temp_s1_address mux, which is an e_mux
  entrada_temp_s1_address <= A_EXT (A_SRL(shifted_address_to_entrada_temp_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_entrada_temp_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_entrada_temp_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_entrada_temp_s1_end_xfer <= entrada_temp_s1_end_xfer;
    end if;

  end process;

  --entrada_temp_s1_waits_for_read in a cycle, which is an e_mux
  entrada_temp_s1_waits_for_read <= entrada_temp_s1_in_a_read_cycle AND entrada_temp_s1_begins_xfer;
  --entrada_temp_s1_in_a_read_cycle assignment, which is an e_assign
  entrada_temp_s1_in_a_read_cycle <= internal_cpu_data_master_granted_entrada_temp_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= entrada_temp_s1_in_a_read_cycle;
  --entrada_temp_s1_waits_for_write in a cycle, which is an e_mux
  entrada_temp_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(entrada_temp_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --entrada_temp_s1_in_a_write_cycle assignment, which is an e_assign
  entrada_temp_s1_in_a_write_cycle <= internal_cpu_data_master_granted_entrada_temp_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= entrada_temp_s1_in_a_write_cycle;
  wait_for_entrada_temp_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_entrada_temp_s1 <= internal_cpu_data_master_granted_entrada_temp_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_entrada_temp_s1 <= internal_cpu_data_master_qualified_request_entrada_temp_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_entrada_temp_s1 <= internal_cpu_data_master_requests_entrada_temp_s1;
--synthesis translate_off
    --entrada_temp/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity epcs_flash_controller_epcs_control_port_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC;
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_dataavailable : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_endofpacket : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_irq : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal epcs_flash_controller_epcs_control_port_readyfordata : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal d1_epcs_flash_controller_epcs_control_port_end_xfer : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal epcs_flash_controller_epcs_control_port_chipselect : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_irq_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_read_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal epcs_flash_controller_epcs_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_reset_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_write_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity epcs_flash_controller_epcs_control_port_arbitrator;


architecture europa of epcs_flash_controller_epcs_control_port_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_allgrants :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_allow_new_arb_cycle :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_any_bursting_master_saved_grant :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_any_continuerequest :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_arb_counter_enable :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_beginbursttransfer_internal :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_begins_xfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_end_xfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_in_a_read_cycle :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_in_a_write_cycle :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_non_bursting_master_requests :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_reg_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_slavearbiterlockenable :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_unreg_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_waits_for_read :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_instruction_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_epcs_flash_controller_epcs_control_port_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT epcs_flash_controller_epcs_control_port_end_xfer;
    end if;

  end process;

  epcs_flash_controller_epcs_control_port_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port OR internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port));
  --assign epcs_flash_controller_epcs_control_port_readdata_from_sa = epcs_flash_controller_epcs_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_readdata_from_sa <= epcs_flash_controller_epcs_control_port_readdata;
  internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000000000001100000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign epcs_flash_controller_epcs_control_port_dataavailable_from_sa = epcs_flash_controller_epcs_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_dataavailable_from_sa <= epcs_flash_controller_epcs_control_port_dataavailable;
  --assign epcs_flash_controller_epcs_control_port_readyfordata_from_sa = epcs_flash_controller_epcs_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_readyfordata_from_sa <= epcs_flash_controller_epcs_control_port_readyfordata;
  --epcs_flash_controller_epcs_control_port_arb_share_counter set values, which is an e_mux
  epcs_flash_controller_epcs_control_port_arb_share_set_values <= std_logic_vector'("01");
  --epcs_flash_controller_epcs_control_port_non_bursting_master_requests mux, which is an e_mux
  epcs_flash_controller_epcs_control_port_non_bursting_master_requests <= ((internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port OR internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port) OR internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port) OR internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port;
  --epcs_flash_controller_epcs_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  epcs_flash_controller_epcs_control_port_any_bursting_master_saved_grant <= std_logic'('0');
  --epcs_flash_controller_epcs_control_port_arb_share_counter_next_value assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(epcs_flash_controller_epcs_control_port_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (epcs_flash_controller_epcs_control_port_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(epcs_flash_controller_epcs_control_port_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (epcs_flash_controller_epcs_control_port_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --epcs_flash_controller_epcs_control_port_allgrants all slave grants, which is an e_mux
  epcs_flash_controller_epcs_control_port_allgrants <= (((or_reduce(epcs_flash_controller_epcs_control_port_grant_vector)) OR (or_reduce(epcs_flash_controller_epcs_control_port_grant_vector))) OR (or_reduce(epcs_flash_controller_epcs_control_port_grant_vector))) OR (or_reduce(epcs_flash_controller_epcs_control_port_grant_vector));
  --epcs_flash_controller_epcs_control_port_end_xfer assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_end_xfer <= NOT ((epcs_flash_controller_epcs_control_port_waits_for_read OR epcs_flash_controller_epcs_control_port_waits_for_write));
  --end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_end_xfer AND (((NOT epcs_flash_controller_epcs_control_port_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --epcs_flash_controller_epcs_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  epcs_flash_controller_epcs_control_port_arb_counter_enable <= ((end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port AND epcs_flash_controller_epcs_control_port_allgrants)) OR ((end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port AND NOT epcs_flash_controller_epcs_control_port_non_bursting_master_requests));
  --epcs_flash_controller_epcs_control_port_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_epcs_control_port_arb_counter_enable) = '1' then 
        epcs_flash_controller_epcs_control_port_arb_share_counter <= epcs_flash_controller_epcs_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --epcs_flash_controller_epcs_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(epcs_flash_controller_epcs_control_port_master_qreq_vector) AND end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port)) OR ((end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port AND NOT epcs_flash_controller_epcs_control_port_non_bursting_master_requests)))) = '1' then 
        epcs_flash_controller_epcs_control_port_slavearbiterlockenable <= or_reduce(epcs_flash_controller_epcs_control_port_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master epcs_flash_controller/epcs_control_port arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= epcs_flash_controller_epcs_control_port_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 <= or_reduce(epcs_flash_controller_epcs_control_port_arb_share_counter_next_value);
  --cpu/data_master epcs_flash_controller/epcs_control_port arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master epcs_flash_controller/epcs_control_port arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= epcs_flash_controller_epcs_control_port_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master epcs_flash_controller/epcs_control_port arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted epcs_flash_controller/epcs_control_port last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_epcs_flash_controller_epcs_control_port) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port AND internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port;
  --epcs_flash_controller_epcs_control_port_any_continuerequest at least one master continues requesting, which is an e_mux
  epcs_flash_controller_epcs_control_port_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port <= internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port AND NOT ((((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))))) OR cpu_instruction_master_arbiterlock));
  --local readdatavalid cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port, which is an e_mux
  cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port <= (internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_read) AND NOT epcs_flash_controller_epcs_control_port_waits_for_read;
  --epcs_flash_controller_epcs_control_port_writedata mux, which is an e_mux
  epcs_flash_controller_epcs_control_port_writedata <= cpu_data_master_writedata;
  --assign epcs_flash_controller_epcs_control_port_endofpacket_from_sa = epcs_flash_controller_epcs_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_endofpacket_from_sa <= epcs_flash_controller_epcs_control_port_endofpacket;
  internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(26 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000000000001100000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted epcs_flash_controller/epcs_control_port last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_epcs_flash_controller_epcs_control_port) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port AND internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port;
  internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port <= internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port AND NOT ((((cpu_instruction_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))))) OR cpu_data_master_arbiterlock));
  --local readdatavalid cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port, which is an e_mux
  cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port <= (internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port AND cpu_instruction_master_read) AND NOT epcs_flash_controller_epcs_control_port_waits_for_read;
  --allow new arb cycle for epcs_flash_controller/epcs_control_port, which is an e_assign
  epcs_flash_controller_epcs_control_port_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for epcs_flash_controller/epcs_control_port, which is an e_assign
  epcs_flash_controller_epcs_control_port_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port;
  --cpu/instruction_master grant epcs_flash_controller/epcs_control_port, which is an e_assign
  internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_grant_vector(0);
  --cpu/instruction_master saved-grant epcs_flash_controller/epcs_control_port, which is an e_assign
  cpu_instruction_master_saved_grant_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_arb_winner(0) AND internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port;
  --cpu/data_master assignment into master qualified-requests vector for epcs_flash_controller/epcs_control_port, which is an e_assign
  epcs_flash_controller_epcs_control_port_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port;
  --cpu/data_master grant epcs_flash_controller/epcs_control_port, which is an e_assign
  internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_grant_vector(1);
  --cpu/data_master saved-grant epcs_flash_controller/epcs_control_port, which is an e_assign
  cpu_data_master_saved_grant_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_arb_winner(1) AND internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port;
  --epcs_flash_controller/epcs_control_port chosen-master double-vector, which is an e_assign
  epcs_flash_controller_epcs_control_port_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((epcs_flash_controller_epcs_control_port_master_qreq_vector & epcs_flash_controller_epcs_control_port_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT epcs_flash_controller_epcs_control_port_master_qreq_vector & NOT epcs_flash_controller_epcs_control_port_master_qreq_vector))) + (std_logic_vector'("000") & (epcs_flash_controller_epcs_control_port_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  epcs_flash_controller_epcs_control_port_arb_winner <= A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_epcs_control_port_allow_new_arb_cycle AND or_reduce(epcs_flash_controller_epcs_control_port_grant_vector)))) = '1'), epcs_flash_controller_epcs_control_port_grant_vector, epcs_flash_controller_epcs_control_port_saved_chosen_master_vector);
  --saved epcs_flash_controller_epcs_control_port_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_epcs_control_port_allow_new_arb_cycle) = '1' then 
        epcs_flash_controller_epcs_control_port_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(epcs_flash_controller_epcs_control_port_grant_vector)) = '1'), epcs_flash_controller_epcs_control_port_grant_vector, epcs_flash_controller_epcs_control_port_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  epcs_flash_controller_epcs_control_port_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((epcs_flash_controller_epcs_control_port_chosen_master_double_vector(1) OR epcs_flash_controller_epcs_control_port_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((epcs_flash_controller_epcs_control_port_chosen_master_double_vector(0) OR epcs_flash_controller_epcs_control_port_chosen_master_double_vector(2)))));
  --epcs_flash_controller/epcs_control_port chosen master rotated left, which is an e_assign
  epcs_flash_controller_epcs_control_port_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(epcs_flash_controller_epcs_control_port_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(epcs_flash_controller_epcs_control_port_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --epcs_flash_controller/epcs_control_port's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(epcs_flash_controller_epcs_control_port_grant_vector)) = '1' then 
        epcs_flash_controller_epcs_control_port_arb_addend <= A_WE_StdLogicVector((std_logic'(epcs_flash_controller_epcs_control_port_end_xfer) = '1'), epcs_flash_controller_epcs_control_port_chosen_master_rot_left, epcs_flash_controller_epcs_control_port_grant_vector);
      end if;
    end if;

  end process;

  --epcs_flash_controller_epcs_control_port_reset_n assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_reset_n <= reset_n;
  epcs_flash_controller_epcs_control_port_chipselect <= internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port OR internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port;
  --epcs_flash_controller_epcs_control_port_firsttransfer first transaction, which is an e_assign
  epcs_flash_controller_epcs_control_port_firsttransfer <= A_WE_StdLogic((std_logic'(epcs_flash_controller_epcs_control_port_begins_xfer) = '1'), epcs_flash_controller_epcs_control_port_unreg_firsttransfer, epcs_flash_controller_epcs_control_port_reg_firsttransfer);
  --epcs_flash_controller_epcs_control_port_unreg_firsttransfer first transaction, which is an e_assign
  epcs_flash_controller_epcs_control_port_unreg_firsttransfer <= NOT ((epcs_flash_controller_epcs_control_port_slavearbiterlockenable AND epcs_flash_controller_epcs_control_port_any_continuerequest));
  --epcs_flash_controller_epcs_control_port_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_epcs_control_port_begins_xfer) = '1' then 
        epcs_flash_controller_epcs_control_port_reg_firsttransfer <= epcs_flash_controller_epcs_control_port_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --epcs_flash_controller_epcs_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  epcs_flash_controller_epcs_control_port_beginbursttransfer_internal <= epcs_flash_controller_epcs_control_port_begins_xfer;
  --epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal <= epcs_flash_controller_epcs_control_port_begins_xfer AND epcs_flash_controller_epcs_control_port_firsttransfer;
  --~epcs_flash_controller_epcs_control_port_read_n assignment, which is an e_mux
  epcs_flash_controller_epcs_control_port_read_n <= NOT ((((internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port AND cpu_instruction_master_read))));
  --~epcs_flash_controller_epcs_control_port_write_n assignment, which is an e_mux
  epcs_flash_controller_epcs_control_port_write_n <= NOT ((internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_write));
  shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --epcs_flash_controller_epcs_control_port_address mux, which is an e_mux
  epcs_flash_controller_epcs_control_port_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port)) = '1'), (A_SRL(shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_instruction_master <= cpu_instruction_master_address_to_slave;
  --d1_epcs_flash_controller_epcs_control_port_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_epcs_flash_controller_epcs_control_port_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_epcs_flash_controller_epcs_control_port_end_xfer <= epcs_flash_controller_epcs_control_port_end_xfer;
    end if;

  end process;

  --epcs_flash_controller_epcs_control_port_waits_for_read in a cycle, which is an e_mux
  epcs_flash_controller_epcs_control_port_waits_for_read <= epcs_flash_controller_epcs_control_port_in_a_read_cycle AND epcs_flash_controller_epcs_control_port_begins_xfer;
  --epcs_flash_controller_epcs_control_port_in_a_read_cycle assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_in_a_read_cycle <= ((internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= epcs_flash_controller_epcs_control_port_in_a_read_cycle;
  --epcs_flash_controller_epcs_control_port_waits_for_write in a cycle, which is an e_mux
  epcs_flash_controller_epcs_control_port_waits_for_write <= epcs_flash_controller_epcs_control_port_in_a_write_cycle AND epcs_flash_controller_epcs_control_port_begins_xfer;
  --epcs_flash_controller_epcs_control_port_in_a_write_cycle assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_in_a_write_cycle <= internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= epcs_flash_controller_epcs_control_port_in_a_write_cycle;
  wait_for_epcs_flash_controller_epcs_control_port_counter <= std_logic'('0');
  --assign epcs_flash_controller_epcs_control_port_irq_from_sa = epcs_flash_controller_epcs_control_port_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_irq_from_sa <= epcs_flash_controller_epcs_control_port_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_epcs_flash_controller_epcs_control_port <= internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port <= internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_requests_epcs_flash_controller_epcs_control_port <= internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port <= internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port <= internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port <= internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port;
--synthesis translate_off
    --epcs_flash_controller/epcs_control_port enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line24 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line24, now);
          write(write_line24, string'(": "));
          write(write_line24, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line24.all);
          deallocate (write_line24);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line25 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_epcs_flash_controller_epcs_control_port))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_epcs_flash_controller_epcs_control_port))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line25, now);
          write(write_line25, string'(": "));
          write(write_line25, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line25.all);
          deallocate (write_line25);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity jtag_uart_avalon_jtag_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_irq : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal d1_jtag_uart_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_address : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity jtag_uart_avalon_jtag_slave_arbitrator;


architecture europa of jtag_uart_avalon_jtag_slave_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_allgrants :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_any_continuerequest :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_arb_counter_enable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_begins_xfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_grant_vector :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_in_a_read_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_in_a_write_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_master_qreq_vector :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_non_bursting_master_requests :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_reg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_slavearbiterlockenable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_unreg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waits_for_read :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_jtag_uart_avalon_jtag_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT jtag_uart_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  jtag_uart_avalon_jtag_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave);
  --assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_readdata_from_sa <= jtag_uart_avalon_jtag_slave_readdata;
  internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100000000000010000111100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_dataavailable_from_sa <= jtag_uart_avalon_jtag_slave_dataavailable;
  --assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_readyfordata_from_sa <= jtag_uart_avalon_jtag_slave_readyfordata;
  --assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa <= jtag_uart_avalon_jtag_slave_waitrequest;
  --jtag_uart_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  jtag_uart_avalon_jtag_slave_arb_share_set_values <= std_logic_vector'("01");
  --jtag_uart_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --jtag_uart_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(jtag_uart_avalon_jtag_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (jtag_uart_avalon_jtag_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (jtag_uart_avalon_jtag_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --jtag_uart_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  jtag_uart_avalon_jtag_slave_allgrants <= jtag_uart_avalon_jtag_slave_grant_vector;
  --jtag_uart_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_end_xfer <= NOT ((jtag_uart_avalon_jtag_slave_waits_for_read OR jtag_uart_avalon_jtag_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave <= jtag_uart_avalon_jtag_slave_end_xfer AND (((NOT jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --jtag_uart_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  jtag_uart_avalon_jtag_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND jtag_uart_avalon_jtag_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND NOT jtag_uart_avalon_jtag_slave_non_bursting_master_requests));
  --jtag_uart_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_avalon_jtag_slave_arb_counter_enable) = '1' then 
        jtag_uart_avalon_jtag_slave_arb_share_counter <= jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((jtag_uart_avalon_jtag_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave)) OR ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND NOT jtag_uart_avalon_jtag_slave_non_bursting_master_requests)))) = '1' then 
        jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= jtag_uart_avalon_jtag_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 <= or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter_next_value);
  --cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --jtag_uart_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  jtag_uart_avalon_jtag_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave, which is an e_mux
  cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave <= (internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_read) AND NOT jtag_uart_avalon_jtag_slave_waits_for_read;
  --jtag_uart_avalon_jtag_slave_writedata mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  --cpu/data_master saved-grant jtag_uart/avalon_jtag_slave, which is an e_assign
  cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --allow new arb cycle for jtag_uart/avalon_jtag_slave, which is an e_assign
  jtag_uart_avalon_jtag_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  jtag_uart_avalon_jtag_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  jtag_uart_avalon_jtag_slave_master_qreq_vector <= std_logic'('1');
  --jtag_uart_avalon_jtag_slave_reset_n assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_reset_n <= reset_n;
  jtag_uart_avalon_jtag_slave_chipselect <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  --jtag_uart_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  jtag_uart_avalon_jtag_slave_firsttransfer <= A_WE_StdLogic((std_logic'(jtag_uart_avalon_jtag_slave_begins_xfer) = '1'), jtag_uart_avalon_jtag_slave_unreg_firsttransfer, jtag_uart_avalon_jtag_slave_reg_firsttransfer);
  --jtag_uart_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  jtag_uart_avalon_jtag_slave_unreg_firsttransfer <= NOT ((jtag_uart_avalon_jtag_slave_slavearbiterlockenable AND jtag_uart_avalon_jtag_slave_any_continuerequest));
  --jtag_uart_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_avalon_jtag_slave_begins_xfer) = '1' then 
        jtag_uart_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  jtag_uart_avalon_jtag_slave_beginbursttransfer_internal <= jtag_uart_avalon_jtag_slave_begins_xfer;
  --~jtag_uart_avalon_jtag_slave_read_n assignment, which is an e_mux
  jtag_uart_avalon_jtag_slave_read_n <= NOT ((internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_read));
  --~jtag_uart_avalon_jtag_slave_write_n assignment, which is an e_mux
  jtag_uart_avalon_jtag_slave_write_n <= NOT ((internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_write));
  shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --jtag_uart_avalon_jtag_slave_address mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_jtag_uart_avalon_jtag_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_jtag_uart_avalon_jtag_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_jtag_uart_avalon_jtag_slave_end_xfer <= jtag_uart_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  jtag_uart_avalon_jtag_slave_waits_for_read <= jtag_uart_avalon_jtag_slave_in_a_read_cycle AND internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_in_a_read_cycle <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= jtag_uart_avalon_jtag_slave_in_a_read_cycle;
  --jtag_uart_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  jtag_uart_avalon_jtag_slave_waits_for_write <= jtag_uart_avalon_jtag_slave_in_a_write_cycle AND internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_in_a_write_cycle <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= jtag_uart_avalon_jtag_slave_in_a_write_cycle;
  wait_for_jtag_uart_avalon_jtag_slave_counter <= std_logic'('0');
  --assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_irq_from_sa <= jtag_uart_avalon_jtag_slave_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  jtag_uart_avalon_jtag_slave_waitrequest_from_sa <= internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
--synthesis translate_off
    --jtag_uart/avalon_jtag_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity out_test_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal out_test_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_out_test_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_out_test_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_out_test_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_out_test_s1 : OUT STD_LOGIC;
                 signal d1_out_test_s1_end_xfer : OUT STD_LOGIC;
                 signal out_test_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal out_test_s1_chipselect : OUT STD_LOGIC;
                 signal out_test_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal out_test_s1_reset_n : OUT STD_LOGIC;
                 signal out_test_s1_write_n : OUT STD_LOGIC;
                 signal out_test_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity out_test_s1_arbitrator;


architecture europa of out_test_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_out_test_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_out_test_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_out_test_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_out_test_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_out_test_s1 :  STD_LOGIC;
                signal out_test_s1_allgrants :  STD_LOGIC;
                signal out_test_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal out_test_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal out_test_s1_any_continuerequest :  STD_LOGIC;
                signal out_test_s1_arb_counter_enable :  STD_LOGIC;
                signal out_test_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal out_test_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal out_test_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal out_test_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal out_test_s1_begins_xfer :  STD_LOGIC;
                signal out_test_s1_end_xfer :  STD_LOGIC;
                signal out_test_s1_firsttransfer :  STD_LOGIC;
                signal out_test_s1_grant_vector :  STD_LOGIC;
                signal out_test_s1_in_a_read_cycle :  STD_LOGIC;
                signal out_test_s1_in_a_write_cycle :  STD_LOGIC;
                signal out_test_s1_master_qreq_vector :  STD_LOGIC;
                signal out_test_s1_non_bursting_master_requests :  STD_LOGIC;
                signal out_test_s1_reg_firsttransfer :  STD_LOGIC;
                signal out_test_s1_slavearbiterlockenable :  STD_LOGIC;
                signal out_test_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal out_test_s1_unreg_firsttransfer :  STD_LOGIC;
                signal out_test_s1_waits_for_read :  STD_LOGIC;
                signal out_test_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_out_test_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_out_test_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT out_test_s1_end_xfer;
    end if;

  end process;

  out_test_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_out_test_s1);
  --assign out_test_s1_readdata_from_sa = out_test_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  out_test_s1_readdata_from_sa <= out_test_s1_readdata;
  internal_cpu_data_master_requests_out_test_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000000000010000000100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --out_test_s1_arb_share_counter set values, which is an e_mux
  out_test_s1_arb_share_set_values <= std_logic_vector'("01");
  --out_test_s1_non_bursting_master_requests mux, which is an e_mux
  out_test_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_out_test_s1;
  --out_test_s1_any_bursting_master_saved_grant mux, which is an e_mux
  out_test_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --out_test_s1_arb_share_counter_next_value assignment, which is an e_assign
  out_test_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(out_test_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (out_test_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(out_test_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (out_test_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --out_test_s1_allgrants all slave grants, which is an e_mux
  out_test_s1_allgrants <= out_test_s1_grant_vector;
  --out_test_s1_end_xfer assignment, which is an e_assign
  out_test_s1_end_xfer <= NOT ((out_test_s1_waits_for_read OR out_test_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_out_test_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_out_test_s1 <= out_test_s1_end_xfer AND (((NOT out_test_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --out_test_s1_arb_share_counter arbitration counter enable, which is an e_assign
  out_test_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_out_test_s1 AND out_test_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_out_test_s1 AND NOT out_test_s1_non_bursting_master_requests));
  --out_test_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      out_test_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(out_test_s1_arb_counter_enable) = '1' then 
        out_test_s1_arb_share_counter <= out_test_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --out_test_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      out_test_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((out_test_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_out_test_s1)) OR ((end_xfer_arb_share_counter_term_out_test_s1 AND NOT out_test_s1_non_bursting_master_requests)))) = '1' then 
        out_test_s1_slavearbiterlockenable <= or_reduce(out_test_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master out_test/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= out_test_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --out_test_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  out_test_s1_slavearbiterlockenable2 <= or_reduce(out_test_s1_arb_share_counter_next_value);
  --cpu/data_master out_test/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= out_test_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --out_test_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  out_test_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_out_test_s1 <= internal_cpu_data_master_requests_out_test_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_out_test_s1, which is an e_mux
  cpu_data_master_read_data_valid_out_test_s1 <= (internal_cpu_data_master_granted_out_test_s1 AND cpu_data_master_read) AND NOT out_test_s1_waits_for_read;
  --out_test_s1_writedata mux, which is an e_mux
  out_test_s1_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_out_test_s1 <= internal_cpu_data_master_qualified_request_out_test_s1;
  --cpu/data_master saved-grant out_test/s1, which is an e_assign
  cpu_data_master_saved_grant_out_test_s1 <= internal_cpu_data_master_requests_out_test_s1;
  --allow new arb cycle for out_test/s1, which is an e_assign
  out_test_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  out_test_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  out_test_s1_master_qreq_vector <= std_logic'('1');
  --out_test_s1_reset_n assignment, which is an e_assign
  out_test_s1_reset_n <= reset_n;
  out_test_s1_chipselect <= internal_cpu_data_master_granted_out_test_s1;
  --out_test_s1_firsttransfer first transaction, which is an e_assign
  out_test_s1_firsttransfer <= A_WE_StdLogic((std_logic'(out_test_s1_begins_xfer) = '1'), out_test_s1_unreg_firsttransfer, out_test_s1_reg_firsttransfer);
  --out_test_s1_unreg_firsttransfer first transaction, which is an e_assign
  out_test_s1_unreg_firsttransfer <= NOT ((out_test_s1_slavearbiterlockenable AND out_test_s1_any_continuerequest));
  --out_test_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      out_test_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(out_test_s1_begins_xfer) = '1' then 
        out_test_s1_reg_firsttransfer <= out_test_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --out_test_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  out_test_s1_beginbursttransfer_internal <= out_test_s1_begins_xfer;
  --~out_test_s1_write_n assignment, which is an e_mux
  out_test_s1_write_n <= NOT ((internal_cpu_data_master_granted_out_test_s1 AND cpu_data_master_write));
  shifted_address_to_out_test_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --out_test_s1_address mux, which is an e_mux
  out_test_s1_address <= A_EXT (A_SRL(shifted_address_to_out_test_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_out_test_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_out_test_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_out_test_s1_end_xfer <= out_test_s1_end_xfer;
    end if;

  end process;

  --out_test_s1_waits_for_read in a cycle, which is an e_mux
  out_test_s1_waits_for_read <= out_test_s1_in_a_read_cycle AND out_test_s1_begins_xfer;
  --out_test_s1_in_a_read_cycle assignment, which is an e_assign
  out_test_s1_in_a_read_cycle <= internal_cpu_data_master_granted_out_test_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= out_test_s1_in_a_read_cycle;
  --out_test_s1_waits_for_write in a cycle, which is an e_mux
  out_test_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(out_test_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --out_test_s1_in_a_write_cycle assignment, which is an e_assign
  out_test_s1_in_a_write_cycle <= internal_cpu_data_master_granted_out_test_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= out_test_s1_in_a_write_cycle;
  wait_for_out_test_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_out_test_s1 <= internal_cpu_data_master_granted_out_test_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_out_test_s1 <= internal_cpu_data_master_qualified_request_out_test_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_out_test_s1 <= internal_cpu_data_master_requests_out_test_s1;
--synthesis translate_off
    --out_test/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pll_pll_slave_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_2_out_address_to_slave : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal NiosII_clock_2_out_read : IN STD_LOGIC;
                 signal NiosII_clock_2_out_write : IN STD_LOGIC;
                 signal NiosII_clock_2_out_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal pll_pll_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal NiosII_clock_2_out_granted_pll_pll_slave : OUT STD_LOGIC;
                 signal NiosII_clock_2_out_qualified_request_pll_pll_slave : OUT STD_LOGIC;
                 signal NiosII_clock_2_out_read_data_valid_pll_pll_slave : OUT STD_LOGIC;
                 signal NiosII_clock_2_out_requests_pll_pll_slave : OUT STD_LOGIC;
                 signal d1_pll_pll_slave_end_xfer : OUT STD_LOGIC;
                 signal pll_pll_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal pll_pll_slave_read : OUT STD_LOGIC;
                 signal pll_pll_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal pll_pll_slave_reset : OUT STD_LOGIC;
                 signal pll_pll_slave_write : OUT STD_LOGIC;
                 signal pll_pll_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity pll_pll_slave_arbitrator;


architecture europa of pll_pll_slave_arbitrator is
                signal NiosII_clock_2_out_arbiterlock :  STD_LOGIC;
                signal NiosII_clock_2_out_arbiterlock2 :  STD_LOGIC;
                signal NiosII_clock_2_out_continuerequest :  STD_LOGIC;
                signal NiosII_clock_2_out_saved_grant_pll_pll_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_pll_pll_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_NiosII_clock_2_out_granted_pll_pll_slave :  STD_LOGIC;
                signal internal_NiosII_clock_2_out_qualified_request_pll_pll_slave :  STD_LOGIC;
                signal internal_NiosII_clock_2_out_requests_pll_pll_slave :  STD_LOGIC;
                signal pll_pll_slave_allgrants :  STD_LOGIC;
                signal pll_pll_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal pll_pll_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal pll_pll_slave_any_continuerequest :  STD_LOGIC;
                signal pll_pll_slave_arb_counter_enable :  STD_LOGIC;
                signal pll_pll_slave_arb_share_counter :  STD_LOGIC;
                signal pll_pll_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal pll_pll_slave_arb_share_set_values :  STD_LOGIC;
                signal pll_pll_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal pll_pll_slave_begins_xfer :  STD_LOGIC;
                signal pll_pll_slave_end_xfer :  STD_LOGIC;
                signal pll_pll_slave_firsttransfer :  STD_LOGIC;
                signal pll_pll_slave_grant_vector :  STD_LOGIC;
                signal pll_pll_slave_in_a_read_cycle :  STD_LOGIC;
                signal pll_pll_slave_in_a_write_cycle :  STD_LOGIC;
                signal pll_pll_slave_master_qreq_vector :  STD_LOGIC;
                signal pll_pll_slave_non_bursting_master_requests :  STD_LOGIC;
                signal pll_pll_slave_reg_firsttransfer :  STD_LOGIC;
                signal pll_pll_slave_slavearbiterlockenable :  STD_LOGIC;
                signal pll_pll_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal pll_pll_slave_unreg_firsttransfer :  STD_LOGIC;
                signal pll_pll_slave_waits_for_read :  STD_LOGIC;
                signal pll_pll_slave_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_pll_pll_slave_from_NiosII_clock_2_out :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal wait_for_pll_pll_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT pll_pll_slave_end_xfer;
    end if;

  end process;

  pll_pll_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_NiosII_clock_2_out_qualified_request_pll_pll_slave);
  --assign pll_pll_slave_readdata_from_sa = pll_pll_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  pll_pll_slave_readdata_from_sa <= pll_pll_slave_readdata;
  internal_NiosII_clock_2_out_requests_pll_pll_slave <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_2_out_read OR NiosII_clock_2_out_write)))))));
  --pll_pll_slave_arb_share_counter set values, which is an e_mux
  pll_pll_slave_arb_share_set_values <= std_logic'('1');
  --pll_pll_slave_non_bursting_master_requests mux, which is an e_mux
  pll_pll_slave_non_bursting_master_requests <= internal_NiosII_clock_2_out_requests_pll_pll_slave;
  --pll_pll_slave_any_bursting_master_saved_grant mux, which is an e_mux
  pll_pll_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --pll_pll_slave_arb_share_counter_next_value assignment, which is an e_assign
  pll_pll_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(pll_pll_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pll_pll_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(pll_pll_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pll_pll_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --pll_pll_slave_allgrants all slave grants, which is an e_mux
  pll_pll_slave_allgrants <= pll_pll_slave_grant_vector;
  --pll_pll_slave_end_xfer assignment, which is an e_assign
  pll_pll_slave_end_xfer <= NOT ((pll_pll_slave_waits_for_read OR pll_pll_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_pll_pll_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_pll_pll_slave <= pll_pll_slave_end_xfer AND (((NOT pll_pll_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --pll_pll_slave_arb_share_counter arbitration counter enable, which is an e_assign
  pll_pll_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_pll_pll_slave AND pll_pll_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_pll_pll_slave AND NOT pll_pll_slave_non_bursting_master_requests));
  --pll_pll_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pll_pll_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(pll_pll_slave_arb_counter_enable) = '1' then 
        pll_pll_slave_arb_share_counter <= pll_pll_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --pll_pll_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pll_pll_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((pll_pll_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_pll_pll_slave)) OR ((end_xfer_arb_share_counter_term_pll_pll_slave AND NOT pll_pll_slave_non_bursting_master_requests)))) = '1' then 
        pll_pll_slave_slavearbiterlockenable <= pll_pll_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --NiosII_clock_2/out pll/pll_slave arbiterlock, which is an e_assign
  NiosII_clock_2_out_arbiterlock <= pll_pll_slave_slavearbiterlockenable AND NiosII_clock_2_out_continuerequest;
  --pll_pll_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  pll_pll_slave_slavearbiterlockenable2 <= pll_pll_slave_arb_share_counter_next_value;
  --NiosII_clock_2/out pll/pll_slave arbiterlock2, which is an e_assign
  NiosII_clock_2_out_arbiterlock2 <= pll_pll_slave_slavearbiterlockenable2 AND NiosII_clock_2_out_continuerequest;
  --pll_pll_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  pll_pll_slave_any_continuerequest <= std_logic'('1');
  --NiosII_clock_2_out_continuerequest continued request, which is an e_assign
  NiosII_clock_2_out_continuerequest <= std_logic'('1');
  internal_NiosII_clock_2_out_qualified_request_pll_pll_slave <= internal_NiosII_clock_2_out_requests_pll_pll_slave;
  --pll_pll_slave_writedata mux, which is an e_mux
  pll_pll_slave_writedata <= NiosII_clock_2_out_writedata;
  --master is always granted when requested
  internal_NiosII_clock_2_out_granted_pll_pll_slave <= internal_NiosII_clock_2_out_qualified_request_pll_pll_slave;
  --NiosII_clock_2/out saved-grant pll/pll_slave, which is an e_assign
  NiosII_clock_2_out_saved_grant_pll_pll_slave <= internal_NiosII_clock_2_out_requests_pll_pll_slave;
  --allow new arb cycle for pll/pll_slave, which is an e_assign
  pll_pll_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  pll_pll_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  pll_pll_slave_master_qreq_vector <= std_logic'('1');
  --~pll_pll_slave_reset assignment, which is an e_assign
  pll_pll_slave_reset <= NOT reset_n;
  --pll_pll_slave_firsttransfer first transaction, which is an e_assign
  pll_pll_slave_firsttransfer <= A_WE_StdLogic((std_logic'(pll_pll_slave_begins_xfer) = '1'), pll_pll_slave_unreg_firsttransfer, pll_pll_slave_reg_firsttransfer);
  --pll_pll_slave_unreg_firsttransfer first transaction, which is an e_assign
  pll_pll_slave_unreg_firsttransfer <= NOT ((pll_pll_slave_slavearbiterlockenable AND pll_pll_slave_any_continuerequest));
  --pll_pll_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      pll_pll_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(pll_pll_slave_begins_xfer) = '1' then 
        pll_pll_slave_reg_firsttransfer <= pll_pll_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --pll_pll_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  pll_pll_slave_beginbursttransfer_internal <= pll_pll_slave_begins_xfer;
  --pll_pll_slave_read assignment, which is an e_mux
  pll_pll_slave_read <= internal_NiosII_clock_2_out_granted_pll_pll_slave AND NiosII_clock_2_out_read;
  --pll_pll_slave_write assignment, which is an e_mux
  pll_pll_slave_write <= internal_NiosII_clock_2_out_granted_pll_pll_slave AND NiosII_clock_2_out_write;
  shifted_address_to_pll_pll_slave_from_NiosII_clock_2_out <= NiosII_clock_2_out_address_to_slave;
  --pll_pll_slave_address mux, which is an e_mux
  pll_pll_slave_address <= A_EXT (A_SRL(shifted_address_to_pll_pll_slave_from_NiosII_clock_2_out,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_pll_pll_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_pll_pll_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_pll_pll_slave_end_xfer <= pll_pll_slave_end_xfer;
    end if;

  end process;

  --pll_pll_slave_waits_for_read in a cycle, which is an e_mux
  pll_pll_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pll_pll_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --pll_pll_slave_in_a_read_cycle assignment, which is an e_assign
  pll_pll_slave_in_a_read_cycle <= internal_NiosII_clock_2_out_granted_pll_pll_slave AND NiosII_clock_2_out_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= pll_pll_slave_in_a_read_cycle;
  --pll_pll_slave_waits_for_write in a cycle, which is an e_mux
  pll_pll_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(pll_pll_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --pll_pll_slave_in_a_write_cycle assignment, which is an e_assign
  pll_pll_slave_in_a_write_cycle <= internal_NiosII_clock_2_out_granted_pll_pll_slave AND NiosII_clock_2_out_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= pll_pll_slave_in_a_write_cycle;
  wait_for_pll_pll_slave_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  NiosII_clock_2_out_granted_pll_pll_slave <= internal_NiosII_clock_2_out_granted_pll_pll_slave;
  --vhdl renameroo for output signals
  NiosII_clock_2_out_qualified_request_pll_pll_slave <= internal_NiosII_clock_2_out_qualified_request_pll_pll_slave;
  --vhdl renameroo for output signals
  NiosII_clock_2_out_requests_pll_pll_slave <= internal_NiosII_clock_2_out_requests_pll_pll_slave;
--synthesis translate_off
    --pll/pll_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sample_time_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal sample_time_s1_irq : IN STD_LOGIC;
                 signal sample_time_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_data_master_granted_sample_time_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_sample_time_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sample_time_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_sample_time_s1 : OUT STD_LOGIC;
                 signal d1_sample_time_s1_end_xfer : OUT STD_LOGIC;
                 signal sample_time_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal sample_time_s1_chipselect : OUT STD_LOGIC;
                 signal sample_time_s1_irq_from_sa : OUT STD_LOGIC;
                 signal sample_time_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sample_time_s1_reset_n : OUT STD_LOGIC;
                 signal sample_time_s1_write_n : OUT STD_LOGIC;
                 signal sample_time_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity sample_time_s1_arbitrator;


architecture europa of sample_time_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_sample_time_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sample_time_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_sample_time_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_sample_time_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_sample_time_s1 :  STD_LOGIC;
                signal sample_time_s1_allgrants :  STD_LOGIC;
                signal sample_time_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal sample_time_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sample_time_s1_any_continuerequest :  STD_LOGIC;
                signal sample_time_s1_arb_counter_enable :  STD_LOGIC;
                signal sample_time_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sample_time_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sample_time_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sample_time_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal sample_time_s1_begins_xfer :  STD_LOGIC;
                signal sample_time_s1_end_xfer :  STD_LOGIC;
                signal sample_time_s1_firsttransfer :  STD_LOGIC;
                signal sample_time_s1_grant_vector :  STD_LOGIC;
                signal sample_time_s1_in_a_read_cycle :  STD_LOGIC;
                signal sample_time_s1_in_a_write_cycle :  STD_LOGIC;
                signal sample_time_s1_master_qreq_vector :  STD_LOGIC;
                signal sample_time_s1_non_bursting_master_requests :  STD_LOGIC;
                signal sample_time_s1_reg_firsttransfer :  STD_LOGIC;
                signal sample_time_s1_slavearbiterlockenable :  STD_LOGIC;
                signal sample_time_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal sample_time_s1_unreg_firsttransfer :  STD_LOGIC;
                signal sample_time_s1_waits_for_read :  STD_LOGIC;
                signal sample_time_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_sample_time_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal wait_for_sample_time_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sample_time_s1_end_xfer;
    end if;

  end process;

  sample_time_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_sample_time_s1);
  --assign sample_time_s1_readdata_from_sa = sample_time_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sample_time_s1_readdata_from_sa <= sample_time_s1_readdata;
  internal_cpu_data_master_requests_sample_time_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000000000010000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --sample_time_s1_arb_share_counter set values, which is an e_mux
  sample_time_s1_arb_share_set_values <= std_logic_vector'("01");
  --sample_time_s1_non_bursting_master_requests mux, which is an e_mux
  sample_time_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_sample_time_s1;
  --sample_time_s1_any_bursting_master_saved_grant mux, which is an e_mux
  sample_time_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --sample_time_s1_arb_share_counter_next_value assignment, which is an e_assign
  sample_time_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sample_time_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (sample_time_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sample_time_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (sample_time_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --sample_time_s1_allgrants all slave grants, which is an e_mux
  sample_time_s1_allgrants <= sample_time_s1_grant_vector;
  --sample_time_s1_end_xfer assignment, which is an e_assign
  sample_time_s1_end_xfer <= NOT ((sample_time_s1_waits_for_read OR sample_time_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_sample_time_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sample_time_s1 <= sample_time_s1_end_xfer AND (((NOT sample_time_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sample_time_s1_arb_share_counter arbitration counter enable, which is an e_assign
  sample_time_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sample_time_s1 AND sample_time_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_sample_time_s1 AND NOT sample_time_s1_non_bursting_master_requests));
  --sample_time_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sample_time_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sample_time_s1_arb_counter_enable) = '1' then 
        sample_time_s1_arb_share_counter <= sample_time_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sample_time_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sample_time_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((sample_time_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_sample_time_s1)) OR ((end_xfer_arb_share_counter_term_sample_time_s1 AND NOT sample_time_s1_non_bursting_master_requests)))) = '1' then 
        sample_time_s1_slavearbiterlockenable <= or_reduce(sample_time_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master sample_time/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= sample_time_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --sample_time_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sample_time_s1_slavearbiterlockenable2 <= or_reduce(sample_time_s1_arb_share_counter_next_value);
  --cpu/data_master sample_time/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= sample_time_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --sample_time_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  sample_time_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_sample_time_s1 <= internal_cpu_data_master_requests_sample_time_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_sample_time_s1, which is an e_mux
  cpu_data_master_read_data_valid_sample_time_s1 <= (internal_cpu_data_master_granted_sample_time_s1 AND cpu_data_master_read) AND NOT sample_time_s1_waits_for_read;
  --sample_time_s1_writedata mux, which is an e_mux
  sample_time_s1_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_sample_time_s1 <= internal_cpu_data_master_qualified_request_sample_time_s1;
  --cpu/data_master saved-grant sample_time/s1, which is an e_assign
  cpu_data_master_saved_grant_sample_time_s1 <= internal_cpu_data_master_requests_sample_time_s1;
  --allow new arb cycle for sample_time/s1, which is an e_assign
  sample_time_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  sample_time_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  sample_time_s1_master_qreq_vector <= std_logic'('1');
  --sample_time_s1_reset_n assignment, which is an e_assign
  sample_time_s1_reset_n <= reset_n;
  sample_time_s1_chipselect <= internal_cpu_data_master_granted_sample_time_s1;
  --sample_time_s1_firsttransfer first transaction, which is an e_assign
  sample_time_s1_firsttransfer <= A_WE_StdLogic((std_logic'(sample_time_s1_begins_xfer) = '1'), sample_time_s1_unreg_firsttransfer, sample_time_s1_reg_firsttransfer);
  --sample_time_s1_unreg_firsttransfer first transaction, which is an e_assign
  sample_time_s1_unreg_firsttransfer <= NOT ((sample_time_s1_slavearbiterlockenable AND sample_time_s1_any_continuerequest));
  --sample_time_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sample_time_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sample_time_s1_begins_xfer) = '1' then 
        sample_time_s1_reg_firsttransfer <= sample_time_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sample_time_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sample_time_s1_beginbursttransfer_internal <= sample_time_s1_begins_xfer;
  --~sample_time_s1_write_n assignment, which is an e_mux
  sample_time_s1_write_n <= NOT ((internal_cpu_data_master_granted_sample_time_s1 AND cpu_data_master_write));
  shifted_address_to_sample_time_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --sample_time_s1_address mux, which is an e_mux
  sample_time_s1_address <= A_EXT (A_SRL(shifted_address_to_sample_time_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_sample_time_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sample_time_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sample_time_s1_end_xfer <= sample_time_s1_end_xfer;
    end if;

  end process;

  --sample_time_s1_waits_for_read in a cycle, which is an e_mux
  sample_time_s1_waits_for_read <= sample_time_s1_in_a_read_cycle AND sample_time_s1_begins_xfer;
  --sample_time_s1_in_a_read_cycle assignment, which is an e_assign
  sample_time_s1_in_a_read_cycle <= internal_cpu_data_master_granted_sample_time_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sample_time_s1_in_a_read_cycle;
  --sample_time_s1_waits_for_write in a cycle, which is an e_mux
  sample_time_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(sample_time_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --sample_time_s1_in_a_write_cycle assignment, which is an e_assign
  sample_time_s1_in_a_write_cycle <= internal_cpu_data_master_granted_sample_time_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sample_time_s1_in_a_write_cycle;
  wait_for_sample_time_s1_counter <= std_logic'('0');
  --assign sample_time_s1_irq_from_sa = sample_time_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  sample_time_s1_irq_from_sa <= sample_time_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_sample_time_s1 <= internal_cpu_data_master_granted_sample_time_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_sample_time_s1 <= internal_cpu_data_master_qualified_request_sample_time_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_sample_time_s1 <= internal_cpu_data_master_requests_sample_time_s1;
--synthesis translate_off
    --sample_time/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_NiosII_clock_0_out_to_sdram_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_NiosII_clock_0_out_to_sdram_s1_module;


architecture europa of rdv_fifo_for_NiosII_clock_0_out_to_sdram_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_NiosII_clock_1_out_to_sdram_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_NiosII_clock_1_out_to_sdram_s1_module;


architecture europa of rdv_fifo_for_NiosII_clock_1_out_to_sdram_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity sdram_s1_arbitrator is 
        port (
              -- inputs:
                 signal NiosII_clock_0_out_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal NiosII_clock_0_out_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal NiosII_clock_0_out_read : IN STD_LOGIC;
                 signal NiosII_clock_0_out_write : IN STD_LOGIC;
                 signal NiosII_clock_0_out_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal NiosII_clock_1_out_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal NiosII_clock_1_out_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal NiosII_clock_1_out_read : IN STD_LOGIC;
                 signal NiosII_clock_1_out_write : IN STD_LOGIC;
                 signal NiosII_clock_1_out_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_readdatavalid : IN STD_LOGIC;
                 signal sdram_s1_waitrequest : IN STD_LOGIC;

              -- outputs:
                 signal NiosII_clock_0_out_granted_sdram_s1 : OUT STD_LOGIC;
                 signal NiosII_clock_0_out_qualified_request_sdram_s1 : OUT STD_LOGIC;
                 signal NiosII_clock_0_out_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                 signal NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                 signal NiosII_clock_0_out_requests_sdram_s1 : OUT STD_LOGIC;
                 signal NiosII_clock_1_out_granted_sdram_s1 : OUT STD_LOGIC;
                 signal NiosII_clock_1_out_qualified_request_sdram_s1 : OUT STD_LOGIC;
                 signal NiosII_clock_1_out_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                 signal NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                 signal NiosII_clock_1_out_requests_sdram_s1 : OUT STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : OUT STD_LOGIC;
                 signal sdram_s1_address : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                 signal sdram_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal sdram_s1_chipselect : OUT STD_LOGIC;
                 signal sdram_s1_read_n : OUT STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_reset_n : OUT STD_LOGIC;
                 signal sdram_s1_waitrequest_from_sa : OUT STD_LOGIC;
                 signal sdram_s1_write_n : OUT STD_LOGIC;
                 signal sdram_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity sdram_s1_arbitrator;


architecture europa of sdram_s1_arbitrator is
component rdv_fifo_for_NiosII_clock_0_out_to_sdram_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_NiosII_clock_0_out_to_sdram_s1_module;

component rdv_fifo_for_NiosII_clock_1_out_to_sdram_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_NiosII_clock_1_out_to_sdram_s1_module;

                signal NiosII_clock_0_out_arbiterlock :  STD_LOGIC;
                signal NiosII_clock_0_out_arbiterlock2 :  STD_LOGIC;
                signal NiosII_clock_0_out_continuerequest :  STD_LOGIC;
                signal NiosII_clock_0_out_rdv_fifo_empty_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_0_out_rdv_fifo_output_from_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_0_out_saved_grant_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_1_out_arbiterlock :  STD_LOGIC;
                signal NiosII_clock_1_out_arbiterlock2 :  STD_LOGIC;
                signal NiosII_clock_1_out_continuerequest :  STD_LOGIC;
                signal NiosII_clock_1_out_rdv_fifo_empty_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_1_out_rdv_fifo_output_from_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_1_out_saved_grant_sdram_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sdram_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_NiosII_clock_0_out_granted_sdram_s1 :  STD_LOGIC;
                signal internal_NiosII_clock_0_out_qualified_request_sdram_s1 :  STD_LOGIC;
                signal internal_NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal internal_NiosII_clock_0_out_requests_sdram_s1 :  STD_LOGIC;
                signal internal_NiosII_clock_1_out_granted_sdram_s1 :  STD_LOGIC;
                signal internal_NiosII_clock_1_out_qualified_request_sdram_s1 :  STD_LOGIC;
                signal internal_NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal internal_NiosII_clock_1_out_requests_sdram_s1 :  STD_LOGIC;
                signal internal_sdram_s1_waitrequest_from_sa :  STD_LOGIC;
                signal last_cycle_NiosII_clock_0_out_granted_slave_sdram_s1 :  STD_LOGIC;
                signal last_cycle_NiosII_clock_1_out_granted_slave_sdram_s1 :  STD_LOGIC;
                signal module_input :  STD_LOGIC;
                signal module_input1 :  STD_LOGIC;
                signal module_input2 :  STD_LOGIC;
                signal module_input3 :  STD_LOGIC;
                signal module_input4 :  STD_LOGIC;
                signal module_input5 :  STD_LOGIC;
                signal sdram_s1_allgrants :  STD_LOGIC;
                signal sdram_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal sdram_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sdram_s1_any_continuerequest :  STD_LOGIC;
                signal sdram_s1_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_arb_counter_enable :  STD_LOGIC;
                signal sdram_s1_arb_share_counter :  STD_LOGIC;
                signal sdram_s1_arb_share_counter_next_value :  STD_LOGIC;
                signal sdram_s1_arb_share_set_values :  STD_LOGIC;
                signal sdram_s1_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_arbitration_holdoff_internal :  STD_LOGIC;
                signal sdram_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal sdram_s1_begins_xfer :  STD_LOGIC;
                signal sdram_s1_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal sdram_s1_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_end_xfer :  STD_LOGIC;
                signal sdram_s1_firsttransfer :  STD_LOGIC;
                signal sdram_s1_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_in_a_read_cycle :  STD_LOGIC;
                signal sdram_s1_in_a_write_cycle :  STD_LOGIC;
                signal sdram_s1_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_move_on_to_next_transaction :  STD_LOGIC;
                signal sdram_s1_non_bursting_master_requests :  STD_LOGIC;
                signal sdram_s1_readdatavalid_from_sa :  STD_LOGIC;
                signal sdram_s1_reg_firsttransfer :  STD_LOGIC;
                signal sdram_s1_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_slavearbiterlockenable :  STD_LOGIC;
                signal sdram_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal sdram_s1_unreg_firsttransfer :  STD_LOGIC;
                signal sdram_s1_waits_for_read :  STD_LOGIC;
                signal sdram_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_sdram_s1_from_NiosII_clock_0_out :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal shifted_address_to_sdram_s1_from_NiosII_clock_1_out :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_sdram_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sdram_s1_end_xfer;
    end if;

  end process;

  sdram_s1_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_NiosII_clock_0_out_qualified_request_sdram_s1 OR internal_NiosII_clock_1_out_qualified_request_sdram_s1));
  --assign sdram_s1_readdata_from_sa = sdram_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_s1_readdata_from_sa <= sdram_s1_readdata;
  internal_NiosII_clock_0_out_requests_sdram_s1 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_0_out_read OR NiosII_clock_0_out_write)))))));
  --assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_sdram_s1_waitrequest_from_sa <= sdram_s1_waitrequest;
  --assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_s1_readdatavalid_from_sa <= sdram_s1_readdatavalid;
  --sdram_s1_arb_share_counter set values, which is an e_mux
  sdram_s1_arb_share_set_values <= std_logic'('1');
  --sdram_s1_non_bursting_master_requests mux, which is an e_mux
  sdram_s1_non_bursting_master_requests <= ((internal_NiosII_clock_0_out_requests_sdram_s1 OR internal_NiosII_clock_1_out_requests_sdram_s1) OR internal_NiosII_clock_0_out_requests_sdram_s1) OR internal_NiosII_clock_1_out_requests_sdram_s1;
  --sdram_s1_any_bursting_master_saved_grant mux, which is an e_mux
  sdram_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --sdram_s1_arb_share_counter_next_value assignment, which is an e_assign
  sdram_s1_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(sdram_s1_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(sdram_s1_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(sdram_s1_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(sdram_s1_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --sdram_s1_allgrants all slave grants, which is an e_mux
  sdram_s1_allgrants <= (((or_reduce(sdram_s1_grant_vector)) OR (or_reduce(sdram_s1_grant_vector))) OR (or_reduce(sdram_s1_grant_vector))) OR (or_reduce(sdram_s1_grant_vector));
  --sdram_s1_end_xfer assignment, which is an e_assign
  sdram_s1_end_xfer <= NOT ((sdram_s1_waits_for_read OR sdram_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_sdram_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sdram_s1 <= sdram_s1_end_xfer AND (((NOT sdram_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sdram_s1_arb_share_counter arbitration counter enable, which is an e_assign
  sdram_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sdram_s1 AND sdram_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_sdram_s1 AND NOT sdram_s1_non_bursting_master_requests));
  --sdram_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_arb_counter_enable) = '1' then 
        sdram_s1_arb_share_counter <= sdram_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sdram_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(sdram_s1_master_qreq_vector) AND end_xfer_arb_share_counter_term_sdram_s1)) OR ((end_xfer_arb_share_counter_term_sdram_s1 AND NOT sdram_s1_non_bursting_master_requests)))) = '1' then 
        sdram_s1_slavearbiterlockenable <= sdram_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --NiosII_clock_0/out sdram/s1 arbiterlock, which is an e_assign
  NiosII_clock_0_out_arbiterlock <= sdram_s1_slavearbiterlockenable AND NiosII_clock_0_out_continuerequest;
  --sdram_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sdram_s1_slavearbiterlockenable2 <= sdram_s1_arb_share_counter_next_value;
  --NiosII_clock_0/out sdram/s1 arbiterlock2, which is an e_assign
  NiosII_clock_0_out_arbiterlock2 <= sdram_s1_slavearbiterlockenable2 AND NiosII_clock_0_out_continuerequest;
  --NiosII_clock_1/out sdram/s1 arbiterlock, which is an e_assign
  NiosII_clock_1_out_arbiterlock <= sdram_s1_slavearbiterlockenable AND NiosII_clock_1_out_continuerequest;
  --NiosII_clock_1/out sdram/s1 arbiterlock2, which is an e_assign
  NiosII_clock_1_out_arbiterlock2 <= sdram_s1_slavearbiterlockenable2 AND NiosII_clock_1_out_continuerequest;
  --NiosII_clock_1/out granted sdram/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_NiosII_clock_1_out_granted_slave_sdram_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_NiosII_clock_1_out_granted_slave_sdram_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(NiosII_clock_1_out_saved_grant_sdram_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_s1_arbitration_holdoff_internal OR NOT internal_NiosII_clock_1_out_requests_sdram_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_NiosII_clock_1_out_granted_slave_sdram_s1))))));
    end if;

  end process;

  --NiosII_clock_1_out_continuerequest continued request, which is an e_mux
  NiosII_clock_1_out_continuerequest <= last_cycle_NiosII_clock_1_out_granted_slave_sdram_s1 AND internal_NiosII_clock_1_out_requests_sdram_s1;
  --sdram_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  sdram_s1_any_continuerequest <= NiosII_clock_1_out_continuerequest OR NiosII_clock_0_out_continuerequest;
  internal_NiosII_clock_0_out_qualified_request_sdram_s1 <= internal_NiosII_clock_0_out_requests_sdram_s1 AND NOT ((((NiosII_clock_0_out_read AND (internal_NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register))) OR NiosII_clock_1_out_arbiterlock));
  --unique name for sdram_s1_move_on_to_next_transaction, which is an e_assign
  sdram_s1_move_on_to_next_transaction <= sdram_s1_readdatavalid_from_sa;
  --rdv_fifo_for_NiosII_clock_0_out_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_NiosII_clock_0_out_to_sdram_s1 : rdv_fifo_for_NiosII_clock_0_out_to_sdram_s1_module
    port map(
      data_out => NiosII_clock_0_out_rdv_fifo_output_from_sdram_s1,
      empty => open,
      fifo_contains_ones_n => NiosII_clock_0_out_rdv_fifo_empty_sdram_s1,
      full => open,
      clear_fifo => module_input,
      clk => clk,
      data_in => internal_NiosII_clock_0_out_granted_sdram_s1,
      read => sdram_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input1,
      write => module_input2
    );

  module_input <= std_logic'('0');
  module_input1 <= std_logic'('0');
  module_input2 <= in_a_read_cycle AND NOT sdram_s1_waits_for_read;

  internal_NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register <= NOT NiosII_clock_0_out_rdv_fifo_empty_sdram_s1;
  --local readdatavalid NiosII_clock_0_out_read_data_valid_sdram_s1, which is an e_mux
  NiosII_clock_0_out_read_data_valid_sdram_s1 <= ((sdram_s1_readdatavalid_from_sa AND NiosII_clock_0_out_rdv_fifo_output_from_sdram_s1)) AND NOT NiosII_clock_0_out_rdv_fifo_empty_sdram_s1;
  --sdram_s1_writedata mux, which is an e_mux
  sdram_s1_writedata <= A_WE_StdLogicVector((std_logic'((internal_NiosII_clock_0_out_granted_sdram_s1)) = '1'), NiosII_clock_0_out_writedata, NiosII_clock_1_out_writedata);
  internal_NiosII_clock_1_out_requests_sdram_s1 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((NiosII_clock_1_out_read OR NiosII_clock_1_out_write)))))));
  --NiosII_clock_0/out granted sdram/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_NiosII_clock_0_out_granted_slave_sdram_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_NiosII_clock_0_out_granted_slave_sdram_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(NiosII_clock_0_out_saved_grant_sdram_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_s1_arbitration_holdoff_internal OR NOT internal_NiosII_clock_0_out_requests_sdram_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_NiosII_clock_0_out_granted_slave_sdram_s1))))));
    end if;

  end process;

  --NiosII_clock_0_out_continuerequest continued request, which is an e_mux
  NiosII_clock_0_out_continuerequest <= last_cycle_NiosII_clock_0_out_granted_slave_sdram_s1 AND internal_NiosII_clock_0_out_requests_sdram_s1;
  internal_NiosII_clock_1_out_qualified_request_sdram_s1 <= internal_NiosII_clock_1_out_requests_sdram_s1 AND NOT ((((NiosII_clock_1_out_read AND (internal_NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register))) OR NiosII_clock_0_out_arbiterlock));
  --rdv_fifo_for_NiosII_clock_1_out_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_NiosII_clock_1_out_to_sdram_s1 : rdv_fifo_for_NiosII_clock_1_out_to_sdram_s1_module
    port map(
      data_out => NiosII_clock_1_out_rdv_fifo_output_from_sdram_s1,
      empty => open,
      fifo_contains_ones_n => NiosII_clock_1_out_rdv_fifo_empty_sdram_s1,
      full => open,
      clear_fifo => module_input3,
      clk => clk,
      data_in => internal_NiosII_clock_1_out_granted_sdram_s1,
      read => sdram_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input4,
      write => module_input5
    );

  module_input3 <= std_logic'('0');
  module_input4 <= std_logic'('0');
  module_input5 <= in_a_read_cycle AND NOT sdram_s1_waits_for_read;

  internal_NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register <= NOT NiosII_clock_1_out_rdv_fifo_empty_sdram_s1;
  --local readdatavalid NiosII_clock_1_out_read_data_valid_sdram_s1, which is an e_mux
  NiosII_clock_1_out_read_data_valid_sdram_s1 <= ((sdram_s1_readdatavalid_from_sa AND NiosII_clock_1_out_rdv_fifo_output_from_sdram_s1)) AND NOT NiosII_clock_1_out_rdv_fifo_empty_sdram_s1;
  --allow new arb cycle for sdram/s1, which is an e_assign
  sdram_s1_allow_new_arb_cycle <= NOT NiosII_clock_0_out_arbiterlock AND NOT NiosII_clock_1_out_arbiterlock;
  --NiosII_clock_1/out assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  sdram_s1_master_qreq_vector(0) <= internal_NiosII_clock_1_out_qualified_request_sdram_s1;
  --NiosII_clock_1/out grant sdram/s1, which is an e_assign
  internal_NiosII_clock_1_out_granted_sdram_s1 <= sdram_s1_grant_vector(0);
  --NiosII_clock_1/out saved-grant sdram/s1, which is an e_assign
  NiosII_clock_1_out_saved_grant_sdram_s1 <= sdram_s1_arb_winner(0) AND internal_NiosII_clock_1_out_requests_sdram_s1;
  --NiosII_clock_0/out assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  sdram_s1_master_qreq_vector(1) <= internal_NiosII_clock_0_out_qualified_request_sdram_s1;
  --NiosII_clock_0/out grant sdram/s1, which is an e_assign
  internal_NiosII_clock_0_out_granted_sdram_s1 <= sdram_s1_grant_vector(1);
  --NiosII_clock_0/out saved-grant sdram/s1, which is an e_assign
  NiosII_clock_0_out_saved_grant_sdram_s1 <= sdram_s1_arb_winner(1) AND internal_NiosII_clock_0_out_requests_sdram_s1;
  --sdram/s1 chosen-master double-vector, which is an e_assign
  sdram_s1_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((sdram_s1_master_qreq_vector & sdram_s1_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT sdram_s1_master_qreq_vector & NOT sdram_s1_master_qreq_vector))) + (std_logic_vector'("000") & (sdram_s1_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  sdram_s1_arb_winner <= A_WE_StdLogicVector((std_logic'(((sdram_s1_allow_new_arb_cycle AND or_reduce(sdram_s1_grant_vector)))) = '1'), sdram_s1_grant_vector, sdram_s1_saved_chosen_master_vector);
  --saved sdram_s1_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_allow_new_arb_cycle) = '1' then 
        sdram_s1_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(sdram_s1_grant_vector)) = '1'), sdram_s1_grant_vector, sdram_s1_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  sdram_s1_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((sdram_s1_chosen_master_double_vector(1) OR sdram_s1_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((sdram_s1_chosen_master_double_vector(0) OR sdram_s1_chosen_master_double_vector(2)))));
  --sdram/s1 chosen master rotated left, which is an e_assign
  sdram_s1_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(sdram_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(sdram_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --sdram/s1's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(sdram_s1_grant_vector)) = '1' then 
        sdram_s1_arb_addend <= A_WE_StdLogicVector((std_logic'(sdram_s1_end_xfer) = '1'), sdram_s1_chosen_master_rot_left, sdram_s1_grant_vector);
      end if;
    end if;

  end process;

  --sdram_s1_reset_n assignment, which is an e_assign
  sdram_s1_reset_n <= reset_n;
  sdram_s1_chipselect <= internal_NiosII_clock_0_out_granted_sdram_s1 OR internal_NiosII_clock_1_out_granted_sdram_s1;
  --sdram_s1_firsttransfer first transaction, which is an e_assign
  sdram_s1_firsttransfer <= A_WE_StdLogic((std_logic'(sdram_s1_begins_xfer) = '1'), sdram_s1_unreg_firsttransfer, sdram_s1_reg_firsttransfer);
  --sdram_s1_unreg_firsttransfer first transaction, which is an e_assign
  sdram_s1_unreg_firsttransfer <= NOT ((sdram_s1_slavearbiterlockenable AND sdram_s1_any_continuerequest));
  --sdram_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_begins_xfer) = '1' then 
        sdram_s1_reg_firsttransfer <= sdram_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sdram_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sdram_s1_beginbursttransfer_internal <= sdram_s1_begins_xfer;
  --sdram_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  sdram_s1_arbitration_holdoff_internal <= sdram_s1_begins_xfer AND sdram_s1_firsttransfer;
  --~sdram_s1_read_n assignment, which is an e_mux
  sdram_s1_read_n <= NOT ((((internal_NiosII_clock_0_out_granted_sdram_s1 AND NiosII_clock_0_out_read)) OR ((internal_NiosII_clock_1_out_granted_sdram_s1 AND NiosII_clock_1_out_read))));
  --~sdram_s1_write_n assignment, which is an e_mux
  sdram_s1_write_n <= NOT ((((internal_NiosII_clock_0_out_granted_sdram_s1 AND NiosII_clock_0_out_write)) OR ((internal_NiosII_clock_1_out_granted_sdram_s1 AND NiosII_clock_1_out_write))));
  shifted_address_to_sdram_s1_from_NiosII_clock_0_out <= NiosII_clock_0_out_address_to_slave;
  --sdram_s1_address mux, which is an e_mux
  sdram_s1_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_NiosII_clock_0_out_granted_sdram_s1)) = '1'), (A_SRL(shifted_address_to_sdram_s1_from_NiosII_clock_0_out,std_logic_vector'("00000000000000000000000000000001"))), (A_SRL(shifted_address_to_sdram_s1_from_NiosII_clock_1_out,std_logic_vector'("00000000000000000000000000000001")))), 24);
  shifted_address_to_sdram_s1_from_NiosII_clock_1_out <= NiosII_clock_1_out_address_to_slave;
  --d1_sdram_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sdram_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sdram_s1_end_xfer <= sdram_s1_end_xfer;
    end if;

  end process;

  --sdram_s1_waits_for_read in a cycle, which is an e_mux
  sdram_s1_waits_for_read <= sdram_s1_in_a_read_cycle AND internal_sdram_s1_waitrequest_from_sa;
  --sdram_s1_in_a_read_cycle assignment, which is an e_assign
  sdram_s1_in_a_read_cycle <= ((internal_NiosII_clock_0_out_granted_sdram_s1 AND NiosII_clock_0_out_read)) OR ((internal_NiosII_clock_1_out_granted_sdram_s1 AND NiosII_clock_1_out_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sdram_s1_in_a_read_cycle;
  --sdram_s1_waits_for_write in a cycle, which is an e_mux
  sdram_s1_waits_for_write <= sdram_s1_in_a_write_cycle AND internal_sdram_s1_waitrequest_from_sa;
  --sdram_s1_in_a_write_cycle assignment, which is an e_assign
  sdram_s1_in_a_write_cycle <= ((internal_NiosII_clock_0_out_granted_sdram_s1 AND NiosII_clock_0_out_write)) OR ((internal_NiosII_clock_1_out_granted_sdram_s1 AND NiosII_clock_1_out_write));
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sdram_s1_in_a_write_cycle;
  wait_for_sdram_s1_counter <= std_logic'('0');
  --~sdram_s1_byteenable_n byte enable port mux, which is an e_mux
  sdram_s1_byteenable_n <= A_EXT (NOT (A_WE_StdLogicVector((std_logic'((internal_NiosII_clock_0_out_granted_sdram_s1)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (NiosII_clock_0_out_byteenable)), A_WE_StdLogicVector((std_logic'((internal_NiosII_clock_1_out_granted_sdram_s1)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (NiosII_clock_1_out_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))))), 2);
  --vhdl renameroo for output signals
  NiosII_clock_0_out_granted_sdram_s1 <= internal_NiosII_clock_0_out_granted_sdram_s1;
  --vhdl renameroo for output signals
  NiosII_clock_0_out_qualified_request_sdram_s1 <= internal_NiosII_clock_0_out_qualified_request_sdram_s1;
  --vhdl renameroo for output signals
  NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register <= internal_NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register;
  --vhdl renameroo for output signals
  NiosII_clock_0_out_requests_sdram_s1 <= internal_NiosII_clock_0_out_requests_sdram_s1;
  --vhdl renameroo for output signals
  NiosII_clock_1_out_granted_sdram_s1 <= internal_NiosII_clock_1_out_granted_sdram_s1;
  --vhdl renameroo for output signals
  NiosII_clock_1_out_qualified_request_sdram_s1 <= internal_NiosII_clock_1_out_qualified_request_sdram_s1;
  --vhdl renameroo for output signals
  NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register <= internal_NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register;
  --vhdl renameroo for output signals
  NiosII_clock_1_out_requests_sdram_s1 <= internal_NiosII_clock_1_out_requests_sdram_s1;
  --vhdl renameroo for output signals
  sdram_s1_waitrequest_from_sa <= internal_sdram_s1_waitrequest_from_sa;
--synthesis translate_off
    --sdram/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line26 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_NiosII_clock_0_out_granted_sdram_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_NiosII_clock_1_out_granted_sdram_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line26, now);
          write(write_line26, string'(": "));
          write(write_line26, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line26.all);
          deallocate (write_line26);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line27 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(NiosII_clock_0_out_saved_grant_sdram_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(NiosII_clock_1_out_saved_grant_sdram_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line27, now);
          write(write_line27, string'(": "));
          write(write_line27, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line27.all);
          deallocate (write_line27);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sysid_control_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sysid_control_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal cpu_data_master_granted_sysid_control_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_sysid_control_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sysid_control_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_sysid_control_slave : OUT STD_LOGIC;
                 signal d1_sysid_control_slave_end_xfer : OUT STD_LOGIC;
                 signal sysid_control_slave_address : OUT STD_LOGIC;
                 signal sysid_control_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal sysid_control_slave_reset_n : OUT STD_LOGIC
              );
end entity sysid_control_slave_arbitrator;


architecture europa of sysid_control_slave_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_sysid_control_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sysid_control_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_sysid_control_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_sysid_control_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_sysid_control_slave :  STD_LOGIC;
                signal shifted_address_to_sysid_control_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal sysid_control_slave_allgrants :  STD_LOGIC;
                signal sysid_control_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal sysid_control_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sysid_control_slave_any_continuerequest :  STD_LOGIC;
                signal sysid_control_slave_arb_counter_enable :  STD_LOGIC;
                signal sysid_control_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sysid_control_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sysid_control_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sysid_control_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal sysid_control_slave_begins_xfer :  STD_LOGIC;
                signal sysid_control_slave_end_xfer :  STD_LOGIC;
                signal sysid_control_slave_firsttransfer :  STD_LOGIC;
                signal sysid_control_slave_grant_vector :  STD_LOGIC;
                signal sysid_control_slave_in_a_read_cycle :  STD_LOGIC;
                signal sysid_control_slave_in_a_write_cycle :  STD_LOGIC;
                signal sysid_control_slave_master_qreq_vector :  STD_LOGIC;
                signal sysid_control_slave_non_bursting_master_requests :  STD_LOGIC;
                signal sysid_control_slave_reg_firsttransfer :  STD_LOGIC;
                signal sysid_control_slave_slavearbiterlockenable :  STD_LOGIC;
                signal sysid_control_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal sysid_control_slave_unreg_firsttransfer :  STD_LOGIC;
                signal sysid_control_slave_waits_for_read :  STD_LOGIC;
                signal sysid_control_slave_waits_for_write :  STD_LOGIC;
                signal wait_for_sysid_control_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sysid_control_slave_end_xfer;
    end if;

  end process;

  sysid_control_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_sysid_control_slave);
  --assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sysid_control_slave_readdata_from_sa <= sysid_control_slave_readdata;
  internal_cpu_data_master_requests_sysid_control_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100000000000010000111101000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --sysid_control_slave_arb_share_counter set values, which is an e_mux
  sysid_control_slave_arb_share_set_values <= std_logic_vector'("01");
  --sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  sysid_control_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_sysid_control_slave;
  --sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  sysid_control_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  sysid_control_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sysid_control_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (sysid_control_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sysid_control_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (sysid_control_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --sysid_control_slave_allgrants all slave grants, which is an e_mux
  sysid_control_slave_allgrants <= sysid_control_slave_grant_vector;
  --sysid_control_slave_end_xfer assignment, which is an e_assign
  sysid_control_slave_end_xfer <= NOT ((sysid_control_slave_waits_for_read OR sysid_control_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sysid_control_slave <= sysid_control_slave_end_xfer AND (((NOT sysid_control_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  sysid_control_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sysid_control_slave AND sysid_control_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_sysid_control_slave AND NOT sysid_control_slave_non_bursting_master_requests));
  --sysid_control_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_control_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sysid_control_slave_arb_counter_enable) = '1' then 
        sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_control_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((sysid_control_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_sysid_control_slave)) OR ((end_xfer_arb_share_counter_term_sysid_control_slave AND NOT sysid_control_slave_non_bursting_master_requests)))) = '1' then 
        sysid_control_slave_slavearbiterlockenable <= or_reduce(sysid_control_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master sysid/control_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= sysid_control_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sysid_control_slave_slavearbiterlockenable2 <= or_reduce(sysid_control_slave_arb_share_counter_next_value);
  --cpu/data_master sysid/control_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= sysid_control_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  sysid_control_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_sysid_control_slave <= internal_cpu_data_master_requests_sysid_control_slave AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_sysid_control_slave, which is an e_mux
  cpu_data_master_read_data_valid_sysid_control_slave <= (internal_cpu_data_master_granted_sysid_control_slave AND cpu_data_master_read) AND NOT sysid_control_slave_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_sysid_control_slave <= internal_cpu_data_master_qualified_request_sysid_control_slave;
  --cpu/data_master saved-grant sysid/control_slave, which is an e_assign
  cpu_data_master_saved_grant_sysid_control_slave <= internal_cpu_data_master_requests_sysid_control_slave;
  --allow new arb cycle for sysid/control_slave, which is an e_assign
  sysid_control_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  sysid_control_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  sysid_control_slave_master_qreq_vector <= std_logic'('1');
  --sysid_control_slave_reset_n assignment, which is an e_assign
  sysid_control_slave_reset_n <= reset_n;
  --sysid_control_slave_firsttransfer first transaction, which is an e_assign
  sysid_control_slave_firsttransfer <= A_WE_StdLogic((std_logic'(sysid_control_slave_begins_xfer) = '1'), sysid_control_slave_unreg_firsttransfer, sysid_control_slave_reg_firsttransfer);
  --sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  sysid_control_slave_unreg_firsttransfer <= NOT ((sysid_control_slave_slavearbiterlockenable AND sysid_control_slave_any_continuerequest));
  --sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_control_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sysid_control_slave_begins_xfer) = '1' then 
        sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sysid_control_slave_beginbursttransfer_internal <= sysid_control_slave_begins_xfer;
  shifted_address_to_sysid_control_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --sysid_control_slave_address mux, which is an e_mux
  sysid_control_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_sysid_control_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_sysid_control_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sysid_control_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end if;

  end process;

  --sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  sysid_control_slave_waits_for_read <= sysid_control_slave_in_a_read_cycle AND sysid_control_slave_begins_xfer;
  --sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  sysid_control_slave_in_a_read_cycle <= internal_cpu_data_master_granted_sysid_control_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sysid_control_slave_in_a_read_cycle;
  --sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  sysid_control_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(sysid_control_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  sysid_control_slave_in_a_write_cycle <= internal_cpu_data_master_granted_sysid_control_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sysid_control_slave_in_a_write_cycle;
  wait_for_sysid_control_slave_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_sysid_control_slave <= internal_cpu_data_master_granted_sysid_control_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_sysid_control_slave <= internal_cpu_data_master_qualified_request_sysid_control_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_sysid_control_slave <= internal_cpu_data_master_requests_sysid_control_slave;
--synthesis translate_off
    --sysid/control_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity timer_ONOF_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal timer_ONOF_s1_irq : IN STD_LOGIC;
                 signal timer_ONOF_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_data_master_granted_timer_ONOF_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_timer_ONOF_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_timer_ONOF_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_timer_ONOF_s1 : OUT STD_LOGIC;
                 signal d1_timer_ONOF_s1_end_xfer : OUT STD_LOGIC;
                 signal timer_ONOF_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal timer_ONOF_s1_chipselect : OUT STD_LOGIC;
                 signal timer_ONOF_s1_irq_from_sa : OUT STD_LOGIC;
                 signal timer_ONOF_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal timer_ONOF_s1_reset_n : OUT STD_LOGIC;
                 signal timer_ONOF_s1_write_n : OUT STD_LOGIC;
                 signal timer_ONOF_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity timer_ONOF_s1_arbitrator;


architecture europa of timer_ONOF_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_timer_ONOF_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_timer_ONOF_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_timer_ONOF_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_timer_ONOF_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_timer_ONOF_s1 :  STD_LOGIC;
                signal shifted_address_to_timer_ONOF_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal timer_ONOF_s1_allgrants :  STD_LOGIC;
                signal timer_ONOF_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal timer_ONOF_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal timer_ONOF_s1_any_continuerequest :  STD_LOGIC;
                signal timer_ONOF_s1_arb_counter_enable :  STD_LOGIC;
                signal timer_ONOF_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal timer_ONOF_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal timer_ONOF_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal timer_ONOF_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal timer_ONOF_s1_begins_xfer :  STD_LOGIC;
                signal timer_ONOF_s1_end_xfer :  STD_LOGIC;
                signal timer_ONOF_s1_firsttransfer :  STD_LOGIC;
                signal timer_ONOF_s1_grant_vector :  STD_LOGIC;
                signal timer_ONOF_s1_in_a_read_cycle :  STD_LOGIC;
                signal timer_ONOF_s1_in_a_write_cycle :  STD_LOGIC;
                signal timer_ONOF_s1_master_qreq_vector :  STD_LOGIC;
                signal timer_ONOF_s1_non_bursting_master_requests :  STD_LOGIC;
                signal timer_ONOF_s1_reg_firsttransfer :  STD_LOGIC;
                signal timer_ONOF_s1_slavearbiterlockenable :  STD_LOGIC;
                signal timer_ONOF_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal timer_ONOF_s1_unreg_firsttransfer :  STD_LOGIC;
                signal timer_ONOF_s1_waits_for_read :  STD_LOGIC;
                signal timer_ONOF_s1_waits_for_write :  STD_LOGIC;
                signal wait_for_timer_ONOF_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT timer_ONOF_s1_end_xfer;
    end if;

  end process;

  timer_ONOF_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_timer_ONOF_s1);
  --assign timer_ONOF_s1_readdata_from_sa = timer_ONOF_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  timer_ONOF_s1_readdata_from_sa <= timer_ONOF_s1_readdata;
  internal_cpu_data_master_requests_timer_ONOF_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000000000010000010000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --timer_ONOF_s1_arb_share_counter set values, which is an e_mux
  timer_ONOF_s1_arb_share_set_values <= std_logic_vector'("01");
  --timer_ONOF_s1_non_bursting_master_requests mux, which is an e_mux
  timer_ONOF_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_timer_ONOF_s1;
  --timer_ONOF_s1_any_bursting_master_saved_grant mux, which is an e_mux
  timer_ONOF_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --timer_ONOF_s1_arb_share_counter_next_value assignment, which is an e_assign
  timer_ONOF_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(timer_ONOF_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (timer_ONOF_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(timer_ONOF_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (timer_ONOF_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --timer_ONOF_s1_allgrants all slave grants, which is an e_mux
  timer_ONOF_s1_allgrants <= timer_ONOF_s1_grant_vector;
  --timer_ONOF_s1_end_xfer assignment, which is an e_assign
  timer_ONOF_s1_end_xfer <= NOT ((timer_ONOF_s1_waits_for_read OR timer_ONOF_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_timer_ONOF_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_timer_ONOF_s1 <= timer_ONOF_s1_end_xfer AND (((NOT timer_ONOF_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --timer_ONOF_s1_arb_share_counter arbitration counter enable, which is an e_assign
  timer_ONOF_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_timer_ONOF_s1 AND timer_ONOF_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_timer_ONOF_s1 AND NOT timer_ONOF_s1_non_bursting_master_requests));
  --timer_ONOF_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_ONOF_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(timer_ONOF_s1_arb_counter_enable) = '1' then 
        timer_ONOF_s1_arb_share_counter <= timer_ONOF_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --timer_ONOF_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_ONOF_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((timer_ONOF_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_timer_ONOF_s1)) OR ((end_xfer_arb_share_counter_term_timer_ONOF_s1 AND NOT timer_ONOF_s1_non_bursting_master_requests)))) = '1' then 
        timer_ONOF_s1_slavearbiterlockenable <= or_reduce(timer_ONOF_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master timer_ONOF/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= timer_ONOF_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --timer_ONOF_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  timer_ONOF_s1_slavearbiterlockenable2 <= or_reduce(timer_ONOF_s1_arb_share_counter_next_value);
  --cpu/data_master timer_ONOF/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= timer_ONOF_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --timer_ONOF_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  timer_ONOF_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_timer_ONOF_s1 <= internal_cpu_data_master_requests_timer_ONOF_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_timer_ONOF_s1, which is an e_mux
  cpu_data_master_read_data_valid_timer_ONOF_s1 <= (internal_cpu_data_master_granted_timer_ONOF_s1 AND cpu_data_master_read) AND NOT timer_ONOF_s1_waits_for_read;
  --timer_ONOF_s1_writedata mux, which is an e_mux
  timer_ONOF_s1_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_timer_ONOF_s1 <= internal_cpu_data_master_qualified_request_timer_ONOF_s1;
  --cpu/data_master saved-grant timer_ONOF/s1, which is an e_assign
  cpu_data_master_saved_grant_timer_ONOF_s1 <= internal_cpu_data_master_requests_timer_ONOF_s1;
  --allow new arb cycle for timer_ONOF/s1, which is an e_assign
  timer_ONOF_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  timer_ONOF_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  timer_ONOF_s1_master_qreq_vector <= std_logic'('1');
  --timer_ONOF_s1_reset_n assignment, which is an e_assign
  timer_ONOF_s1_reset_n <= reset_n;
  timer_ONOF_s1_chipselect <= internal_cpu_data_master_granted_timer_ONOF_s1;
  --timer_ONOF_s1_firsttransfer first transaction, which is an e_assign
  timer_ONOF_s1_firsttransfer <= A_WE_StdLogic((std_logic'(timer_ONOF_s1_begins_xfer) = '1'), timer_ONOF_s1_unreg_firsttransfer, timer_ONOF_s1_reg_firsttransfer);
  --timer_ONOF_s1_unreg_firsttransfer first transaction, which is an e_assign
  timer_ONOF_s1_unreg_firsttransfer <= NOT ((timer_ONOF_s1_slavearbiterlockenable AND timer_ONOF_s1_any_continuerequest));
  --timer_ONOF_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_ONOF_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(timer_ONOF_s1_begins_xfer) = '1' then 
        timer_ONOF_s1_reg_firsttransfer <= timer_ONOF_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --timer_ONOF_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  timer_ONOF_s1_beginbursttransfer_internal <= timer_ONOF_s1_begins_xfer;
  --~timer_ONOF_s1_write_n assignment, which is an e_mux
  timer_ONOF_s1_write_n <= NOT ((internal_cpu_data_master_granted_timer_ONOF_s1 AND cpu_data_master_write));
  shifted_address_to_timer_ONOF_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --timer_ONOF_s1_address mux, which is an e_mux
  timer_ONOF_s1_address <= A_EXT (A_SRL(shifted_address_to_timer_ONOF_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_timer_ONOF_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_timer_ONOF_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_timer_ONOF_s1_end_xfer <= timer_ONOF_s1_end_xfer;
    end if;

  end process;

  --timer_ONOF_s1_waits_for_read in a cycle, which is an e_mux
  timer_ONOF_s1_waits_for_read <= timer_ONOF_s1_in_a_read_cycle AND timer_ONOF_s1_begins_xfer;
  --timer_ONOF_s1_in_a_read_cycle assignment, which is an e_assign
  timer_ONOF_s1_in_a_read_cycle <= internal_cpu_data_master_granted_timer_ONOF_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= timer_ONOF_s1_in_a_read_cycle;
  --timer_ONOF_s1_waits_for_write in a cycle, which is an e_mux
  timer_ONOF_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(timer_ONOF_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --timer_ONOF_s1_in_a_write_cycle assignment, which is an e_assign
  timer_ONOF_s1_in_a_write_cycle <= internal_cpu_data_master_granted_timer_ONOF_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= timer_ONOF_s1_in_a_write_cycle;
  wait_for_timer_ONOF_s1_counter <= std_logic'('0');
  --assign timer_ONOF_s1_irq_from_sa = timer_ONOF_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  timer_ONOF_s1_irq_from_sa <= timer_ONOF_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_timer_ONOF_s1 <= internal_cpu_data_master_granted_timer_ONOF_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_timer_ONOF_s1 <= internal_cpu_data_master_qualified_request_timer_ONOF_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_timer_ONOF_s1 <= internal_cpu_data_master_requests_timer_ONOF_s1;
--synthesis translate_off
    --timer_ONOF/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity uart_gps_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal uart_gps_s1_dataavailable : IN STD_LOGIC;
                 signal uart_gps_s1_irq : IN STD_LOGIC;
                 signal uart_gps_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_gps_s1_readyfordata : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_uart_gps_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_uart_gps_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_uart_gps_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_uart_gps_s1 : OUT STD_LOGIC;
                 signal d1_uart_gps_s1_end_xfer : OUT STD_LOGIC;
                 signal uart_gps_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal uart_gps_s1_begintransfer : OUT STD_LOGIC;
                 signal uart_gps_s1_chipselect : OUT STD_LOGIC;
                 signal uart_gps_s1_dataavailable_from_sa : OUT STD_LOGIC;
                 signal uart_gps_s1_irq_from_sa : OUT STD_LOGIC;
                 signal uart_gps_s1_read_n : OUT STD_LOGIC;
                 signal uart_gps_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_gps_s1_readyfordata_from_sa : OUT STD_LOGIC;
                 signal uart_gps_s1_reset_n : OUT STD_LOGIC;
                 signal uart_gps_s1_write_n : OUT STD_LOGIC;
                 signal uart_gps_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity uart_gps_s1_arbitrator;


architecture europa of uart_gps_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_uart_gps_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_uart_gps_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_uart_gps_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_uart_gps_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_uart_gps_s1 :  STD_LOGIC;
                signal shifted_address_to_uart_gps_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal uart_gps_s1_allgrants :  STD_LOGIC;
                signal uart_gps_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal uart_gps_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal uart_gps_s1_any_continuerequest :  STD_LOGIC;
                signal uart_gps_s1_arb_counter_enable :  STD_LOGIC;
                signal uart_gps_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal uart_gps_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal uart_gps_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal uart_gps_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal uart_gps_s1_begins_xfer :  STD_LOGIC;
                signal uart_gps_s1_end_xfer :  STD_LOGIC;
                signal uart_gps_s1_firsttransfer :  STD_LOGIC;
                signal uart_gps_s1_grant_vector :  STD_LOGIC;
                signal uart_gps_s1_in_a_read_cycle :  STD_LOGIC;
                signal uart_gps_s1_in_a_write_cycle :  STD_LOGIC;
                signal uart_gps_s1_master_qreq_vector :  STD_LOGIC;
                signal uart_gps_s1_non_bursting_master_requests :  STD_LOGIC;
                signal uart_gps_s1_reg_firsttransfer :  STD_LOGIC;
                signal uart_gps_s1_slavearbiterlockenable :  STD_LOGIC;
                signal uart_gps_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal uart_gps_s1_unreg_firsttransfer :  STD_LOGIC;
                signal uart_gps_s1_waits_for_read :  STD_LOGIC;
                signal uart_gps_s1_waits_for_write :  STD_LOGIC;
                signal wait_for_uart_gps_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT uart_gps_s1_end_xfer;
    end if;

  end process;

  uart_gps_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_uart_gps_s1);
  --assign uart_gps_s1_readdata_from_sa = uart_gps_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_gps_s1_readdata_from_sa <= uart_gps_s1_readdata;
  internal_cpu_data_master_requests_uart_gps_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000000000010000001000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign uart_gps_s1_dataavailable_from_sa = uart_gps_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_gps_s1_dataavailable_from_sa <= uart_gps_s1_dataavailable;
  --assign uart_gps_s1_readyfordata_from_sa = uart_gps_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_gps_s1_readyfordata_from_sa <= uart_gps_s1_readyfordata;
  --uart_gps_s1_arb_share_counter set values, which is an e_mux
  uart_gps_s1_arb_share_set_values <= std_logic_vector'("01");
  --uart_gps_s1_non_bursting_master_requests mux, which is an e_mux
  uart_gps_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_uart_gps_s1;
  --uart_gps_s1_any_bursting_master_saved_grant mux, which is an e_mux
  uart_gps_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --uart_gps_s1_arb_share_counter_next_value assignment, which is an e_assign
  uart_gps_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(uart_gps_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (uart_gps_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(uart_gps_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (uart_gps_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --uart_gps_s1_allgrants all slave grants, which is an e_mux
  uart_gps_s1_allgrants <= uart_gps_s1_grant_vector;
  --uart_gps_s1_end_xfer assignment, which is an e_assign
  uart_gps_s1_end_xfer <= NOT ((uart_gps_s1_waits_for_read OR uart_gps_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_uart_gps_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_uart_gps_s1 <= uart_gps_s1_end_xfer AND (((NOT uart_gps_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --uart_gps_s1_arb_share_counter arbitration counter enable, which is an e_assign
  uart_gps_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_uart_gps_s1 AND uart_gps_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_uart_gps_s1 AND NOT uart_gps_s1_non_bursting_master_requests));
  --uart_gps_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_gps_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(uart_gps_s1_arb_counter_enable) = '1' then 
        uart_gps_s1_arb_share_counter <= uart_gps_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --uart_gps_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_gps_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((uart_gps_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_uart_gps_s1)) OR ((end_xfer_arb_share_counter_term_uart_gps_s1 AND NOT uart_gps_s1_non_bursting_master_requests)))) = '1' then 
        uart_gps_s1_slavearbiterlockenable <= or_reduce(uart_gps_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master uart_gps/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= uart_gps_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --uart_gps_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  uart_gps_s1_slavearbiterlockenable2 <= or_reduce(uart_gps_s1_arb_share_counter_next_value);
  --cpu/data_master uart_gps/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= uart_gps_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --uart_gps_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  uart_gps_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_uart_gps_s1 <= internal_cpu_data_master_requests_uart_gps_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_uart_gps_s1, which is an e_mux
  cpu_data_master_read_data_valid_uart_gps_s1 <= (internal_cpu_data_master_granted_uart_gps_s1 AND cpu_data_master_read) AND NOT uart_gps_s1_waits_for_read;
  --uart_gps_s1_writedata mux, which is an e_mux
  uart_gps_s1_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_uart_gps_s1 <= internal_cpu_data_master_qualified_request_uart_gps_s1;
  --cpu/data_master saved-grant uart_gps/s1, which is an e_assign
  cpu_data_master_saved_grant_uart_gps_s1 <= internal_cpu_data_master_requests_uart_gps_s1;
  --allow new arb cycle for uart_gps/s1, which is an e_assign
  uart_gps_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  uart_gps_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  uart_gps_s1_master_qreq_vector <= std_logic'('1');
  uart_gps_s1_begintransfer <= uart_gps_s1_begins_xfer;
  --uart_gps_s1_reset_n assignment, which is an e_assign
  uart_gps_s1_reset_n <= reset_n;
  uart_gps_s1_chipselect <= internal_cpu_data_master_granted_uart_gps_s1;
  --uart_gps_s1_firsttransfer first transaction, which is an e_assign
  uart_gps_s1_firsttransfer <= A_WE_StdLogic((std_logic'(uart_gps_s1_begins_xfer) = '1'), uart_gps_s1_unreg_firsttransfer, uart_gps_s1_reg_firsttransfer);
  --uart_gps_s1_unreg_firsttransfer first transaction, which is an e_assign
  uart_gps_s1_unreg_firsttransfer <= NOT ((uart_gps_s1_slavearbiterlockenable AND uart_gps_s1_any_continuerequest));
  --uart_gps_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_gps_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(uart_gps_s1_begins_xfer) = '1' then 
        uart_gps_s1_reg_firsttransfer <= uart_gps_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --uart_gps_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  uart_gps_s1_beginbursttransfer_internal <= uart_gps_s1_begins_xfer;
  --~uart_gps_s1_read_n assignment, which is an e_mux
  uart_gps_s1_read_n <= NOT ((internal_cpu_data_master_granted_uart_gps_s1 AND cpu_data_master_read));
  --~uart_gps_s1_write_n assignment, which is an e_mux
  uart_gps_s1_write_n <= NOT ((internal_cpu_data_master_granted_uart_gps_s1 AND cpu_data_master_write));
  shifted_address_to_uart_gps_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --uart_gps_s1_address mux, which is an e_mux
  uart_gps_s1_address <= A_EXT (A_SRL(shifted_address_to_uart_gps_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_uart_gps_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_uart_gps_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_uart_gps_s1_end_xfer <= uart_gps_s1_end_xfer;
    end if;

  end process;

  --uart_gps_s1_waits_for_read in a cycle, which is an e_mux
  uart_gps_s1_waits_for_read <= uart_gps_s1_in_a_read_cycle AND uart_gps_s1_begins_xfer;
  --uart_gps_s1_in_a_read_cycle assignment, which is an e_assign
  uart_gps_s1_in_a_read_cycle <= internal_cpu_data_master_granted_uart_gps_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= uart_gps_s1_in_a_read_cycle;
  --uart_gps_s1_waits_for_write in a cycle, which is an e_mux
  uart_gps_s1_waits_for_write <= uart_gps_s1_in_a_write_cycle AND uart_gps_s1_begins_xfer;
  --uart_gps_s1_in_a_write_cycle assignment, which is an e_assign
  uart_gps_s1_in_a_write_cycle <= internal_cpu_data_master_granted_uart_gps_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= uart_gps_s1_in_a_write_cycle;
  wait_for_uart_gps_s1_counter <= std_logic'('0');
  --assign uart_gps_s1_irq_from_sa = uart_gps_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_gps_s1_irq_from_sa <= uart_gps_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_uart_gps_s1 <= internal_cpu_data_master_granted_uart_gps_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_uart_gps_s1 <= internal_cpu_data_master_qualified_request_uart_gps_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_uart_gps_s1 <= internal_cpu_data_master_requests_uart_gps_s1;
--synthesis translate_off
    --uart_gps/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity uart_xbee_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal uart_xbee_s1_dataavailable : IN STD_LOGIC;
                 signal uart_xbee_s1_irq : IN STD_LOGIC;
                 signal uart_xbee_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_xbee_s1_readyfordata : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_uart_xbee_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_uart_xbee_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_uart_xbee_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_uart_xbee_s1 : OUT STD_LOGIC;
                 signal d1_uart_xbee_s1_end_xfer : OUT STD_LOGIC;
                 signal uart_xbee_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal uart_xbee_s1_begintransfer : OUT STD_LOGIC;
                 signal uart_xbee_s1_chipselect : OUT STD_LOGIC;
                 signal uart_xbee_s1_dataavailable_from_sa : OUT STD_LOGIC;
                 signal uart_xbee_s1_irq_from_sa : OUT STD_LOGIC;
                 signal uart_xbee_s1_read_n : OUT STD_LOGIC;
                 signal uart_xbee_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_xbee_s1_readyfordata_from_sa : OUT STD_LOGIC;
                 signal uart_xbee_s1_reset_n : OUT STD_LOGIC;
                 signal uart_xbee_s1_write_n : OUT STD_LOGIC;
                 signal uart_xbee_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity uart_xbee_s1_arbitrator;


architecture europa of uart_xbee_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_uart_xbee_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_uart_xbee_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_uart_xbee_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_uart_xbee_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_uart_xbee_s1 :  STD_LOGIC;
                signal shifted_address_to_uart_xbee_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal uart_xbee_s1_allgrants :  STD_LOGIC;
                signal uart_xbee_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal uart_xbee_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal uart_xbee_s1_any_continuerequest :  STD_LOGIC;
                signal uart_xbee_s1_arb_counter_enable :  STD_LOGIC;
                signal uart_xbee_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal uart_xbee_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal uart_xbee_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal uart_xbee_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal uart_xbee_s1_begins_xfer :  STD_LOGIC;
                signal uart_xbee_s1_end_xfer :  STD_LOGIC;
                signal uart_xbee_s1_firsttransfer :  STD_LOGIC;
                signal uart_xbee_s1_grant_vector :  STD_LOGIC;
                signal uart_xbee_s1_in_a_read_cycle :  STD_LOGIC;
                signal uart_xbee_s1_in_a_write_cycle :  STD_LOGIC;
                signal uart_xbee_s1_master_qreq_vector :  STD_LOGIC;
                signal uart_xbee_s1_non_bursting_master_requests :  STD_LOGIC;
                signal uart_xbee_s1_reg_firsttransfer :  STD_LOGIC;
                signal uart_xbee_s1_slavearbiterlockenable :  STD_LOGIC;
                signal uart_xbee_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal uart_xbee_s1_unreg_firsttransfer :  STD_LOGIC;
                signal uart_xbee_s1_waits_for_read :  STD_LOGIC;
                signal uart_xbee_s1_waits_for_write :  STD_LOGIC;
                signal wait_for_uart_xbee_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT uart_xbee_s1_end_xfer;
    end if;

  end process;

  uart_xbee_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_uart_xbee_s1);
  --assign uart_xbee_s1_readdata_from_sa = uart_xbee_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_xbee_s1_readdata_from_sa <= uart_xbee_s1_readdata;
  internal_cpu_data_master_requests_uart_xbee_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(26 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000000000010000001100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign uart_xbee_s1_dataavailable_from_sa = uart_xbee_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_xbee_s1_dataavailable_from_sa <= uart_xbee_s1_dataavailable;
  --assign uart_xbee_s1_readyfordata_from_sa = uart_xbee_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_xbee_s1_readyfordata_from_sa <= uart_xbee_s1_readyfordata;
  --uart_xbee_s1_arb_share_counter set values, which is an e_mux
  uart_xbee_s1_arb_share_set_values <= std_logic_vector'("01");
  --uart_xbee_s1_non_bursting_master_requests mux, which is an e_mux
  uart_xbee_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_uart_xbee_s1;
  --uart_xbee_s1_any_bursting_master_saved_grant mux, which is an e_mux
  uart_xbee_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --uart_xbee_s1_arb_share_counter_next_value assignment, which is an e_assign
  uart_xbee_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(uart_xbee_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (uart_xbee_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(uart_xbee_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (uart_xbee_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --uart_xbee_s1_allgrants all slave grants, which is an e_mux
  uart_xbee_s1_allgrants <= uart_xbee_s1_grant_vector;
  --uart_xbee_s1_end_xfer assignment, which is an e_assign
  uart_xbee_s1_end_xfer <= NOT ((uart_xbee_s1_waits_for_read OR uart_xbee_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_uart_xbee_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_uart_xbee_s1 <= uart_xbee_s1_end_xfer AND (((NOT uart_xbee_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --uart_xbee_s1_arb_share_counter arbitration counter enable, which is an e_assign
  uart_xbee_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_uart_xbee_s1 AND uart_xbee_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_uart_xbee_s1 AND NOT uart_xbee_s1_non_bursting_master_requests));
  --uart_xbee_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_xbee_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(uart_xbee_s1_arb_counter_enable) = '1' then 
        uart_xbee_s1_arb_share_counter <= uart_xbee_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --uart_xbee_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_xbee_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((uart_xbee_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_uart_xbee_s1)) OR ((end_xfer_arb_share_counter_term_uart_xbee_s1 AND NOT uart_xbee_s1_non_bursting_master_requests)))) = '1' then 
        uart_xbee_s1_slavearbiterlockenable <= or_reduce(uart_xbee_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master uart_xbee/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= uart_xbee_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --uart_xbee_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  uart_xbee_s1_slavearbiterlockenable2 <= or_reduce(uart_xbee_s1_arb_share_counter_next_value);
  --cpu/data_master uart_xbee/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= uart_xbee_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --uart_xbee_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  uart_xbee_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_uart_xbee_s1 <= internal_cpu_data_master_requests_uart_xbee_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_uart_xbee_s1, which is an e_mux
  cpu_data_master_read_data_valid_uart_xbee_s1 <= (internal_cpu_data_master_granted_uart_xbee_s1 AND cpu_data_master_read) AND NOT uart_xbee_s1_waits_for_read;
  --uart_xbee_s1_writedata mux, which is an e_mux
  uart_xbee_s1_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_uart_xbee_s1 <= internal_cpu_data_master_qualified_request_uart_xbee_s1;
  --cpu/data_master saved-grant uart_xbee/s1, which is an e_assign
  cpu_data_master_saved_grant_uart_xbee_s1 <= internal_cpu_data_master_requests_uart_xbee_s1;
  --allow new arb cycle for uart_xbee/s1, which is an e_assign
  uart_xbee_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  uart_xbee_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  uart_xbee_s1_master_qreq_vector <= std_logic'('1');
  uart_xbee_s1_begintransfer <= uart_xbee_s1_begins_xfer;
  --uart_xbee_s1_reset_n assignment, which is an e_assign
  uart_xbee_s1_reset_n <= reset_n;
  uart_xbee_s1_chipselect <= internal_cpu_data_master_granted_uart_xbee_s1;
  --uart_xbee_s1_firsttransfer first transaction, which is an e_assign
  uart_xbee_s1_firsttransfer <= A_WE_StdLogic((std_logic'(uart_xbee_s1_begins_xfer) = '1'), uart_xbee_s1_unreg_firsttransfer, uart_xbee_s1_reg_firsttransfer);
  --uart_xbee_s1_unreg_firsttransfer first transaction, which is an e_assign
  uart_xbee_s1_unreg_firsttransfer <= NOT ((uart_xbee_s1_slavearbiterlockenable AND uart_xbee_s1_any_continuerequest));
  --uart_xbee_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_xbee_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(uart_xbee_s1_begins_xfer) = '1' then 
        uart_xbee_s1_reg_firsttransfer <= uart_xbee_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --uart_xbee_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  uart_xbee_s1_beginbursttransfer_internal <= uart_xbee_s1_begins_xfer;
  --~uart_xbee_s1_read_n assignment, which is an e_mux
  uart_xbee_s1_read_n <= NOT ((internal_cpu_data_master_granted_uart_xbee_s1 AND cpu_data_master_read));
  --~uart_xbee_s1_write_n assignment, which is an e_mux
  uart_xbee_s1_write_n <= NOT ((internal_cpu_data_master_granted_uart_xbee_s1 AND cpu_data_master_write));
  shifted_address_to_uart_xbee_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --uart_xbee_s1_address mux, which is an e_mux
  uart_xbee_s1_address <= A_EXT (A_SRL(shifted_address_to_uart_xbee_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_uart_xbee_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_uart_xbee_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_uart_xbee_s1_end_xfer <= uart_xbee_s1_end_xfer;
    end if;

  end process;

  --uart_xbee_s1_waits_for_read in a cycle, which is an e_mux
  uart_xbee_s1_waits_for_read <= uart_xbee_s1_in_a_read_cycle AND uart_xbee_s1_begins_xfer;
  --uart_xbee_s1_in_a_read_cycle assignment, which is an e_assign
  uart_xbee_s1_in_a_read_cycle <= internal_cpu_data_master_granted_uart_xbee_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= uart_xbee_s1_in_a_read_cycle;
  --uart_xbee_s1_waits_for_write in a cycle, which is an e_mux
  uart_xbee_s1_waits_for_write <= uart_xbee_s1_in_a_write_cycle AND uart_xbee_s1_begins_xfer;
  --uart_xbee_s1_in_a_write_cycle assignment, which is an e_assign
  uart_xbee_s1_in_a_write_cycle <= internal_cpu_data_master_granted_uart_xbee_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= uart_xbee_s1_in_a_write_cycle;
  wait_for_uart_xbee_s1_counter <= std_logic'('0');
  --assign uart_xbee_s1_irq_from_sa = uart_xbee_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_xbee_s1_irq_from_sa <= uart_xbee_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_uart_xbee_s1 <= internal_cpu_data_master_granted_uart_xbee_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_uart_xbee_s1 <= internal_cpu_data_master_qualified_request_uart_xbee_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_uart_xbee_s1 <= internal_cpu_data_master_requests_uart_xbee_s1;
--synthesis translate_off
    --uart_xbee/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NiosII_reset_sys_clk_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity NiosII_reset_sys_clk_domain_synch_module;


architecture europa of NiosII_reset_sys_clk_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NiosII_reset_clk_50_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity NiosII_reset_clk_50_domain_synch_module;


architecture europa of NiosII_reset_clk_50_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NiosII_reset_sdram_clk_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity NiosII_reset_sdram_clk_domain_synch_module;


architecture europa of NiosII_reset_sdram_clk_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NiosII is 
        port (
              -- 1) global signals:
                 signal clk_50 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_clk : OUT STD_LOGIC;
                 signal sys_clk : OUT STD_LOGIC;

              -- the_PWM_1
                 signal out_port_from_the_PWM_1 : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);

              -- the_PWM_2
                 signal out_port_from_the_PWM_2 : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);

              -- the_PWM_3
                 signal out_port_from_the_PWM_3 : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);

              -- the_PWM_4
                 signal out_port_from_the_PWM_4 : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);

              -- the_data_tx
                 signal out_port_from_the_data_tx : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);

              -- the_duty_1
                 signal in_port_to_the_duty_1 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

              -- the_duty_2
                 signal in_port_to_the_duty_2 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

              -- the_duty_3
                 signal in_port_to_the_duty_3 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

              -- the_duty_4
                 signal in_port_to_the_duty_4 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

              -- the_entrada_ac_eje_X
                 signal in_port_to_the_entrada_ac_eje_X : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_ac_eje_Y
                 signal in_port_to_the_entrada_ac_eje_Y : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_ac_eje_Z
                 signal in_port_to_the_entrada_ac_eje_Z : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_gy_eje_X
                 signal in_port_to_the_entrada_gy_eje_X : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_gy_eje_Y
                 signal in_port_to_the_entrada_gy_eje_Y : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_gy_eje_Z
                 signal in_port_to_the_entrada_gy_eje_Z : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_ma_eje_X
                 signal in_port_to_the_entrada_ma_eje_X : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_ma_eje_Y
                 signal in_port_to_the_entrada_ma_eje_Y : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_ma_eje_Z
                 signal in_port_to_the_entrada_ma_eje_Z : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_entrada_temp
                 signal in_port_to_the_entrada_temp : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- the_epcs_flash_controller
                 signal data0_to_the_epcs_flash_controller : IN STD_LOGIC;
                 signal dclk_from_the_epcs_flash_controller : OUT STD_LOGIC;
                 signal sce_from_the_epcs_flash_controller : OUT STD_LOGIC;
                 signal sdo_from_the_epcs_flash_controller : OUT STD_LOGIC;

              -- the_out_test
                 signal out_port_from_the_out_test : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

              -- the_pll
                 signal areset_to_the_pll : IN STD_LOGIC;
                 signal locked_from_the_pll : OUT STD_LOGIC;
                 signal phasedone_from_the_pll : OUT STD_LOGIC;

              -- the_sdram
                 signal zs_addr_from_the_sdram : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
                 signal zs_ba_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_cas_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_cke_from_the_sdram : OUT STD_LOGIC;
                 signal zs_cs_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_dq_to_and_from_the_sdram : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal zs_dqm_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_ras_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_we_n_from_the_sdram : OUT STD_LOGIC;

              -- the_uart_gps
                 signal rxd_to_the_uart_gps : IN STD_LOGIC;
                 signal txd_from_the_uart_gps : OUT STD_LOGIC;

              -- the_uart_xbee
                 signal rxd_to_the_uart_xbee : IN STD_LOGIC;
                 signal txd_from_the_uart_xbee : OUT STD_LOGIC
              );
end entity NiosII;


architecture europa of NiosII is
component NiosII_clock_0_in_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_0_in_endofpacket : IN STD_LOGIC;
                    signal NiosII_clock_0_in_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_0_in_waitrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC;
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal NiosII_clock_0_in_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal NiosII_clock_0_in_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal NiosII_clock_0_in_endofpacket_from_sa : OUT STD_LOGIC;
                    signal NiosII_clock_0_in_nativeaddress : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal NiosII_clock_0_in_read : OUT STD_LOGIC;
                    signal NiosII_clock_0_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_0_in_reset_n : OUT STD_LOGIC;
                    signal NiosII_clock_0_in_waitrequest_from_sa : OUT STD_LOGIC;
                    signal NiosII_clock_0_in_write : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_NiosII_clock_0_in : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_NiosII_clock_0_in : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_NiosII_clock_0_in : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_NiosII_clock_0_in : OUT STD_LOGIC;
                    signal d1_NiosII_clock_0_in_end_xfer : OUT STD_LOGIC
                 );
end component NiosII_clock_0_in_arbitrator;

component NiosII_clock_0_out_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_0_out_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal NiosII_clock_0_out_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal NiosII_clock_0_out_granted_sdram_s1 : IN STD_LOGIC;
                    signal NiosII_clock_0_out_qualified_request_sdram_s1 : IN STD_LOGIC;
                    signal NiosII_clock_0_out_read : IN STD_LOGIC;
                    signal NiosII_clock_0_out_read_data_valid_sdram_s1 : IN STD_LOGIC;
                    signal NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal NiosII_clock_0_out_requests_sdram_s1 : IN STD_LOGIC;
                    signal NiosII_clock_0_out_write : IN STD_LOGIC;
                    signal NiosII_clock_0_out_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal NiosII_clock_0_out_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal NiosII_clock_0_out_readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_0_out_reset_n : OUT STD_LOGIC;
                    signal NiosII_clock_0_out_waitrequest : OUT STD_LOGIC
                 );
end component NiosII_clock_0_out_arbitrator;

component NiosII_clock_0 is 
           port (
                 -- inputs:
                    signal master_clk : IN STD_LOGIC;
                    signal master_endofpacket : IN STD_LOGIC;
                    signal master_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal master_reset_n : IN STD_LOGIC;
                    signal master_waitrequest : IN STD_LOGIC;
                    signal slave_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal slave_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal slave_clk : IN STD_LOGIC;
                    signal slave_nativeaddress : IN STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal slave_read : IN STD_LOGIC;
                    signal slave_reset_n : IN STD_LOGIC;
                    signal slave_write : IN STD_LOGIC;
                    signal slave_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal master_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal master_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal master_nativeaddress : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal master_read : OUT STD_LOGIC;
                    signal master_write : OUT STD_LOGIC;
                    signal master_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal slave_endofpacket : OUT STD_LOGIC;
                    signal slave_readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal slave_waitrequest : OUT STD_LOGIC
                 );
end component NiosII_clock_0;

component NiosII_clock_1_in_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_1_in_endofpacket : IN STD_LOGIC;
                    signal NiosII_clock_1_in_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_1_in_waitrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal NiosII_clock_1_in_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal NiosII_clock_1_in_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal NiosII_clock_1_in_endofpacket_from_sa : OUT STD_LOGIC;
                    signal NiosII_clock_1_in_nativeaddress : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal NiosII_clock_1_in_read : OUT STD_LOGIC;
                    signal NiosII_clock_1_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_1_in_reset_n : OUT STD_LOGIC;
                    signal NiosII_clock_1_in_waitrequest_from_sa : OUT STD_LOGIC;
                    signal NiosII_clock_1_in_write : OUT STD_LOGIC;
                    signal NiosII_clock_1_in_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_byteenable_NiosII_clock_1_in : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_granted_NiosII_clock_1_in : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_NiosII_clock_1_in : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_NiosII_clock_1_in : OUT STD_LOGIC;
                    signal cpu_data_master_requests_NiosII_clock_1_in : OUT STD_LOGIC;
                    signal d1_NiosII_clock_1_in_end_xfer : OUT STD_LOGIC
                 );
end component NiosII_clock_1_in_arbitrator;

component NiosII_clock_1_out_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_1_out_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal NiosII_clock_1_out_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal NiosII_clock_1_out_granted_sdram_s1 : IN STD_LOGIC;
                    signal NiosII_clock_1_out_qualified_request_sdram_s1 : IN STD_LOGIC;
                    signal NiosII_clock_1_out_read : IN STD_LOGIC;
                    signal NiosII_clock_1_out_read_data_valid_sdram_s1 : IN STD_LOGIC;
                    signal NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal NiosII_clock_1_out_requests_sdram_s1 : IN STD_LOGIC;
                    signal NiosII_clock_1_out_write : IN STD_LOGIC;
                    signal NiosII_clock_1_out_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal NiosII_clock_1_out_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal NiosII_clock_1_out_readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_1_out_reset_n : OUT STD_LOGIC;
                    signal NiosII_clock_1_out_waitrequest : OUT STD_LOGIC
                 );
end component NiosII_clock_1_out_arbitrator;

component NiosII_clock_1 is 
           port (
                 -- inputs:
                    signal master_clk : IN STD_LOGIC;
                    signal master_endofpacket : IN STD_LOGIC;
                    signal master_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal master_reset_n : IN STD_LOGIC;
                    signal master_waitrequest : IN STD_LOGIC;
                    signal slave_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal slave_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal slave_clk : IN STD_LOGIC;
                    signal slave_nativeaddress : IN STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal slave_read : IN STD_LOGIC;
                    signal slave_reset_n : IN STD_LOGIC;
                    signal slave_write : IN STD_LOGIC;
                    signal slave_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal master_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal master_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal master_nativeaddress : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal master_read : OUT STD_LOGIC;
                    signal master_write : OUT STD_LOGIC;
                    signal master_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal slave_endofpacket : OUT STD_LOGIC;
                    signal slave_readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal slave_waitrequest : OUT STD_LOGIC
                 );
end component NiosII_clock_1;

component NiosII_clock_2_in_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_2_in_endofpacket : IN STD_LOGIC;
                    signal NiosII_clock_2_in_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal NiosII_clock_2_in_waitrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal NiosII_clock_2_in_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal NiosII_clock_2_in_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal NiosII_clock_2_in_endofpacket_from_sa : OUT STD_LOGIC;
                    signal NiosII_clock_2_in_nativeaddress : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal NiosII_clock_2_in_read : OUT STD_LOGIC;
                    signal NiosII_clock_2_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal NiosII_clock_2_in_reset_n : OUT STD_LOGIC;
                    signal NiosII_clock_2_in_waitrequest_from_sa : OUT STD_LOGIC;
                    signal NiosII_clock_2_in_write : OUT STD_LOGIC;
                    signal NiosII_clock_2_in_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_NiosII_clock_2_in : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_NiosII_clock_2_in : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_NiosII_clock_2_in : OUT STD_LOGIC;
                    signal cpu_data_master_requests_NiosII_clock_2_in : OUT STD_LOGIC;
                    signal d1_NiosII_clock_2_in_end_xfer : OUT STD_LOGIC
                 );
end component NiosII_clock_2_in_arbitrator;

component NiosII_clock_2_out_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_2_out_address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal NiosII_clock_2_out_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal NiosII_clock_2_out_granted_pll_pll_slave : IN STD_LOGIC;
                    signal NiosII_clock_2_out_qualified_request_pll_pll_slave : IN STD_LOGIC;
                    signal NiosII_clock_2_out_read : IN STD_LOGIC;
                    signal NiosII_clock_2_out_read_data_valid_pll_pll_slave : IN STD_LOGIC;
                    signal NiosII_clock_2_out_requests_pll_pll_slave : IN STD_LOGIC;
                    signal NiosII_clock_2_out_write : IN STD_LOGIC;
                    signal NiosII_clock_2_out_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d1_pll_pll_slave_end_xfer : IN STD_LOGIC;
                    signal pll_pll_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal NiosII_clock_2_out_address_to_slave : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal NiosII_clock_2_out_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal NiosII_clock_2_out_reset_n : OUT STD_LOGIC;
                    signal NiosII_clock_2_out_waitrequest : OUT STD_LOGIC
                 );
end component NiosII_clock_2_out_arbitrator;

component NiosII_clock_2 is 
           port (
                 -- inputs:
                    signal master_clk : IN STD_LOGIC;
                    signal master_endofpacket : IN STD_LOGIC;
                    signal master_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal master_reset_n : IN STD_LOGIC;
                    signal master_waitrequest : IN STD_LOGIC;
                    signal slave_address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal slave_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal slave_clk : IN STD_LOGIC;
                    signal slave_nativeaddress : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal slave_read : IN STD_LOGIC;
                    signal slave_reset_n : IN STD_LOGIC;
                    signal slave_write : IN STD_LOGIC;
                    signal slave_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal master_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal master_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal master_nativeaddress : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal master_read : OUT STD_LOGIC;
                    signal master_write : OUT STD_LOGIC;
                    signal master_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal slave_endofpacket : OUT STD_LOGIC;
                    signal slave_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal slave_waitrequest : OUT STD_LOGIC
                 );
end component NiosII_clock_2;

component PWM_1_s1_arbitrator is 
           port (
                 -- inputs:
                    signal PWM_1_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal PWM_1_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal PWM_1_s1_chipselect : OUT STD_LOGIC;
                    signal PWM_1_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PWM_1_s1_reset_n : OUT STD_LOGIC;
                    signal PWM_1_s1_write_n : OUT STD_LOGIC;
                    signal PWM_1_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_PWM_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_PWM_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PWM_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_PWM_1_s1 : OUT STD_LOGIC;
                    signal d1_PWM_1_s1_end_xfer : OUT STD_LOGIC
                 );
end component PWM_1_s1_arbitrator;

component PWM_1 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component PWM_1;

component PWM_2_s1_arbitrator is 
           port (
                 -- inputs:
                    signal PWM_2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal PWM_2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal PWM_2_s1_chipselect : OUT STD_LOGIC;
                    signal PWM_2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PWM_2_s1_reset_n : OUT STD_LOGIC;
                    signal PWM_2_s1_write_n : OUT STD_LOGIC;
                    signal PWM_2_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_PWM_2_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_PWM_2_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PWM_2_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_PWM_2_s1 : OUT STD_LOGIC;
                    signal d1_PWM_2_s1_end_xfer : OUT STD_LOGIC
                 );
end component PWM_2_s1_arbitrator;

component PWM_2 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component PWM_2;

component PWM_3_s1_arbitrator is 
           port (
                 -- inputs:
                    signal PWM_3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal PWM_3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal PWM_3_s1_chipselect : OUT STD_LOGIC;
                    signal PWM_3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PWM_3_s1_reset_n : OUT STD_LOGIC;
                    signal PWM_3_s1_write_n : OUT STD_LOGIC;
                    signal PWM_3_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_PWM_3_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_PWM_3_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PWM_3_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_PWM_3_s1 : OUT STD_LOGIC;
                    signal d1_PWM_3_s1_end_xfer : OUT STD_LOGIC
                 );
end component PWM_3_s1_arbitrator;

component PWM_3 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component PWM_3;

component PWM_4_s1_arbitrator is 
           port (
                 -- inputs:
                    signal PWM_4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal PWM_4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal PWM_4_s1_chipselect : OUT STD_LOGIC;
                    signal PWM_4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PWM_4_s1_reset_n : OUT STD_LOGIC;
                    signal PWM_4_s1_write_n : OUT STD_LOGIC;
                    signal PWM_4_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_PWM_4_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_PWM_4_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PWM_4_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_PWM_4_s1 : OUT STD_LOGIC;
                    signal d1_PWM_4_s1_end_xfer : OUT STD_LOGIC
                 );
end component PWM_4_s1_arbitrator;

component PWM_4 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component PWM_4;

component cpu_jtag_debug_module_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_debugaccess : IN STD_LOGIC;
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC;
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_resetrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal cpu_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_jtag_debug_module_chipselect : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_write : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_jtag_debug_module_end_xfer : OUT STD_LOGIC
                 );
end component cpu_jtag_debug_module_arbitrator;

component cpu_custom_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa : IN STD_LOGIC;
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custom_instruction_master_multi_start : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_select : OUT STD_LOGIC;
                    signal cpu_custom_instruction_master_multi_done : OUT STD_LOGIC;
                    signal cpu_custom_instruction_master_multi_result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custom_instruction_master_reset_n : OUT STD_LOGIC;
                    signal cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1 : OUT STD_LOGIC
                 );
end component cpu_custom_instruction_master_arbitrator;

component cpu_data_master_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_1_in_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_1_in_waitrequest_from_sa : IN STD_LOGIC;
                    signal NiosII_clock_2_in_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal NiosII_clock_2_in_waitrequest_from_sa : IN STD_LOGIC;
                    signal PWM_1_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PWM_2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PWM_3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PWM_4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_byteenable_NiosII_clock_1_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_granted_NiosII_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_granted_NiosII_clock_2_in : IN STD_LOGIC;
                    signal cpu_data_master_granted_PWM_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_PWM_2_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_PWM_3_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_PWM_4_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_granted_data_tx_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_duty_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_duty_2_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_duty_3_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_duty_4_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_ac_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_ac_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_ac_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_gy_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_gy_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_gy_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_ma_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_ma_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_ma_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_entrada_temp_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_out_test_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_sample_time_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_sysid_control_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_timer_ONOF_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_uart_gps_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_uart_xbee_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_NiosII_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_NiosII_clock_2_in : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_PWM_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_PWM_2_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_PWM_3_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_PWM_4_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_data_tx_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_duty_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_duty_2_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_duty_3_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_duty_4_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ac_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_gy_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ma_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_temp_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_out_test_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_sample_time_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_sysid_control_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_timer_ONOF_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_uart_gps_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_uart_xbee_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_NiosII_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_NiosII_clock_2_in : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PWM_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PWM_2_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PWM_3_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PWM_4_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_data_tx_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_duty_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_duty_2_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_duty_3_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_duty_4_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ac_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_gy_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ma_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_temp_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_out_test_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sample_time_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sysid_control_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_timer_ONOF_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_uart_gps_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_uart_xbee_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_NiosII_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_requests_NiosII_clock_2_in : IN STD_LOGIC;
                    signal cpu_data_master_requests_PWM_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_PWM_2_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_PWM_3_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_PWM_4_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_requests_data_tx_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_duty_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_duty_2_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_duty_3_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_duty_4_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ac_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ac_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ac_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_gy_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_gy_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_gy_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ma_eje_X_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ma_eje_Y_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ma_eje_Z_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_entrada_temp_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_out_test_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_sample_time_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_sysid_control_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_timer_ONOF_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_uart_gps_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_uart_xbee_s1 : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_NiosII_clock_1_in_end_xfer : IN STD_LOGIC;
                    signal d1_NiosII_clock_2_in_end_xfer : IN STD_LOGIC;
                    signal d1_PWM_1_s1_end_xfer : IN STD_LOGIC;
                    signal d1_PWM_2_s1_end_xfer : IN STD_LOGIC;
                    signal d1_PWM_3_s1_end_xfer : IN STD_LOGIC;
                    signal d1_PWM_4_s1_end_xfer : IN STD_LOGIC;
                    signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_data_tx_s1_end_xfer : IN STD_LOGIC;
                    signal d1_duty_1_s1_end_xfer : IN STD_LOGIC;
                    signal d1_duty_2_s1_end_xfer : IN STD_LOGIC;
                    signal d1_duty_3_s1_end_xfer : IN STD_LOGIC;
                    signal d1_duty_4_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_ac_eje_X_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_ac_eje_Y_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_ac_eje_Z_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_gy_eje_X_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_gy_eje_Y_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_gy_eje_Z_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_ma_eje_X_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_ma_eje_Y_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_ma_eje_Z_s1_end_xfer : IN STD_LOGIC;
                    signal d1_entrada_temp_s1_end_xfer : IN STD_LOGIC;
                    signal d1_epcs_flash_controller_epcs_control_port_end_xfer : IN STD_LOGIC;
                    signal d1_jtag_uart_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                    signal d1_out_test_s1_end_xfer : IN STD_LOGIC;
                    signal d1_sample_time_s1_end_xfer : IN STD_LOGIC;
                    signal d1_sysid_control_slave_end_xfer : IN STD_LOGIC;
                    signal d1_timer_ONOF_s1_end_xfer : IN STD_LOGIC;
                    signal d1_uart_gps_s1_end_xfer : IN STD_LOGIC;
                    signal d1_uart_xbee_s1_end_xfer : IN STD_LOGIC;
                    signal data_tx_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal duty_1_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal duty_2_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal duty_3_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal duty_4_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ac_eje_X_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ac_eje_Y_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ac_eje_Z_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_gy_eje_X_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_gy_eje_Y_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_gy_eje_Z_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ma_eje_X_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ma_eje_Y_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ma_eje_Z_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_temp_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal epcs_flash_controller_epcs_control_port_irq_from_sa : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal out_test_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal sample_time_s1_irq_from_sa : IN STD_LOGIC;
                    signal sample_time_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sysid_control_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal timer_ONOF_s1_irq_from_sa : IN STD_LOGIC;
                    signal timer_ONOF_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_gps_s1_irq_from_sa : IN STD_LOGIC;
                    signal uart_gps_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_xbee_s1_irq_from_sa : IN STD_LOGIC;
                    signal uart_xbee_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_latency_counter : OUT STD_LOGIC;
                    signal cpu_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_data_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_data_master_arbitrator;

component cpu_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_0_in_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_0_in_waitrequest_from_sa : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_instruction_master_address : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_instruction_master_granted_NiosII_clock_0_in : IN STD_LOGIC;
                    signal cpu_instruction_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_NiosII_clock_0_in : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_NiosII_clock_0_in : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_NiosII_clock_0_in : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_NiosII_clock_0_in_end_xfer : IN STD_LOGIC;
                    signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_epcs_flash_controller_epcs_control_port_end_xfer : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : OUT STD_LOGIC;
                    signal cpu_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_instruction_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_instruction_master_arbitrator;

component cpu is 
           port (
                 -- inputs:
                    signal A_ci_multi_done : IN STD_LOGIC;
                    signal A_ci_multi_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d_irq : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdatavalid : IN STD_LOGIC;
                    signal d_waitrequest : IN STD_LOGIC;
                    signal i_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_readdatavalid : IN STD_LOGIC;
                    signal i_waitrequest : IN STD_LOGIC;
                    signal jtag_debug_module_address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal jtag_debug_module_begintransfer : IN STD_LOGIC;
                    signal jtag_debug_module_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal jtag_debug_module_debugaccess : IN STD_LOGIC;
                    signal jtag_debug_module_select : IN STD_LOGIC;
                    signal jtag_debug_module_write : IN STD_LOGIC;
                    signal jtag_debug_module_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal A_ci_multi_a : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal A_ci_multi_b : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal A_ci_multi_c : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal A_ci_multi_clk_en : OUT STD_LOGIC;
                    signal A_ci_multi_clock : OUT STD_LOGIC;
                    signal A_ci_multi_dataa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal A_ci_multi_datab : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal A_ci_multi_estatus : OUT STD_LOGIC;
                    signal A_ci_multi_ipending : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal A_ci_multi_n : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal A_ci_multi_readra : OUT STD_LOGIC;
                    signal A_ci_multi_readrb : OUT STD_LOGIC;
                    signal A_ci_multi_reset : OUT STD_LOGIC;
                    signal A_ci_multi_start : OUT STD_LOGIC;
                    signal A_ci_multi_status : OUT STD_LOGIC;
                    signal A_ci_multi_writerc : OUT STD_LOGIC;
                    signal d_address : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal d_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal d_read : OUT STD_LOGIC;
                    signal d_write : OUT STD_LOGIC;
                    signal d_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_address : OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal i_read : OUT STD_LOGIC;
                    signal jtag_debug_module_debugaccess_to_roms : OUT STD_LOGIC;
                    signal jtag_debug_module_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_debug_module_resetrequest : OUT STD_LOGIC
                 );
end component cpu;

component cpu_altera_nios_custom_instr_floating_point_inst_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_done : IN STD_LOGIC;
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_select : IN STD_LOGIC;
                    signal cpu_custom_instruction_master_multi_clk_en : IN STD_LOGIC;
                    signal cpu_custom_instruction_master_multi_dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custom_instruction_master_multi_datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custom_instruction_master_multi_n : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_clk_en : OUT STD_LOGIC;
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_dataa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_datab : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa : OUT STD_LOGIC;
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_reset : OUT STD_LOGIC;
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_altera_nios_custom_instr_floating_point_inst_s1_start : OUT STD_LOGIC
                 );
end component cpu_altera_nios_custom_instr_floating_point_inst_s1_arbitrator;

component cpu_altera_nios_custom_instr_floating_point_inst is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal clk_en : IN STD_LOGIC;
                    signal dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal n : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal reset : IN STD_LOGIC;
                    signal start : IN STD_LOGIC;

                 -- outputs:
                    signal done : OUT STD_LOGIC;
                    signal result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component cpu_altera_nios_custom_instr_floating_point_inst;

component data_tx_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal data_tx_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_data_tx_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_data_tx_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_data_tx_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_data_tx_s1 : OUT STD_LOGIC;
                    signal d1_data_tx_s1_end_xfer : OUT STD_LOGIC;
                    signal data_tx_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal data_tx_s1_chipselect : OUT STD_LOGIC;
                    signal data_tx_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal data_tx_s1_reset_n : OUT STD_LOGIC;
                    signal data_tx_s1_write_n : OUT STD_LOGIC;
                    signal data_tx_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component data_tx_s1_arbitrator;

component data_tx is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component data_tx;

component duty_1_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal duty_1_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_duty_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_duty_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_duty_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_duty_1_s1 : OUT STD_LOGIC;
                    signal d1_duty_1_s1_end_xfer : OUT STD_LOGIC;
                    signal duty_1_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal duty_1_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal duty_1_s1_reset_n : OUT STD_LOGIC
                 );
end component duty_1_s1_arbitrator;

component duty_1 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component duty_1;

component duty_2_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal duty_2_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_duty_2_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_duty_2_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_duty_2_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_duty_2_s1 : OUT STD_LOGIC;
                    signal d1_duty_2_s1_end_xfer : OUT STD_LOGIC;
                    signal duty_2_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal duty_2_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal duty_2_s1_reset_n : OUT STD_LOGIC
                 );
end component duty_2_s1_arbitrator;

component duty_2 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component duty_2;

component duty_3_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal duty_3_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_duty_3_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_duty_3_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_duty_3_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_duty_3_s1 : OUT STD_LOGIC;
                    signal d1_duty_3_s1_end_xfer : OUT STD_LOGIC;
                    signal duty_3_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal duty_3_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal duty_3_s1_reset_n : OUT STD_LOGIC
                 );
end component duty_3_s1_arbitrator;

component duty_3 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component duty_3;

component duty_4_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal duty_4_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_duty_4_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_duty_4_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_duty_4_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_duty_4_s1 : OUT STD_LOGIC;
                    signal d1_duty_4_s1_end_xfer : OUT STD_LOGIC;
                    signal duty_4_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal duty_4_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal duty_4_s1_reset_n : OUT STD_LOGIC
                 );
end component duty_4_s1_arbitrator;

component duty_4 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component duty_4;

component entrada_ac_eje_X_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_ac_eje_X_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_ac_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ac_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ac_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ac_eje_X_s1 : OUT STD_LOGIC;
                    signal d1_entrada_ac_eje_X_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_ac_eje_X_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_ac_eje_X_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ac_eje_X_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_ac_eje_X_s1_arbitrator;

component entrada_ac_eje_X is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_ac_eje_X;

component entrada_ac_eje_Y_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_ac_eje_Y_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_ac_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ac_eje_Y_s1 : OUT STD_LOGIC;
                    signal d1_entrada_ac_eje_Y_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_ac_eje_Y_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_ac_eje_Y_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ac_eje_Y_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_ac_eje_Y_s1_arbitrator;

component entrada_ac_eje_Y is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_ac_eje_Y;

component entrada_ac_eje_Z_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_ac_eje_Z_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_ac_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ac_eje_Z_s1 : OUT STD_LOGIC;
                    signal d1_entrada_ac_eje_Z_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_ac_eje_Z_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_ac_eje_Z_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ac_eje_Z_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_ac_eje_Z_s1_arbitrator;

component entrada_ac_eje_Z is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_ac_eje_Z;

component entrada_gy_eje_X_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_gy_eje_X_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_gy_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_gy_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_gy_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_gy_eje_X_s1 : OUT STD_LOGIC;
                    signal d1_entrada_gy_eje_X_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_gy_eje_X_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_gy_eje_X_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_gy_eje_X_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_gy_eje_X_s1_arbitrator;

component entrada_gy_eje_X is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_gy_eje_X;

component entrada_gy_eje_Y_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_gy_eje_Y_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_gy_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_gy_eje_Y_s1 : OUT STD_LOGIC;
                    signal d1_entrada_gy_eje_Y_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_gy_eje_Y_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_gy_eje_Y_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_gy_eje_Y_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_gy_eje_Y_s1_arbitrator;

component entrada_gy_eje_Y is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_gy_eje_Y;

component entrada_gy_eje_Z_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_gy_eje_Z_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_gy_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_gy_eje_Z_s1 : OUT STD_LOGIC;
                    signal d1_entrada_gy_eje_Z_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_gy_eje_Z_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_gy_eje_Z_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_gy_eje_Z_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_gy_eje_Z_s1_arbitrator;

component entrada_gy_eje_Z is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_gy_eje_Z;

component entrada_ma_eje_X_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_ma_eje_X_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_ma_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ma_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ma_eje_X_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ma_eje_X_s1 : OUT STD_LOGIC;
                    signal d1_entrada_ma_eje_X_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_ma_eje_X_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_ma_eje_X_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ma_eje_X_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_ma_eje_X_s1_arbitrator;

component entrada_ma_eje_X is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_ma_eje_X;

component entrada_ma_eje_Y_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_ma_eje_Y_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_ma_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ma_eje_Y_s1 : OUT STD_LOGIC;
                    signal d1_entrada_ma_eje_Y_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_ma_eje_Y_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_ma_eje_Y_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ma_eje_Y_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_ma_eje_Y_s1_arbitrator;

component entrada_ma_eje_Y is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_ma_eje_Y;

component entrada_ma_eje_Z_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_ma_eje_Z_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_ma_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_ma_eje_Z_s1 : OUT STD_LOGIC;
                    signal d1_entrada_ma_eje_Z_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_ma_eje_Z_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_ma_eje_Z_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_ma_eje_Z_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_ma_eje_Z_s1_arbitrator;

component entrada_ma_eje_Z is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_ma_eje_Z;

component entrada_temp_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal entrada_temp_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_entrada_temp_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_entrada_temp_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_entrada_temp_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_entrada_temp_s1 : OUT STD_LOGIC;
                    signal d1_entrada_temp_s1_end_xfer : OUT STD_LOGIC;
                    signal entrada_temp_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal entrada_temp_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal entrada_temp_s1_reset_n : OUT STD_LOGIC
                 );
end component entrada_temp_s1_arbitrator;

component entrada_temp is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component entrada_temp;

component epcs_flash_controller_epcs_control_port_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC;
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_dataavailable : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_endofpacket : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_irq : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal epcs_flash_controller_epcs_control_port_readyfordata : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal d1_epcs_flash_controller_epcs_control_port_end_xfer : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal epcs_flash_controller_epcs_control_port_chipselect : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_irq_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_read_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal epcs_flash_controller_epcs_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_reset_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_write_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component epcs_flash_controller_epcs_control_port_arbitrator;

component epcs_flash_controller is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data0 : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal dclk : OUT STD_LOGIC;
                    signal endofpacket : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal sce : OUT STD_LOGIC;
                    signal sdo : OUT STD_LOGIC
                 );
end component epcs_flash_controller;

component jtag_uart_avalon_jtag_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_irq : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal d1_jtag_uart_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_address : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component jtag_uart_avalon_jtag_slave_arbitrator;

component jtag_uart is 
           port (
                 -- inputs:
                    signal av_address : IN STD_LOGIC;
                    signal av_chipselect : IN STD_LOGIC;
                    signal av_read_n : IN STD_LOGIC;
                    signal av_write_n : IN STD_LOGIC;
                    signal av_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst_n : IN STD_LOGIC;

                 -- outputs:
                    signal av_irq : OUT STD_LOGIC;
                    signal av_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal av_waitrequest : OUT STD_LOGIC;
                    signal dataavailable : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component jtag_uart;

component out_test_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal out_test_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_out_test_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_out_test_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_out_test_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_out_test_s1 : OUT STD_LOGIC;
                    signal d1_out_test_s1_end_xfer : OUT STD_LOGIC;
                    signal out_test_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal out_test_s1_chipselect : OUT STD_LOGIC;
                    signal out_test_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal out_test_s1_reset_n : OUT STD_LOGIC;
                    signal out_test_s1_write_n : OUT STD_LOGIC;
                    signal out_test_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component out_test_s1_arbitrator;

component out_test is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component out_test;

component pll_pll_slave_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_2_out_address_to_slave : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal NiosII_clock_2_out_read : IN STD_LOGIC;
                    signal NiosII_clock_2_out_write : IN STD_LOGIC;
                    signal NiosII_clock_2_out_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal pll_pll_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal NiosII_clock_2_out_granted_pll_pll_slave : OUT STD_LOGIC;
                    signal NiosII_clock_2_out_qualified_request_pll_pll_slave : OUT STD_LOGIC;
                    signal NiosII_clock_2_out_read_data_valid_pll_pll_slave : OUT STD_LOGIC;
                    signal NiosII_clock_2_out_requests_pll_pll_slave : OUT STD_LOGIC;
                    signal d1_pll_pll_slave_end_xfer : OUT STD_LOGIC;
                    signal pll_pll_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal pll_pll_slave_read : OUT STD_LOGIC;
                    signal pll_pll_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal pll_pll_slave_reset : OUT STD_LOGIC;
                    signal pll_pll_slave_write : OUT STD_LOGIC;
                    signal pll_pll_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pll_pll_slave_arbitrator;

component pll is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal areset : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal c0 : OUT STD_LOGIC;
                    signal c1 : OUT STD_LOGIC;
                    signal locked : OUT STD_LOGIC;
                    signal phasedone : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component pll;

component sample_time_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal sample_time_s1_irq : IN STD_LOGIC;
                    signal sample_time_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_data_master_granted_sample_time_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_sample_time_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sample_time_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_sample_time_s1 : OUT STD_LOGIC;
                    signal d1_sample_time_s1_end_xfer : OUT STD_LOGIC;
                    signal sample_time_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal sample_time_s1_chipselect : OUT STD_LOGIC;
                    signal sample_time_s1_irq_from_sa : OUT STD_LOGIC;
                    signal sample_time_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sample_time_s1_reset_n : OUT STD_LOGIC;
                    signal sample_time_s1_write_n : OUT STD_LOGIC;
                    signal sample_time_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sample_time_s1_arbitrator;

component sample_time is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sample_time;

component sdram_s1_arbitrator is 
           port (
                 -- inputs:
                    signal NiosII_clock_0_out_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal NiosII_clock_0_out_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal NiosII_clock_0_out_read : IN STD_LOGIC;
                    signal NiosII_clock_0_out_write : IN STD_LOGIC;
                    signal NiosII_clock_0_out_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal NiosII_clock_1_out_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal NiosII_clock_1_out_byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal NiosII_clock_1_out_read : IN STD_LOGIC;
                    signal NiosII_clock_1_out_write : IN STD_LOGIC;
                    signal NiosII_clock_1_out_writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_readdatavalid : IN STD_LOGIC;
                    signal sdram_s1_waitrequest : IN STD_LOGIC;

                 -- outputs:
                    signal NiosII_clock_0_out_granted_sdram_s1 : OUT STD_LOGIC;
                    signal NiosII_clock_0_out_qualified_request_sdram_s1 : OUT STD_LOGIC;
                    signal NiosII_clock_0_out_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                    signal NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                    signal NiosII_clock_0_out_requests_sdram_s1 : OUT STD_LOGIC;
                    signal NiosII_clock_1_out_granted_sdram_s1 : OUT STD_LOGIC;
                    signal NiosII_clock_1_out_qualified_request_sdram_s1 : OUT STD_LOGIC;
                    signal NiosII_clock_1_out_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                    signal NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                    signal NiosII_clock_1_out_requests_sdram_s1 : OUT STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : OUT STD_LOGIC;
                    signal sdram_s1_address : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal sdram_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal sdram_s1_chipselect : OUT STD_LOGIC;
                    signal sdram_s1_read_n : OUT STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_reset_n : OUT STD_LOGIC;
                    signal sdram_s1_waitrequest_from_sa : OUT STD_LOGIC;
                    signal sdram_s1_write_n : OUT STD_LOGIC;
                    signal sdram_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sdram_s1_arbitrator;

component sdram is 
           port (
                 -- inputs:
                    signal az_addr : IN STD_LOGIC_VECTOR (23 DOWNTO 0);
                    signal az_be_n : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal az_cs : IN STD_LOGIC;
                    signal az_data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal az_rd_n : IN STD_LOGIC;
                    signal az_wr_n : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal za_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal za_valid : OUT STD_LOGIC;
                    signal za_waitrequest : OUT STD_LOGIC;
                    signal zs_addr : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
                    signal zs_ba : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n : OUT STD_LOGIC;
                    signal zs_cke : OUT STD_LOGIC;
                    signal zs_cs_n : OUT STD_LOGIC;
                    signal zs_dq : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n : OUT STD_LOGIC;
                    signal zs_we_n : OUT STD_LOGIC
                 );
end component sdram;

component sysid_control_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sysid_control_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal cpu_data_master_granted_sysid_control_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_sysid_control_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sysid_control_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_sysid_control_slave : OUT STD_LOGIC;
                    signal d1_sysid_control_slave_end_xfer : OUT STD_LOGIC;
                    signal sysid_control_slave_address : OUT STD_LOGIC;
                    signal sysid_control_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal sysid_control_slave_reset_n : OUT STD_LOGIC
                 );
end component sysid_control_slave_arbitrator;

component sysid is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC;
                    signal clock : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component sysid;

component timer_ONOF_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal timer_ONOF_s1_irq : IN STD_LOGIC;
                    signal timer_ONOF_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_data_master_granted_timer_ONOF_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_timer_ONOF_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_timer_ONOF_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_timer_ONOF_s1 : OUT STD_LOGIC;
                    signal d1_timer_ONOF_s1_end_xfer : OUT STD_LOGIC;
                    signal timer_ONOF_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal timer_ONOF_s1_chipselect : OUT STD_LOGIC;
                    signal timer_ONOF_s1_irq_from_sa : OUT STD_LOGIC;
                    signal timer_ONOF_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal timer_ONOF_s1_reset_n : OUT STD_LOGIC;
                    signal timer_ONOF_s1_write_n : OUT STD_LOGIC;
                    signal timer_ONOF_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component timer_ONOF_s1_arbitrator;

component timer_ONOF is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component timer_ONOF;

component uart_gps_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal uart_gps_s1_dataavailable : IN STD_LOGIC;
                    signal uart_gps_s1_irq : IN STD_LOGIC;
                    signal uart_gps_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_gps_s1_readyfordata : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_uart_gps_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_uart_gps_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_uart_gps_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_uart_gps_s1 : OUT STD_LOGIC;
                    signal d1_uart_gps_s1_end_xfer : OUT STD_LOGIC;
                    signal uart_gps_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal uart_gps_s1_begintransfer : OUT STD_LOGIC;
                    signal uart_gps_s1_chipselect : OUT STD_LOGIC;
                    signal uart_gps_s1_dataavailable_from_sa : OUT STD_LOGIC;
                    signal uart_gps_s1_irq_from_sa : OUT STD_LOGIC;
                    signal uart_gps_s1_read_n : OUT STD_LOGIC;
                    signal uart_gps_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_gps_s1_readyfordata_from_sa : OUT STD_LOGIC;
                    signal uart_gps_s1_reset_n : OUT STD_LOGIC;
                    signal uart_gps_s1_write_n : OUT STD_LOGIC;
                    signal uart_gps_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component uart_gps_s1_arbitrator;

component uart_gps is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal begintransfer : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal rxd : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal txd : OUT STD_LOGIC
                 );
end component uart_gps;

component uart_xbee_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal uart_xbee_s1_dataavailable : IN STD_LOGIC;
                    signal uart_xbee_s1_irq : IN STD_LOGIC;
                    signal uart_xbee_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_xbee_s1_readyfordata : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_uart_xbee_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_uart_xbee_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_uart_xbee_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_uart_xbee_s1 : OUT STD_LOGIC;
                    signal d1_uart_xbee_s1_end_xfer : OUT STD_LOGIC;
                    signal uart_xbee_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal uart_xbee_s1_begintransfer : OUT STD_LOGIC;
                    signal uart_xbee_s1_chipselect : OUT STD_LOGIC;
                    signal uart_xbee_s1_dataavailable_from_sa : OUT STD_LOGIC;
                    signal uart_xbee_s1_irq_from_sa : OUT STD_LOGIC;
                    signal uart_xbee_s1_read_n : OUT STD_LOGIC;
                    signal uart_xbee_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_xbee_s1_readyfordata_from_sa : OUT STD_LOGIC;
                    signal uart_xbee_s1_reset_n : OUT STD_LOGIC;
                    signal uart_xbee_s1_write_n : OUT STD_LOGIC;
                    signal uart_xbee_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component uart_xbee_s1_arbitrator;

component uart_xbee is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal begintransfer : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal rxd : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal txd : OUT STD_LOGIC
                 );
end component uart_xbee;

component NiosII_reset_sys_clk_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component NiosII_reset_sys_clk_domain_synch_module;

component NiosII_reset_clk_50_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component NiosII_reset_clk_50_domain_synch_module;

component NiosII_reset_sdram_clk_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component NiosII_reset_sdram_clk_domain_synch_module;

                signal NiosII_clock_0_in_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal NiosII_clock_0_in_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_0_in_endofpacket :  STD_LOGIC;
                signal NiosII_clock_0_in_endofpacket_from_sa :  STD_LOGIC;
                signal NiosII_clock_0_in_nativeaddress :  STD_LOGIC_VECTOR (23 DOWNTO 0);
                signal NiosII_clock_0_in_read :  STD_LOGIC;
                signal NiosII_clock_0_in_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_0_in_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_0_in_reset_n :  STD_LOGIC;
                signal NiosII_clock_0_in_waitrequest :  STD_LOGIC;
                signal NiosII_clock_0_in_waitrequest_from_sa :  STD_LOGIC;
                signal NiosII_clock_0_in_write :  STD_LOGIC;
                signal NiosII_clock_0_in_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_0_out_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal NiosII_clock_0_out_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal NiosII_clock_0_out_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_0_out_endofpacket :  STD_LOGIC;
                signal NiosII_clock_0_out_granted_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_0_out_nativeaddress :  STD_LOGIC_VECTOR (23 DOWNTO 0);
                signal NiosII_clock_0_out_qualified_request_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_0_out_read :  STD_LOGIC;
                signal NiosII_clock_0_out_read_data_valid_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal NiosII_clock_0_out_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_0_out_requests_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_0_out_reset_n :  STD_LOGIC;
                signal NiosII_clock_0_out_waitrequest :  STD_LOGIC;
                signal NiosII_clock_0_out_write :  STD_LOGIC;
                signal NiosII_clock_0_out_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_1_in_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal NiosII_clock_1_in_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_1_in_endofpacket :  STD_LOGIC;
                signal NiosII_clock_1_in_endofpacket_from_sa :  STD_LOGIC;
                signal NiosII_clock_1_in_nativeaddress :  STD_LOGIC_VECTOR (23 DOWNTO 0);
                signal NiosII_clock_1_in_read :  STD_LOGIC;
                signal NiosII_clock_1_in_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_1_in_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_1_in_reset_n :  STD_LOGIC;
                signal NiosII_clock_1_in_waitrequest :  STD_LOGIC;
                signal NiosII_clock_1_in_waitrequest_from_sa :  STD_LOGIC;
                signal NiosII_clock_1_in_write :  STD_LOGIC;
                signal NiosII_clock_1_in_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_1_out_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal NiosII_clock_1_out_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal NiosII_clock_1_out_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_1_out_endofpacket :  STD_LOGIC;
                signal NiosII_clock_1_out_granted_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_1_out_nativeaddress :  STD_LOGIC_VECTOR (23 DOWNTO 0);
                signal NiosII_clock_1_out_qualified_request_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_1_out_read :  STD_LOGIC;
                signal NiosII_clock_1_out_read_data_valid_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal NiosII_clock_1_out_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_1_out_requests_sdram_s1 :  STD_LOGIC;
                signal NiosII_clock_1_out_reset_n :  STD_LOGIC;
                signal NiosII_clock_1_out_waitrequest :  STD_LOGIC;
                signal NiosII_clock_1_out_write :  STD_LOGIC;
                signal NiosII_clock_1_out_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_2_in_address :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal NiosII_clock_2_in_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal NiosII_clock_2_in_endofpacket :  STD_LOGIC;
                signal NiosII_clock_2_in_endofpacket_from_sa :  STD_LOGIC;
                signal NiosII_clock_2_in_nativeaddress :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_2_in_read :  STD_LOGIC;
                signal NiosII_clock_2_in_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal NiosII_clock_2_in_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal NiosII_clock_2_in_reset_n :  STD_LOGIC;
                signal NiosII_clock_2_in_waitrequest :  STD_LOGIC;
                signal NiosII_clock_2_in_waitrequest_from_sa :  STD_LOGIC;
                signal NiosII_clock_2_in_write :  STD_LOGIC;
                signal NiosII_clock_2_in_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal NiosII_clock_2_out_address :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal NiosII_clock_2_out_address_to_slave :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal NiosII_clock_2_out_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal NiosII_clock_2_out_endofpacket :  STD_LOGIC;
                signal NiosII_clock_2_out_granted_pll_pll_slave :  STD_LOGIC;
                signal NiosII_clock_2_out_nativeaddress :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal NiosII_clock_2_out_qualified_request_pll_pll_slave :  STD_LOGIC;
                signal NiosII_clock_2_out_read :  STD_LOGIC;
                signal NiosII_clock_2_out_read_data_valid_pll_pll_slave :  STD_LOGIC;
                signal NiosII_clock_2_out_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal NiosII_clock_2_out_requests_pll_pll_slave :  STD_LOGIC;
                signal NiosII_clock_2_out_reset_n :  STD_LOGIC;
                signal NiosII_clock_2_out_waitrequest :  STD_LOGIC;
                signal NiosII_clock_2_out_write :  STD_LOGIC;
                signal NiosII_clock_2_out_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_1_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_1_s1_chipselect :  STD_LOGIC;
                signal PWM_1_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_1_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_1_s1_reset_n :  STD_LOGIC;
                signal PWM_1_s1_write_n :  STD_LOGIC;
                signal PWM_1_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_2_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_2_s1_chipselect :  STD_LOGIC;
                signal PWM_2_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_2_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_2_s1_reset_n :  STD_LOGIC;
                signal PWM_2_s1_write_n :  STD_LOGIC;
                signal PWM_2_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_3_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_3_s1_chipselect :  STD_LOGIC;
                signal PWM_3_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_3_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_3_s1_reset_n :  STD_LOGIC;
                signal PWM_3_s1_write_n :  STD_LOGIC;
                signal PWM_3_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_4_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PWM_4_s1_chipselect :  STD_LOGIC;
                signal PWM_4_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_4_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PWM_4_s1_reset_n :  STD_LOGIC;
                signal PWM_4_s1_write_n :  STD_LOGIC;
                signal PWM_4_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal clk_50_reset_n :  STD_LOGIC;
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_clk_en :  STD_LOGIC;
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_dataa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_datab :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_done :  STD_LOGIC;
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa :  STD_LOGIC;
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_n :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_reset :  STD_LOGIC;
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_result :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_select :  STD_LOGIC;
                signal cpu_altera_nios_custom_instr_floating_point_inst_s1_start :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_a :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_b :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_c :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_clk :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_clk_en :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_dataa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_datab :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_done :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_estatus :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_ipending :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_n :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_readra :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_readrb :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_reset :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_result :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_start :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_status :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_writerc :  STD_LOGIC;
                signal cpu_custom_instruction_master_reset_n :  STD_LOGIC;
                signal cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1 :  STD_LOGIC;
                signal cpu_data_master_address :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_data_master_address_to_slave :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_data_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_data_master_byteenable_NiosII_clock_1_in :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_dbs_write_16 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal cpu_data_master_debugaccess :  STD_LOGIC;
                signal cpu_data_master_granted_NiosII_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_granted_NiosII_clock_2_in :  STD_LOGIC;
                signal cpu_data_master_granted_PWM_1_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_PWM_2_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_PWM_3_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_PWM_4_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_granted_data_tx_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_duty_1_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_duty_2_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_duty_3_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_duty_4_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_entrada_temp_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_granted_out_test_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_sample_time_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_sysid_control_slave :  STD_LOGIC;
                signal cpu_data_master_granted_timer_ONOF_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_uart_gps_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_uart_xbee_s1 :  STD_LOGIC;
                signal cpu_data_master_irq :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_data_master_latency_counter :  STD_LOGIC;
                signal cpu_data_master_qualified_request_NiosII_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_qualified_request_NiosII_clock_2_in :  STD_LOGIC;
                signal cpu_data_master_qualified_request_PWM_1_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_PWM_2_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_PWM_3_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_PWM_4_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_qualified_request_data_tx_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_duty_1_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_duty_2_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_duty_3_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_duty_4_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_entrada_temp_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_out_test_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_sample_time_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_sysid_control_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_timer_ONOF_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_uart_gps_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_uart_xbee_s1 :  STD_LOGIC;
                signal cpu_data_master_read :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_NiosII_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_NiosII_clock_2_in :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_PWM_1_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_PWM_2_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_PWM_3_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_PWM_4_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_data_tx_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_duty_1_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_duty_2_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_duty_3_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_duty_4_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_entrada_temp_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_out_test_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_sample_time_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_sysid_control_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_timer_ONOF_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_uart_gps_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_uart_xbee_s1 :  STD_LOGIC;
                signal cpu_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_data_master_readdatavalid :  STD_LOGIC;
                signal cpu_data_master_requests_NiosII_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_requests_NiosII_clock_2_in :  STD_LOGIC;
                signal cpu_data_master_requests_PWM_1_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_PWM_2_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_PWM_3_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_PWM_4_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_requests_data_tx_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_duty_1_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_duty_2_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_duty_3_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_duty_4_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_ac_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_ac_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_ac_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_gy_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_gy_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_gy_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_ma_eje_X_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_ma_eje_Y_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_ma_eje_Z_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_entrada_temp_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_requests_out_test_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_sample_time_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_sysid_control_slave :  STD_LOGIC;
                signal cpu_data_master_requests_timer_ONOF_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_uart_gps_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_uart_xbee_s1 :  STD_LOGIC;
                signal cpu_data_master_waitrequest :  STD_LOGIC;
                signal cpu_data_master_write :  STD_LOGIC;
                signal cpu_data_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_instruction_master_address :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (26 DOWNTO 0);
                signal cpu_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_granted_NiosII_clock_0_in :  STD_LOGIC;
                signal cpu_instruction_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_latency_counter :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_NiosII_clock_0_in :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_read :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_NiosII_clock_0_in :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_instruction_master_readdatavalid :  STD_LOGIC;
                signal cpu_instruction_master_requests_NiosII_clock_0_in :  STD_LOGIC;
                signal cpu_instruction_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_waitrequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal cpu_jtag_debug_module_begintransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_jtag_debug_module_chipselect :  STD_LOGIC;
                signal cpu_jtag_debug_module_debugaccess :  STD_LOGIC;
                signal cpu_jtag_debug_module_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_jtag_debug_module_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_jtag_debug_module_resetrequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_resetrequest_from_sa :  STD_LOGIC;
                signal cpu_jtag_debug_module_write :  STD_LOGIC;
                signal cpu_jtag_debug_module_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal d1_NiosII_clock_0_in_end_xfer :  STD_LOGIC;
                signal d1_NiosII_clock_1_in_end_xfer :  STD_LOGIC;
                signal d1_NiosII_clock_2_in_end_xfer :  STD_LOGIC;
                signal d1_PWM_1_s1_end_xfer :  STD_LOGIC;
                signal d1_PWM_2_s1_end_xfer :  STD_LOGIC;
                signal d1_PWM_3_s1_end_xfer :  STD_LOGIC;
                signal d1_PWM_4_s1_end_xfer :  STD_LOGIC;
                signal d1_cpu_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal d1_data_tx_s1_end_xfer :  STD_LOGIC;
                signal d1_duty_1_s1_end_xfer :  STD_LOGIC;
                signal d1_duty_2_s1_end_xfer :  STD_LOGIC;
                signal d1_duty_3_s1_end_xfer :  STD_LOGIC;
                signal d1_duty_4_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_ac_eje_X_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_ac_eje_Y_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_ac_eje_Z_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_gy_eje_X_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_gy_eje_Y_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_gy_eje_Z_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_ma_eje_X_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_ma_eje_Y_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_ma_eje_Z_s1_end_xfer :  STD_LOGIC;
                signal d1_entrada_temp_s1_end_xfer :  STD_LOGIC;
                signal d1_epcs_flash_controller_epcs_control_port_end_xfer :  STD_LOGIC;
                signal d1_jtag_uart_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal d1_out_test_s1_end_xfer :  STD_LOGIC;
                signal d1_pll_pll_slave_end_xfer :  STD_LOGIC;
                signal d1_sample_time_s1_end_xfer :  STD_LOGIC;
                signal d1_sdram_s1_end_xfer :  STD_LOGIC;
                signal d1_sysid_control_slave_end_xfer :  STD_LOGIC;
                signal d1_timer_ONOF_s1_end_xfer :  STD_LOGIC;
                signal d1_uart_gps_s1_end_xfer :  STD_LOGIC;
                signal d1_uart_xbee_s1_end_xfer :  STD_LOGIC;
                signal data_tx_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal data_tx_s1_chipselect :  STD_LOGIC;
                signal data_tx_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal data_tx_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal data_tx_s1_reset_n :  STD_LOGIC;
                signal data_tx_s1_write_n :  STD_LOGIC;
                signal data_tx_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_1_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_1_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_1_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_1_s1_reset_n :  STD_LOGIC;
                signal duty_2_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_2_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_2_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_2_s1_reset_n :  STD_LOGIC;
                signal duty_3_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_3_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_3_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_3_s1_reset_n :  STD_LOGIC;
                signal duty_4_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal duty_4_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_4_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal duty_4_s1_reset_n :  STD_LOGIC;
                signal entrada_ac_eje_X_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_X_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ac_eje_X_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ac_eje_X_s1_reset_n :  STD_LOGIC;
                signal entrada_ac_eje_Y_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_Y_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ac_eje_Y_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ac_eje_Y_s1_reset_n :  STD_LOGIC;
                signal entrada_ac_eje_Z_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ac_eje_Z_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ac_eje_Z_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ac_eje_Z_s1_reset_n :  STD_LOGIC;
                signal entrada_gy_eje_X_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_X_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_gy_eje_X_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_gy_eje_X_s1_reset_n :  STD_LOGIC;
                signal entrada_gy_eje_Y_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_Y_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_gy_eje_Y_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_gy_eje_Y_s1_reset_n :  STD_LOGIC;
                signal entrada_gy_eje_Z_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_gy_eje_Z_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_gy_eje_Z_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_gy_eje_Z_s1_reset_n :  STD_LOGIC;
                signal entrada_ma_eje_X_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_X_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ma_eje_X_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ma_eje_X_s1_reset_n :  STD_LOGIC;
                signal entrada_ma_eje_Y_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_Y_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ma_eje_Y_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ma_eje_Y_s1_reset_n :  STD_LOGIC;
                signal entrada_ma_eje_Z_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_ma_eje_Z_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ma_eje_Z_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_ma_eje_Z_s1_reset_n :  STD_LOGIC;
                signal entrada_temp_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal entrada_temp_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_temp_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal entrada_temp_s1_reset_n :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_chipselect :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_dataavailable :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_endofpacket :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_irq :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_irq_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_read_n :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_readyfordata :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_reset_n :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_write_n :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_dclk_from_the_epcs_flash_controller :  STD_LOGIC;
                signal internal_locked_from_the_pll :  STD_LOGIC;
                signal internal_out_port_from_the_PWM_1 :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal internal_out_port_from_the_PWM_2 :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal internal_out_port_from_the_PWM_3 :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal internal_out_port_from_the_PWM_4 :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal internal_out_port_from_the_data_tx :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal internal_out_port_from_the_out_test :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal internal_phasedone_from_the_pll :  STD_LOGIC;
                signal internal_sce_from_the_epcs_flash_controller :  STD_LOGIC;
                signal internal_sdo_from_the_epcs_flash_controller :  STD_LOGIC;
                signal internal_sdram_clk :  STD_LOGIC;
                signal internal_sys_clk :  STD_LOGIC;
                signal internal_txd_from_the_uart_gps :  STD_LOGIC;
                signal internal_txd_from_the_uart_xbee :  STD_LOGIC;
                signal internal_zs_addr_from_the_sdram :  STD_LOGIC_VECTOR (12 DOWNTO 0);
                signal internal_zs_ba_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_cas_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_cke_from_the_sdram :  STD_LOGIC;
                signal internal_zs_cs_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_dqm_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_ras_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_we_n_from_the_sdram :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_address :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_chipselect :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_dataavailable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_irq :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_irq_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_read_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_readyfordata :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_reset_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waitrequest :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_write_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal module_input6 :  STD_LOGIC;
                signal module_input7 :  STD_LOGIC;
                signal module_input8 :  STD_LOGIC;
                signal out_clk_pll_c0 :  STD_LOGIC;
                signal out_clk_pll_c1 :  STD_LOGIC;
                signal out_test_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal out_test_s1_chipselect :  STD_LOGIC;
                signal out_test_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal out_test_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal out_test_s1_reset_n :  STD_LOGIC;
                signal out_test_s1_write_n :  STD_LOGIC;
                signal out_test_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pll_pll_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pll_pll_slave_read :  STD_LOGIC;
                signal pll_pll_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pll_pll_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pll_pll_slave_reset :  STD_LOGIC;
                signal pll_pll_slave_write :  STD_LOGIC;
                signal pll_pll_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal reset_n_sources :  STD_LOGIC;
                signal sample_time_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sample_time_s1_chipselect :  STD_LOGIC;
                signal sample_time_s1_irq :  STD_LOGIC;
                signal sample_time_s1_irq_from_sa :  STD_LOGIC;
                signal sample_time_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sample_time_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sample_time_s1_reset_n :  STD_LOGIC;
                signal sample_time_s1_write_n :  STD_LOGIC;
                signal sample_time_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_clk_reset_n :  STD_LOGIC;
                signal sdram_s1_address :  STD_LOGIC_VECTOR (23 DOWNTO 0);
                signal sdram_s1_byteenable_n :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_chipselect :  STD_LOGIC;
                signal sdram_s1_read_n :  STD_LOGIC;
                signal sdram_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_s1_readdatavalid :  STD_LOGIC;
                signal sdram_s1_reset_n :  STD_LOGIC;
                signal sdram_s1_waitrequest :  STD_LOGIC;
                signal sdram_s1_waitrequest_from_sa :  STD_LOGIC;
                signal sdram_s1_write_n :  STD_LOGIC;
                signal sdram_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sys_clk_reset_n :  STD_LOGIC;
                signal sysid_control_slave_address :  STD_LOGIC;
                signal sysid_control_slave_clock :  STD_LOGIC;
                signal sysid_control_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal sysid_control_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal sysid_control_slave_reset_n :  STD_LOGIC;
                signal timer_ONOF_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_ONOF_s1_chipselect :  STD_LOGIC;
                signal timer_ONOF_s1_irq :  STD_LOGIC;
                signal timer_ONOF_s1_irq_from_sa :  STD_LOGIC;
                signal timer_ONOF_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal timer_ONOF_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal timer_ONOF_s1_reset_n :  STD_LOGIC;
                signal timer_ONOF_s1_write_n :  STD_LOGIC;
                signal timer_ONOF_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_gps_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal uart_gps_s1_begintransfer :  STD_LOGIC;
                signal uart_gps_s1_chipselect :  STD_LOGIC;
                signal uart_gps_s1_dataavailable :  STD_LOGIC;
                signal uart_gps_s1_dataavailable_from_sa :  STD_LOGIC;
                signal uart_gps_s1_irq :  STD_LOGIC;
                signal uart_gps_s1_irq_from_sa :  STD_LOGIC;
                signal uart_gps_s1_read_n :  STD_LOGIC;
                signal uart_gps_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_gps_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_gps_s1_readyfordata :  STD_LOGIC;
                signal uart_gps_s1_readyfordata_from_sa :  STD_LOGIC;
                signal uart_gps_s1_reset_n :  STD_LOGIC;
                signal uart_gps_s1_write_n :  STD_LOGIC;
                signal uart_gps_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_xbee_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal uart_xbee_s1_begintransfer :  STD_LOGIC;
                signal uart_xbee_s1_chipselect :  STD_LOGIC;
                signal uart_xbee_s1_dataavailable :  STD_LOGIC;
                signal uart_xbee_s1_dataavailable_from_sa :  STD_LOGIC;
                signal uart_xbee_s1_irq :  STD_LOGIC;
                signal uart_xbee_s1_irq_from_sa :  STD_LOGIC;
                signal uart_xbee_s1_read_n :  STD_LOGIC;
                signal uart_xbee_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_xbee_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_xbee_s1_readyfordata :  STD_LOGIC;
                signal uart_xbee_s1_readyfordata_from_sa :  STD_LOGIC;
                signal uart_xbee_s1_reset_n :  STD_LOGIC;
                signal uart_xbee_s1_write_n :  STD_LOGIC;
                signal uart_xbee_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);

begin

  --the_NiosII_clock_0_in, which is an e_instance
  the_NiosII_clock_0_in : NiosII_clock_0_in_arbitrator
    port map(
      NiosII_clock_0_in_address => NiosII_clock_0_in_address,
      NiosII_clock_0_in_byteenable => NiosII_clock_0_in_byteenable,
      NiosII_clock_0_in_endofpacket_from_sa => NiosII_clock_0_in_endofpacket_from_sa,
      NiosII_clock_0_in_nativeaddress => NiosII_clock_0_in_nativeaddress,
      NiosII_clock_0_in_read => NiosII_clock_0_in_read,
      NiosII_clock_0_in_readdata_from_sa => NiosII_clock_0_in_readdata_from_sa,
      NiosII_clock_0_in_reset_n => NiosII_clock_0_in_reset_n,
      NiosII_clock_0_in_waitrequest_from_sa => NiosII_clock_0_in_waitrequest_from_sa,
      NiosII_clock_0_in_write => NiosII_clock_0_in_write,
      cpu_instruction_master_granted_NiosII_clock_0_in => cpu_instruction_master_granted_NiosII_clock_0_in,
      cpu_instruction_master_qualified_request_NiosII_clock_0_in => cpu_instruction_master_qualified_request_NiosII_clock_0_in,
      cpu_instruction_master_read_data_valid_NiosII_clock_0_in => cpu_instruction_master_read_data_valid_NiosII_clock_0_in,
      cpu_instruction_master_requests_NiosII_clock_0_in => cpu_instruction_master_requests_NiosII_clock_0_in,
      d1_NiosII_clock_0_in_end_xfer => d1_NiosII_clock_0_in_end_xfer,
      NiosII_clock_0_in_endofpacket => NiosII_clock_0_in_endofpacket,
      NiosII_clock_0_in_readdata => NiosII_clock_0_in_readdata,
      NiosII_clock_0_in_waitrequest => NiosII_clock_0_in_waitrequest,
      clk => internal_sys_clk,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_dbs_address => cpu_instruction_master_dbs_address,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      reset_n => sys_clk_reset_n
    );


  --the_NiosII_clock_0_out, which is an e_instance
  the_NiosII_clock_0_out : NiosII_clock_0_out_arbitrator
    port map(
      NiosII_clock_0_out_address_to_slave => NiosII_clock_0_out_address_to_slave,
      NiosII_clock_0_out_readdata => NiosII_clock_0_out_readdata,
      NiosII_clock_0_out_reset_n => NiosII_clock_0_out_reset_n,
      NiosII_clock_0_out_waitrequest => NiosII_clock_0_out_waitrequest,
      NiosII_clock_0_out_address => NiosII_clock_0_out_address,
      NiosII_clock_0_out_byteenable => NiosII_clock_0_out_byteenable,
      NiosII_clock_0_out_granted_sdram_s1 => NiosII_clock_0_out_granted_sdram_s1,
      NiosII_clock_0_out_qualified_request_sdram_s1 => NiosII_clock_0_out_qualified_request_sdram_s1,
      NiosII_clock_0_out_read => NiosII_clock_0_out_read,
      NiosII_clock_0_out_read_data_valid_sdram_s1 => NiosII_clock_0_out_read_data_valid_sdram_s1,
      NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register => NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register,
      NiosII_clock_0_out_requests_sdram_s1 => NiosII_clock_0_out_requests_sdram_s1,
      NiosII_clock_0_out_write => NiosII_clock_0_out_write,
      NiosII_clock_0_out_writedata => NiosII_clock_0_out_writedata,
      clk => internal_sdram_clk,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      reset_n => sdram_clk_reset_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa
    );


  --the_NiosII_clock_0, which is an e_ptf_instance
  the_NiosII_clock_0 : NiosII_clock_0
    port map(
      master_address => NiosII_clock_0_out_address,
      master_byteenable => NiosII_clock_0_out_byteenable,
      master_nativeaddress => NiosII_clock_0_out_nativeaddress,
      master_read => NiosII_clock_0_out_read,
      master_write => NiosII_clock_0_out_write,
      master_writedata => NiosII_clock_0_out_writedata,
      slave_endofpacket => NiosII_clock_0_in_endofpacket,
      slave_readdata => NiosII_clock_0_in_readdata,
      slave_waitrequest => NiosII_clock_0_in_waitrequest,
      master_clk => internal_sdram_clk,
      master_endofpacket => NiosII_clock_0_out_endofpacket,
      master_readdata => NiosII_clock_0_out_readdata,
      master_reset_n => NiosII_clock_0_out_reset_n,
      master_waitrequest => NiosII_clock_0_out_waitrequest,
      slave_address => NiosII_clock_0_in_address,
      slave_byteenable => NiosII_clock_0_in_byteenable,
      slave_clk => internal_sys_clk,
      slave_nativeaddress => NiosII_clock_0_in_nativeaddress,
      slave_read => NiosII_clock_0_in_read,
      slave_reset_n => NiosII_clock_0_in_reset_n,
      slave_write => NiosII_clock_0_in_write,
      slave_writedata => NiosII_clock_0_in_writedata
    );


  --the_NiosII_clock_1_in, which is an e_instance
  the_NiosII_clock_1_in : NiosII_clock_1_in_arbitrator
    port map(
      NiosII_clock_1_in_address => NiosII_clock_1_in_address,
      NiosII_clock_1_in_byteenable => NiosII_clock_1_in_byteenable,
      NiosII_clock_1_in_endofpacket_from_sa => NiosII_clock_1_in_endofpacket_from_sa,
      NiosII_clock_1_in_nativeaddress => NiosII_clock_1_in_nativeaddress,
      NiosII_clock_1_in_read => NiosII_clock_1_in_read,
      NiosII_clock_1_in_readdata_from_sa => NiosII_clock_1_in_readdata_from_sa,
      NiosII_clock_1_in_reset_n => NiosII_clock_1_in_reset_n,
      NiosII_clock_1_in_waitrequest_from_sa => NiosII_clock_1_in_waitrequest_from_sa,
      NiosII_clock_1_in_write => NiosII_clock_1_in_write,
      NiosII_clock_1_in_writedata => NiosII_clock_1_in_writedata,
      cpu_data_master_byteenable_NiosII_clock_1_in => cpu_data_master_byteenable_NiosII_clock_1_in,
      cpu_data_master_granted_NiosII_clock_1_in => cpu_data_master_granted_NiosII_clock_1_in,
      cpu_data_master_qualified_request_NiosII_clock_1_in => cpu_data_master_qualified_request_NiosII_clock_1_in,
      cpu_data_master_read_data_valid_NiosII_clock_1_in => cpu_data_master_read_data_valid_NiosII_clock_1_in,
      cpu_data_master_requests_NiosII_clock_1_in => cpu_data_master_requests_NiosII_clock_1_in,
      d1_NiosII_clock_1_in_end_xfer => d1_NiosII_clock_1_in_end_xfer,
      NiosII_clock_1_in_endofpacket => NiosII_clock_1_in_endofpacket,
      NiosII_clock_1_in_readdata => NiosII_clock_1_in_readdata,
      NiosII_clock_1_in_waitrequest => NiosII_clock_1_in_waitrequest,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_16 => cpu_data_master_dbs_write_16,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => sys_clk_reset_n
    );


  --the_NiosII_clock_1_out, which is an e_instance
  the_NiosII_clock_1_out : NiosII_clock_1_out_arbitrator
    port map(
      NiosII_clock_1_out_address_to_slave => NiosII_clock_1_out_address_to_slave,
      NiosII_clock_1_out_readdata => NiosII_clock_1_out_readdata,
      NiosII_clock_1_out_reset_n => NiosII_clock_1_out_reset_n,
      NiosII_clock_1_out_waitrequest => NiosII_clock_1_out_waitrequest,
      NiosII_clock_1_out_address => NiosII_clock_1_out_address,
      NiosII_clock_1_out_byteenable => NiosII_clock_1_out_byteenable,
      NiosII_clock_1_out_granted_sdram_s1 => NiosII_clock_1_out_granted_sdram_s1,
      NiosII_clock_1_out_qualified_request_sdram_s1 => NiosII_clock_1_out_qualified_request_sdram_s1,
      NiosII_clock_1_out_read => NiosII_clock_1_out_read,
      NiosII_clock_1_out_read_data_valid_sdram_s1 => NiosII_clock_1_out_read_data_valid_sdram_s1,
      NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register => NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register,
      NiosII_clock_1_out_requests_sdram_s1 => NiosII_clock_1_out_requests_sdram_s1,
      NiosII_clock_1_out_write => NiosII_clock_1_out_write,
      NiosII_clock_1_out_writedata => NiosII_clock_1_out_writedata,
      clk => internal_sdram_clk,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      reset_n => sdram_clk_reset_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa
    );


  --the_NiosII_clock_1, which is an e_ptf_instance
  the_NiosII_clock_1 : NiosII_clock_1
    port map(
      master_address => NiosII_clock_1_out_address,
      master_byteenable => NiosII_clock_1_out_byteenable,
      master_nativeaddress => NiosII_clock_1_out_nativeaddress,
      master_read => NiosII_clock_1_out_read,
      master_write => NiosII_clock_1_out_write,
      master_writedata => NiosII_clock_1_out_writedata,
      slave_endofpacket => NiosII_clock_1_in_endofpacket,
      slave_readdata => NiosII_clock_1_in_readdata,
      slave_waitrequest => NiosII_clock_1_in_waitrequest,
      master_clk => internal_sdram_clk,
      master_endofpacket => NiosII_clock_1_out_endofpacket,
      master_readdata => NiosII_clock_1_out_readdata,
      master_reset_n => NiosII_clock_1_out_reset_n,
      master_waitrequest => NiosII_clock_1_out_waitrequest,
      slave_address => NiosII_clock_1_in_address,
      slave_byteenable => NiosII_clock_1_in_byteenable,
      slave_clk => internal_sys_clk,
      slave_nativeaddress => NiosII_clock_1_in_nativeaddress,
      slave_read => NiosII_clock_1_in_read,
      slave_reset_n => NiosII_clock_1_in_reset_n,
      slave_write => NiosII_clock_1_in_write,
      slave_writedata => NiosII_clock_1_in_writedata
    );


  --the_NiosII_clock_2_in, which is an e_instance
  the_NiosII_clock_2_in : NiosII_clock_2_in_arbitrator
    port map(
      NiosII_clock_2_in_address => NiosII_clock_2_in_address,
      NiosII_clock_2_in_byteenable => NiosII_clock_2_in_byteenable,
      NiosII_clock_2_in_endofpacket_from_sa => NiosII_clock_2_in_endofpacket_from_sa,
      NiosII_clock_2_in_nativeaddress => NiosII_clock_2_in_nativeaddress,
      NiosII_clock_2_in_read => NiosII_clock_2_in_read,
      NiosII_clock_2_in_readdata_from_sa => NiosII_clock_2_in_readdata_from_sa,
      NiosII_clock_2_in_reset_n => NiosII_clock_2_in_reset_n,
      NiosII_clock_2_in_waitrequest_from_sa => NiosII_clock_2_in_waitrequest_from_sa,
      NiosII_clock_2_in_write => NiosII_clock_2_in_write,
      NiosII_clock_2_in_writedata => NiosII_clock_2_in_writedata,
      cpu_data_master_granted_NiosII_clock_2_in => cpu_data_master_granted_NiosII_clock_2_in,
      cpu_data_master_qualified_request_NiosII_clock_2_in => cpu_data_master_qualified_request_NiosII_clock_2_in,
      cpu_data_master_read_data_valid_NiosII_clock_2_in => cpu_data_master_read_data_valid_NiosII_clock_2_in,
      cpu_data_master_requests_NiosII_clock_2_in => cpu_data_master_requests_NiosII_clock_2_in,
      d1_NiosII_clock_2_in_end_xfer => d1_NiosII_clock_2_in_end_xfer,
      NiosII_clock_2_in_endofpacket => NiosII_clock_2_in_endofpacket,
      NiosII_clock_2_in_readdata => NiosII_clock_2_in_readdata,
      NiosII_clock_2_in_waitrequest => NiosII_clock_2_in_waitrequest,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n
    );


  --the_NiosII_clock_2_out, which is an e_instance
  the_NiosII_clock_2_out : NiosII_clock_2_out_arbitrator
    port map(
      NiosII_clock_2_out_address_to_slave => NiosII_clock_2_out_address_to_slave,
      NiosII_clock_2_out_readdata => NiosII_clock_2_out_readdata,
      NiosII_clock_2_out_reset_n => NiosII_clock_2_out_reset_n,
      NiosII_clock_2_out_waitrequest => NiosII_clock_2_out_waitrequest,
      NiosII_clock_2_out_address => NiosII_clock_2_out_address,
      NiosII_clock_2_out_byteenable => NiosII_clock_2_out_byteenable,
      NiosII_clock_2_out_granted_pll_pll_slave => NiosII_clock_2_out_granted_pll_pll_slave,
      NiosII_clock_2_out_qualified_request_pll_pll_slave => NiosII_clock_2_out_qualified_request_pll_pll_slave,
      NiosII_clock_2_out_read => NiosII_clock_2_out_read,
      NiosII_clock_2_out_read_data_valid_pll_pll_slave => NiosII_clock_2_out_read_data_valid_pll_pll_slave,
      NiosII_clock_2_out_requests_pll_pll_slave => NiosII_clock_2_out_requests_pll_pll_slave,
      NiosII_clock_2_out_write => NiosII_clock_2_out_write,
      NiosII_clock_2_out_writedata => NiosII_clock_2_out_writedata,
      clk => clk_50,
      d1_pll_pll_slave_end_xfer => d1_pll_pll_slave_end_xfer,
      pll_pll_slave_readdata_from_sa => pll_pll_slave_readdata_from_sa,
      reset_n => clk_50_reset_n
    );


  --the_NiosII_clock_2, which is an e_ptf_instance
  the_NiosII_clock_2 : NiosII_clock_2
    port map(
      master_address => NiosII_clock_2_out_address,
      master_byteenable => NiosII_clock_2_out_byteenable,
      master_nativeaddress => NiosII_clock_2_out_nativeaddress,
      master_read => NiosII_clock_2_out_read,
      master_write => NiosII_clock_2_out_write,
      master_writedata => NiosII_clock_2_out_writedata,
      slave_endofpacket => NiosII_clock_2_in_endofpacket,
      slave_readdata => NiosII_clock_2_in_readdata,
      slave_waitrequest => NiosII_clock_2_in_waitrequest,
      master_clk => clk_50,
      master_endofpacket => NiosII_clock_2_out_endofpacket,
      master_readdata => NiosII_clock_2_out_readdata,
      master_reset_n => NiosII_clock_2_out_reset_n,
      master_waitrequest => NiosII_clock_2_out_waitrequest,
      slave_address => NiosII_clock_2_in_address,
      slave_byteenable => NiosII_clock_2_in_byteenable,
      slave_clk => internal_sys_clk,
      slave_nativeaddress => NiosII_clock_2_in_nativeaddress,
      slave_read => NiosII_clock_2_in_read,
      slave_reset_n => NiosII_clock_2_in_reset_n,
      slave_write => NiosII_clock_2_in_write,
      slave_writedata => NiosII_clock_2_in_writedata
    );


  --the_PWM_1_s1, which is an e_instance
  the_PWM_1_s1 : PWM_1_s1_arbitrator
    port map(
      PWM_1_s1_address => PWM_1_s1_address,
      PWM_1_s1_chipselect => PWM_1_s1_chipselect,
      PWM_1_s1_readdata_from_sa => PWM_1_s1_readdata_from_sa,
      PWM_1_s1_reset_n => PWM_1_s1_reset_n,
      PWM_1_s1_write_n => PWM_1_s1_write_n,
      PWM_1_s1_writedata => PWM_1_s1_writedata,
      cpu_data_master_granted_PWM_1_s1 => cpu_data_master_granted_PWM_1_s1,
      cpu_data_master_qualified_request_PWM_1_s1 => cpu_data_master_qualified_request_PWM_1_s1,
      cpu_data_master_read_data_valid_PWM_1_s1 => cpu_data_master_read_data_valid_PWM_1_s1,
      cpu_data_master_requests_PWM_1_s1 => cpu_data_master_requests_PWM_1_s1,
      d1_PWM_1_s1_end_xfer => d1_PWM_1_s1_end_xfer,
      PWM_1_s1_readdata => PWM_1_s1_readdata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n
    );


  --the_PWM_1, which is an e_ptf_instance
  the_PWM_1 : PWM_1
    port map(
      out_port => internal_out_port_from_the_PWM_1,
      readdata => PWM_1_s1_readdata,
      address => PWM_1_s1_address,
      chipselect => PWM_1_s1_chipselect,
      clk => internal_sys_clk,
      reset_n => PWM_1_s1_reset_n,
      write_n => PWM_1_s1_write_n,
      writedata => PWM_1_s1_writedata
    );


  --the_PWM_2_s1, which is an e_instance
  the_PWM_2_s1 : PWM_2_s1_arbitrator
    port map(
      PWM_2_s1_address => PWM_2_s1_address,
      PWM_2_s1_chipselect => PWM_2_s1_chipselect,
      PWM_2_s1_readdata_from_sa => PWM_2_s1_readdata_from_sa,
      PWM_2_s1_reset_n => PWM_2_s1_reset_n,
      PWM_2_s1_write_n => PWM_2_s1_write_n,
      PWM_2_s1_writedata => PWM_2_s1_writedata,
      cpu_data_master_granted_PWM_2_s1 => cpu_data_master_granted_PWM_2_s1,
      cpu_data_master_qualified_request_PWM_2_s1 => cpu_data_master_qualified_request_PWM_2_s1,
      cpu_data_master_read_data_valid_PWM_2_s1 => cpu_data_master_read_data_valid_PWM_2_s1,
      cpu_data_master_requests_PWM_2_s1 => cpu_data_master_requests_PWM_2_s1,
      d1_PWM_2_s1_end_xfer => d1_PWM_2_s1_end_xfer,
      PWM_2_s1_readdata => PWM_2_s1_readdata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n
    );


  --the_PWM_2, which is an e_ptf_instance
  the_PWM_2 : PWM_2
    port map(
      out_port => internal_out_port_from_the_PWM_2,
      readdata => PWM_2_s1_readdata,
      address => PWM_2_s1_address,
      chipselect => PWM_2_s1_chipselect,
      clk => internal_sys_clk,
      reset_n => PWM_2_s1_reset_n,
      write_n => PWM_2_s1_write_n,
      writedata => PWM_2_s1_writedata
    );


  --the_PWM_3_s1, which is an e_instance
  the_PWM_3_s1 : PWM_3_s1_arbitrator
    port map(
      PWM_3_s1_address => PWM_3_s1_address,
      PWM_3_s1_chipselect => PWM_3_s1_chipselect,
      PWM_3_s1_readdata_from_sa => PWM_3_s1_readdata_from_sa,
      PWM_3_s1_reset_n => PWM_3_s1_reset_n,
      PWM_3_s1_write_n => PWM_3_s1_write_n,
      PWM_3_s1_writedata => PWM_3_s1_writedata,
      cpu_data_master_granted_PWM_3_s1 => cpu_data_master_granted_PWM_3_s1,
      cpu_data_master_qualified_request_PWM_3_s1 => cpu_data_master_qualified_request_PWM_3_s1,
      cpu_data_master_read_data_valid_PWM_3_s1 => cpu_data_master_read_data_valid_PWM_3_s1,
      cpu_data_master_requests_PWM_3_s1 => cpu_data_master_requests_PWM_3_s1,
      d1_PWM_3_s1_end_xfer => d1_PWM_3_s1_end_xfer,
      PWM_3_s1_readdata => PWM_3_s1_readdata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n
    );


  --the_PWM_3, which is an e_ptf_instance
  the_PWM_3 : PWM_3
    port map(
      out_port => internal_out_port_from_the_PWM_3,
      readdata => PWM_3_s1_readdata,
      address => PWM_3_s1_address,
      chipselect => PWM_3_s1_chipselect,
      clk => internal_sys_clk,
      reset_n => PWM_3_s1_reset_n,
      write_n => PWM_3_s1_write_n,
      writedata => PWM_3_s1_writedata
    );


  --the_PWM_4_s1, which is an e_instance
  the_PWM_4_s1 : PWM_4_s1_arbitrator
    port map(
      PWM_4_s1_address => PWM_4_s1_address,
      PWM_4_s1_chipselect => PWM_4_s1_chipselect,
      PWM_4_s1_readdata_from_sa => PWM_4_s1_readdata_from_sa,
      PWM_4_s1_reset_n => PWM_4_s1_reset_n,
      PWM_4_s1_write_n => PWM_4_s1_write_n,
      PWM_4_s1_writedata => PWM_4_s1_writedata,
      cpu_data_master_granted_PWM_4_s1 => cpu_data_master_granted_PWM_4_s1,
      cpu_data_master_qualified_request_PWM_4_s1 => cpu_data_master_qualified_request_PWM_4_s1,
      cpu_data_master_read_data_valid_PWM_4_s1 => cpu_data_master_read_data_valid_PWM_4_s1,
      cpu_data_master_requests_PWM_4_s1 => cpu_data_master_requests_PWM_4_s1,
      d1_PWM_4_s1_end_xfer => d1_PWM_4_s1_end_xfer,
      PWM_4_s1_readdata => PWM_4_s1_readdata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n
    );


  --the_PWM_4, which is an e_ptf_instance
  the_PWM_4 : PWM_4
    port map(
      out_port => internal_out_port_from_the_PWM_4,
      readdata => PWM_4_s1_readdata,
      address => PWM_4_s1_address,
      chipselect => PWM_4_s1_chipselect,
      clk => internal_sys_clk,
      reset_n => PWM_4_s1_reset_n,
      write_n => PWM_4_s1_write_n,
      writedata => PWM_4_s1_writedata
    );


  --the_cpu_jtag_debug_module, which is an e_instance
  the_cpu_jtag_debug_module : cpu_jtag_debug_module_arbitrator
    port map(
      cpu_data_master_granted_cpu_jtag_debug_module => cpu_data_master_granted_cpu_jtag_debug_module,
      cpu_data_master_qualified_request_cpu_jtag_debug_module => cpu_data_master_qualified_request_cpu_jtag_debug_module,
      cpu_data_master_read_data_valid_cpu_jtag_debug_module => cpu_data_master_read_data_valid_cpu_jtag_debug_module,
      cpu_data_master_requests_cpu_jtag_debug_module => cpu_data_master_requests_cpu_jtag_debug_module,
      cpu_instruction_master_granted_cpu_jtag_debug_module => cpu_instruction_master_granted_cpu_jtag_debug_module,
      cpu_instruction_master_qualified_request_cpu_jtag_debug_module => cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
      cpu_instruction_master_read_data_valid_cpu_jtag_debug_module => cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
      cpu_instruction_master_requests_cpu_jtag_debug_module => cpu_instruction_master_requests_cpu_jtag_debug_module,
      cpu_jtag_debug_module_address => cpu_jtag_debug_module_address,
      cpu_jtag_debug_module_begintransfer => cpu_jtag_debug_module_begintransfer,
      cpu_jtag_debug_module_byteenable => cpu_jtag_debug_module_byteenable,
      cpu_jtag_debug_module_chipselect => cpu_jtag_debug_module_chipselect,
      cpu_jtag_debug_module_debugaccess => cpu_jtag_debug_module_debugaccess,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      cpu_jtag_debug_module_resetrequest_from_sa => cpu_jtag_debug_module_resetrequest_from_sa,
      cpu_jtag_debug_module_write => cpu_jtag_debug_module_write,
      cpu_jtag_debug_module_writedata => cpu_jtag_debug_module_writedata,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_debugaccess => cpu_data_master_debugaccess,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_jtag_debug_module_readdata => cpu_jtag_debug_module_readdata,
      cpu_jtag_debug_module_resetrequest => cpu_jtag_debug_module_resetrequest,
      reset_n => sys_clk_reset_n
    );


  --the_cpu_custom_instruction_master, which is an e_instance
  the_cpu_custom_instruction_master : cpu_custom_instruction_master_arbitrator
    port map(
      cpu_altera_nios_custom_instr_floating_point_inst_s1_select => cpu_altera_nios_custom_instr_floating_point_inst_s1_select,
      cpu_custom_instruction_master_multi_done => cpu_custom_instruction_master_multi_done,
      cpu_custom_instruction_master_multi_result => cpu_custom_instruction_master_multi_result,
      cpu_custom_instruction_master_reset_n => cpu_custom_instruction_master_reset_n,
      cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1 => cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1,
      clk => internal_sys_clk,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa => cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa => cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa,
      cpu_custom_instruction_master_multi_start => cpu_custom_instruction_master_multi_start,
      reset_n => sys_clk_reset_n
    );


  --the_cpu_data_master, which is an e_instance
  the_cpu_data_master : cpu_data_master_arbitrator
    port map(
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_16 => cpu_data_master_dbs_write_16,
      cpu_data_master_irq => cpu_data_master_irq,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_readdata => cpu_data_master_readdata,
      cpu_data_master_readdatavalid => cpu_data_master_readdatavalid,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      NiosII_clock_1_in_readdata_from_sa => NiosII_clock_1_in_readdata_from_sa,
      NiosII_clock_1_in_waitrequest_from_sa => NiosII_clock_1_in_waitrequest_from_sa,
      NiosII_clock_2_in_readdata_from_sa => NiosII_clock_2_in_readdata_from_sa,
      NiosII_clock_2_in_waitrequest_from_sa => NiosII_clock_2_in_waitrequest_from_sa,
      PWM_1_s1_readdata_from_sa => PWM_1_s1_readdata_from_sa,
      PWM_2_s1_readdata_from_sa => PWM_2_s1_readdata_from_sa,
      PWM_3_s1_readdata_from_sa => PWM_3_s1_readdata_from_sa,
      PWM_4_s1_readdata_from_sa => PWM_4_s1_readdata_from_sa,
      clk => internal_sys_clk,
      cpu_data_master_address => cpu_data_master_address,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_byteenable_NiosII_clock_1_in => cpu_data_master_byteenable_NiosII_clock_1_in,
      cpu_data_master_granted_NiosII_clock_1_in => cpu_data_master_granted_NiosII_clock_1_in,
      cpu_data_master_granted_NiosII_clock_2_in => cpu_data_master_granted_NiosII_clock_2_in,
      cpu_data_master_granted_PWM_1_s1 => cpu_data_master_granted_PWM_1_s1,
      cpu_data_master_granted_PWM_2_s1 => cpu_data_master_granted_PWM_2_s1,
      cpu_data_master_granted_PWM_3_s1 => cpu_data_master_granted_PWM_3_s1,
      cpu_data_master_granted_PWM_4_s1 => cpu_data_master_granted_PWM_4_s1,
      cpu_data_master_granted_cpu_jtag_debug_module => cpu_data_master_granted_cpu_jtag_debug_module,
      cpu_data_master_granted_data_tx_s1 => cpu_data_master_granted_data_tx_s1,
      cpu_data_master_granted_duty_1_s1 => cpu_data_master_granted_duty_1_s1,
      cpu_data_master_granted_duty_2_s1 => cpu_data_master_granted_duty_2_s1,
      cpu_data_master_granted_duty_3_s1 => cpu_data_master_granted_duty_3_s1,
      cpu_data_master_granted_duty_4_s1 => cpu_data_master_granted_duty_4_s1,
      cpu_data_master_granted_entrada_ac_eje_X_s1 => cpu_data_master_granted_entrada_ac_eje_X_s1,
      cpu_data_master_granted_entrada_ac_eje_Y_s1 => cpu_data_master_granted_entrada_ac_eje_Y_s1,
      cpu_data_master_granted_entrada_ac_eje_Z_s1 => cpu_data_master_granted_entrada_ac_eje_Z_s1,
      cpu_data_master_granted_entrada_gy_eje_X_s1 => cpu_data_master_granted_entrada_gy_eje_X_s1,
      cpu_data_master_granted_entrada_gy_eje_Y_s1 => cpu_data_master_granted_entrada_gy_eje_Y_s1,
      cpu_data_master_granted_entrada_gy_eje_Z_s1 => cpu_data_master_granted_entrada_gy_eje_Z_s1,
      cpu_data_master_granted_entrada_ma_eje_X_s1 => cpu_data_master_granted_entrada_ma_eje_X_s1,
      cpu_data_master_granted_entrada_ma_eje_Y_s1 => cpu_data_master_granted_entrada_ma_eje_Y_s1,
      cpu_data_master_granted_entrada_ma_eje_Z_s1 => cpu_data_master_granted_entrada_ma_eje_Z_s1,
      cpu_data_master_granted_entrada_temp_s1 => cpu_data_master_granted_entrada_temp_s1,
      cpu_data_master_granted_epcs_flash_controller_epcs_control_port => cpu_data_master_granted_epcs_flash_controller_epcs_control_port,
      cpu_data_master_granted_jtag_uart_avalon_jtag_slave => cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
      cpu_data_master_granted_out_test_s1 => cpu_data_master_granted_out_test_s1,
      cpu_data_master_granted_sample_time_s1 => cpu_data_master_granted_sample_time_s1,
      cpu_data_master_granted_sysid_control_slave => cpu_data_master_granted_sysid_control_slave,
      cpu_data_master_granted_timer_ONOF_s1 => cpu_data_master_granted_timer_ONOF_s1,
      cpu_data_master_granted_uart_gps_s1 => cpu_data_master_granted_uart_gps_s1,
      cpu_data_master_granted_uart_xbee_s1 => cpu_data_master_granted_uart_xbee_s1,
      cpu_data_master_qualified_request_NiosII_clock_1_in => cpu_data_master_qualified_request_NiosII_clock_1_in,
      cpu_data_master_qualified_request_NiosII_clock_2_in => cpu_data_master_qualified_request_NiosII_clock_2_in,
      cpu_data_master_qualified_request_PWM_1_s1 => cpu_data_master_qualified_request_PWM_1_s1,
      cpu_data_master_qualified_request_PWM_2_s1 => cpu_data_master_qualified_request_PWM_2_s1,
      cpu_data_master_qualified_request_PWM_3_s1 => cpu_data_master_qualified_request_PWM_3_s1,
      cpu_data_master_qualified_request_PWM_4_s1 => cpu_data_master_qualified_request_PWM_4_s1,
      cpu_data_master_qualified_request_cpu_jtag_debug_module => cpu_data_master_qualified_request_cpu_jtag_debug_module,
      cpu_data_master_qualified_request_data_tx_s1 => cpu_data_master_qualified_request_data_tx_s1,
      cpu_data_master_qualified_request_duty_1_s1 => cpu_data_master_qualified_request_duty_1_s1,
      cpu_data_master_qualified_request_duty_2_s1 => cpu_data_master_qualified_request_duty_2_s1,
      cpu_data_master_qualified_request_duty_3_s1 => cpu_data_master_qualified_request_duty_3_s1,
      cpu_data_master_qualified_request_duty_4_s1 => cpu_data_master_qualified_request_duty_4_s1,
      cpu_data_master_qualified_request_entrada_ac_eje_X_s1 => cpu_data_master_qualified_request_entrada_ac_eje_X_s1,
      cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 => cpu_data_master_qualified_request_entrada_ac_eje_Y_s1,
      cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 => cpu_data_master_qualified_request_entrada_ac_eje_Z_s1,
      cpu_data_master_qualified_request_entrada_gy_eje_X_s1 => cpu_data_master_qualified_request_entrada_gy_eje_X_s1,
      cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 => cpu_data_master_qualified_request_entrada_gy_eje_Y_s1,
      cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 => cpu_data_master_qualified_request_entrada_gy_eje_Z_s1,
      cpu_data_master_qualified_request_entrada_ma_eje_X_s1 => cpu_data_master_qualified_request_entrada_ma_eje_X_s1,
      cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 => cpu_data_master_qualified_request_entrada_ma_eje_Y_s1,
      cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 => cpu_data_master_qualified_request_entrada_ma_eje_Z_s1,
      cpu_data_master_qualified_request_entrada_temp_s1 => cpu_data_master_qualified_request_entrada_temp_s1,
      cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port => cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port,
      cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave => cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
      cpu_data_master_qualified_request_out_test_s1 => cpu_data_master_qualified_request_out_test_s1,
      cpu_data_master_qualified_request_sample_time_s1 => cpu_data_master_qualified_request_sample_time_s1,
      cpu_data_master_qualified_request_sysid_control_slave => cpu_data_master_qualified_request_sysid_control_slave,
      cpu_data_master_qualified_request_timer_ONOF_s1 => cpu_data_master_qualified_request_timer_ONOF_s1,
      cpu_data_master_qualified_request_uart_gps_s1 => cpu_data_master_qualified_request_uart_gps_s1,
      cpu_data_master_qualified_request_uart_xbee_s1 => cpu_data_master_qualified_request_uart_xbee_s1,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_read_data_valid_NiosII_clock_1_in => cpu_data_master_read_data_valid_NiosII_clock_1_in,
      cpu_data_master_read_data_valid_NiosII_clock_2_in => cpu_data_master_read_data_valid_NiosII_clock_2_in,
      cpu_data_master_read_data_valid_PWM_1_s1 => cpu_data_master_read_data_valid_PWM_1_s1,
      cpu_data_master_read_data_valid_PWM_2_s1 => cpu_data_master_read_data_valid_PWM_2_s1,
      cpu_data_master_read_data_valid_PWM_3_s1 => cpu_data_master_read_data_valid_PWM_3_s1,
      cpu_data_master_read_data_valid_PWM_4_s1 => cpu_data_master_read_data_valid_PWM_4_s1,
      cpu_data_master_read_data_valid_cpu_jtag_debug_module => cpu_data_master_read_data_valid_cpu_jtag_debug_module,
      cpu_data_master_read_data_valid_data_tx_s1 => cpu_data_master_read_data_valid_data_tx_s1,
      cpu_data_master_read_data_valid_duty_1_s1 => cpu_data_master_read_data_valid_duty_1_s1,
      cpu_data_master_read_data_valid_duty_2_s1 => cpu_data_master_read_data_valid_duty_2_s1,
      cpu_data_master_read_data_valid_duty_3_s1 => cpu_data_master_read_data_valid_duty_3_s1,
      cpu_data_master_read_data_valid_duty_4_s1 => cpu_data_master_read_data_valid_duty_4_s1,
      cpu_data_master_read_data_valid_entrada_ac_eje_X_s1 => cpu_data_master_read_data_valid_entrada_ac_eje_X_s1,
      cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1 => cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1,
      cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1 => cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1,
      cpu_data_master_read_data_valid_entrada_gy_eje_X_s1 => cpu_data_master_read_data_valid_entrada_gy_eje_X_s1,
      cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1 => cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1,
      cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1 => cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1,
      cpu_data_master_read_data_valid_entrada_ma_eje_X_s1 => cpu_data_master_read_data_valid_entrada_ma_eje_X_s1,
      cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1 => cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1,
      cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1 => cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1,
      cpu_data_master_read_data_valid_entrada_temp_s1 => cpu_data_master_read_data_valid_entrada_temp_s1,
      cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port => cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port,
      cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave => cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
      cpu_data_master_read_data_valid_out_test_s1 => cpu_data_master_read_data_valid_out_test_s1,
      cpu_data_master_read_data_valid_sample_time_s1 => cpu_data_master_read_data_valid_sample_time_s1,
      cpu_data_master_read_data_valid_sysid_control_slave => cpu_data_master_read_data_valid_sysid_control_slave,
      cpu_data_master_read_data_valid_timer_ONOF_s1 => cpu_data_master_read_data_valid_timer_ONOF_s1,
      cpu_data_master_read_data_valid_uart_gps_s1 => cpu_data_master_read_data_valid_uart_gps_s1,
      cpu_data_master_read_data_valid_uart_xbee_s1 => cpu_data_master_read_data_valid_uart_xbee_s1,
      cpu_data_master_requests_NiosII_clock_1_in => cpu_data_master_requests_NiosII_clock_1_in,
      cpu_data_master_requests_NiosII_clock_2_in => cpu_data_master_requests_NiosII_clock_2_in,
      cpu_data_master_requests_PWM_1_s1 => cpu_data_master_requests_PWM_1_s1,
      cpu_data_master_requests_PWM_2_s1 => cpu_data_master_requests_PWM_2_s1,
      cpu_data_master_requests_PWM_3_s1 => cpu_data_master_requests_PWM_3_s1,
      cpu_data_master_requests_PWM_4_s1 => cpu_data_master_requests_PWM_4_s1,
      cpu_data_master_requests_cpu_jtag_debug_module => cpu_data_master_requests_cpu_jtag_debug_module,
      cpu_data_master_requests_data_tx_s1 => cpu_data_master_requests_data_tx_s1,
      cpu_data_master_requests_duty_1_s1 => cpu_data_master_requests_duty_1_s1,
      cpu_data_master_requests_duty_2_s1 => cpu_data_master_requests_duty_2_s1,
      cpu_data_master_requests_duty_3_s1 => cpu_data_master_requests_duty_3_s1,
      cpu_data_master_requests_duty_4_s1 => cpu_data_master_requests_duty_4_s1,
      cpu_data_master_requests_entrada_ac_eje_X_s1 => cpu_data_master_requests_entrada_ac_eje_X_s1,
      cpu_data_master_requests_entrada_ac_eje_Y_s1 => cpu_data_master_requests_entrada_ac_eje_Y_s1,
      cpu_data_master_requests_entrada_ac_eje_Z_s1 => cpu_data_master_requests_entrada_ac_eje_Z_s1,
      cpu_data_master_requests_entrada_gy_eje_X_s1 => cpu_data_master_requests_entrada_gy_eje_X_s1,
      cpu_data_master_requests_entrada_gy_eje_Y_s1 => cpu_data_master_requests_entrada_gy_eje_Y_s1,
      cpu_data_master_requests_entrada_gy_eje_Z_s1 => cpu_data_master_requests_entrada_gy_eje_Z_s1,
      cpu_data_master_requests_entrada_ma_eje_X_s1 => cpu_data_master_requests_entrada_ma_eje_X_s1,
      cpu_data_master_requests_entrada_ma_eje_Y_s1 => cpu_data_master_requests_entrada_ma_eje_Y_s1,
      cpu_data_master_requests_entrada_ma_eje_Z_s1 => cpu_data_master_requests_entrada_ma_eje_Z_s1,
      cpu_data_master_requests_entrada_temp_s1 => cpu_data_master_requests_entrada_temp_s1,
      cpu_data_master_requests_epcs_flash_controller_epcs_control_port => cpu_data_master_requests_epcs_flash_controller_epcs_control_port,
      cpu_data_master_requests_jtag_uart_avalon_jtag_slave => cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
      cpu_data_master_requests_out_test_s1 => cpu_data_master_requests_out_test_s1,
      cpu_data_master_requests_sample_time_s1 => cpu_data_master_requests_sample_time_s1,
      cpu_data_master_requests_sysid_control_slave => cpu_data_master_requests_sysid_control_slave,
      cpu_data_master_requests_timer_ONOF_s1 => cpu_data_master_requests_timer_ONOF_s1,
      cpu_data_master_requests_uart_gps_s1 => cpu_data_master_requests_uart_gps_s1,
      cpu_data_master_requests_uart_xbee_s1 => cpu_data_master_requests_uart_xbee_s1,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      d1_NiosII_clock_1_in_end_xfer => d1_NiosII_clock_1_in_end_xfer,
      d1_NiosII_clock_2_in_end_xfer => d1_NiosII_clock_2_in_end_xfer,
      d1_PWM_1_s1_end_xfer => d1_PWM_1_s1_end_xfer,
      d1_PWM_2_s1_end_xfer => d1_PWM_2_s1_end_xfer,
      d1_PWM_3_s1_end_xfer => d1_PWM_3_s1_end_xfer,
      d1_PWM_4_s1_end_xfer => d1_PWM_4_s1_end_xfer,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      d1_data_tx_s1_end_xfer => d1_data_tx_s1_end_xfer,
      d1_duty_1_s1_end_xfer => d1_duty_1_s1_end_xfer,
      d1_duty_2_s1_end_xfer => d1_duty_2_s1_end_xfer,
      d1_duty_3_s1_end_xfer => d1_duty_3_s1_end_xfer,
      d1_duty_4_s1_end_xfer => d1_duty_4_s1_end_xfer,
      d1_entrada_ac_eje_X_s1_end_xfer => d1_entrada_ac_eje_X_s1_end_xfer,
      d1_entrada_ac_eje_Y_s1_end_xfer => d1_entrada_ac_eje_Y_s1_end_xfer,
      d1_entrada_ac_eje_Z_s1_end_xfer => d1_entrada_ac_eje_Z_s1_end_xfer,
      d1_entrada_gy_eje_X_s1_end_xfer => d1_entrada_gy_eje_X_s1_end_xfer,
      d1_entrada_gy_eje_Y_s1_end_xfer => d1_entrada_gy_eje_Y_s1_end_xfer,
      d1_entrada_gy_eje_Z_s1_end_xfer => d1_entrada_gy_eje_Z_s1_end_xfer,
      d1_entrada_ma_eje_X_s1_end_xfer => d1_entrada_ma_eje_X_s1_end_xfer,
      d1_entrada_ma_eje_Y_s1_end_xfer => d1_entrada_ma_eje_Y_s1_end_xfer,
      d1_entrada_ma_eje_Z_s1_end_xfer => d1_entrada_ma_eje_Z_s1_end_xfer,
      d1_entrada_temp_s1_end_xfer => d1_entrada_temp_s1_end_xfer,
      d1_epcs_flash_controller_epcs_control_port_end_xfer => d1_epcs_flash_controller_epcs_control_port_end_xfer,
      d1_jtag_uart_avalon_jtag_slave_end_xfer => d1_jtag_uart_avalon_jtag_slave_end_xfer,
      d1_out_test_s1_end_xfer => d1_out_test_s1_end_xfer,
      d1_sample_time_s1_end_xfer => d1_sample_time_s1_end_xfer,
      d1_sysid_control_slave_end_xfer => d1_sysid_control_slave_end_xfer,
      d1_timer_ONOF_s1_end_xfer => d1_timer_ONOF_s1_end_xfer,
      d1_uart_gps_s1_end_xfer => d1_uart_gps_s1_end_xfer,
      d1_uart_xbee_s1_end_xfer => d1_uart_xbee_s1_end_xfer,
      data_tx_s1_readdata_from_sa => data_tx_s1_readdata_from_sa,
      duty_1_s1_readdata_from_sa => duty_1_s1_readdata_from_sa,
      duty_2_s1_readdata_from_sa => duty_2_s1_readdata_from_sa,
      duty_3_s1_readdata_from_sa => duty_3_s1_readdata_from_sa,
      duty_4_s1_readdata_from_sa => duty_4_s1_readdata_from_sa,
      entrada_ac_eje_X_s1_readdata_from_sa => entrada_ac_eje_X_s1_readdata_from_sa,
      entrada_ac_eje_Y_s1_readdata_from_sa => entrada_ac_eje_Y_s1_readdata_from_sa,
      entrada_ac_eje_Z_s1_readdata_from_sa => entrada_ac_eje_Z_s1_readdata_from_sa,
      entrada_gy_eje_X_s1_readdata_from_sa => entrada_gy_eje_X_s1_readdata_from_sa,
      entrada_gy_eje_Y_s1_readdata_from_sa => entrada_gy_eje_Y_s1_readdata_from_sa,
      entrada_gy_eje_Z_s1_readdata_from_sa => entrada_gy_eje_Z_s1_readdata_from_sa,
      entrada_ma_eje_X_s1_readdata_from_sa => entrada_ma_eje_X_s1_readdata_from_sa,
      entrada_ma_eje_Y_s1_readdata_from_sa => entrada_ma_eje_Y_s1_readdata_from_sa,
      entrada_ma_eje_Z_s1_readdata_from_sa => entrada_ma_eje_Z_s1_readdata_from_sa,
      entrada_temp_s1_readdata_from_sa => entrada_temp_s1_readdata_from_sa,
      epcs_flash_controller_epcs_control_port_irq_from_sa => epcs_flash_controller_epcs_control_port_irq_from_sa,
      epcs_flash_controller_epcs_control_port_readdata_from_sa => epcs_flash_controller_epcs_control_port_readdata_from_sa,
      jtag_uart_avalon_jtag_slave_irq_from_sa => jtag_uart_avalon_jtag_slave_irq_from_sa,
      jtag_uart_avalon_jtag_slave_readdata_from_sa => jtag_uart_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
      out_test_s1_readdata_from_sa => out_test_s1_readdata_from_sa,
      reset_n => sys_clk_reset_n,
      sample_time_s1_irq_from_sa => sample_time_s1_irq_from_sa,
      sample_time_s1_readdata_from_sa => sample_time_s1_readdata_from_sa,
      sysid_control_slave_readdata_from_sa => sysid_control_slave_readdata_from_sa,
      timer_ONOF_s1_irq_from_sa => timer_ONOF_s1_irq_from_sa,
      timer_ONOF_s1_readdata_from_sa => timer_ONOF_s1_readdata_from_sa,
      uart_gps_s1_irq_from_sa => uart_gps_s1_irq_from_sa,
      uart_gps_s1_readdata_from_sa => uart_gps_s1_readdata_from_sa,
      uart_xbee_s1_irq_from_sa => uart_xbee_s1_irq_from_sa,
      uart_xbee_s1_readdata_from_sa => uart_xbee_s1_readdata_from_sa
    );


  --the_cpu_instruction_master, which is an e_instance
  the_cpu_instruction_master : cpu_instruction_master_arbitrator
    port map(
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_dbs_address => cpu_instruction_master_dbs_address,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_readdata => cpu_instruction_master_readdata,
      cpu_instruction_master_readdatavalid => cpu_instruction_master_readdatavalid,
      cpu_instruction_master_waitrequest => cpu_instruction_master_waitrequest,
      NiosII_clock_0_in_readdata_from_sa => NiosII_clock_0_in_readdata_from_sa,
      NiosII_clock_0_in_waitrequest_from_sa => NiosII_clock_0_in_waitrequest_from_sa,
      clk => internal_sys_clk,
      cpu_instruction_master_address => cpu_instruction_master_address,
      cpu_instruction_master_granted_NiosII_clock_0_in => cpu_instruction_master_granted_NiosII_clock_0_in,
      cpu_instruction_master_granted_cpu_jtag_debug_module => cpu_instruction_master_granted_cpu_jtag_debug_module,
      cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port => cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_qualified_request_NiosII_clock_0_in => cpu_instruction_master_qualified_request_NiosII_clock_0_in,
      cpu_instruction_master_qualified_request_cpu_jtag_debug_module => cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
      cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port => cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_instruction_master_read_data_valid_NiosII_clock_0_in => cpu_instruction_master_read_data_valid_NiosII_clock_0_in,
      cpu_instruction_master_read_data_valid_cpu_jtag_debug_module => cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
      cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port => cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_requests_NiosII_clock_0_in => cpu_instruction_master_requests_NiosII_clock_0_in,
      cpu_instruction_master_requests_cpu_jtag_debug_module => cpu_instruction_master_requests_cpu_jtag_debug_module,
      cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port => cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      d1_NiosII_clock_0_in_end_xfer => d1_NiosII_clock_0_in_end_xfer,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      d1_epcs_flash_controller_epcs_control_port_end_xfer => d1_epcs_flash_controller_epcs_control_port_end_xfer,
      epcs_flash_controller_epcs_control_port_readdata_from_sa => epcs_flash_controller_epcs_control_port_readdata_from_sa,
      reset_n => sys_clk_reset_n
    );


  --the_cpu, which is an e_ptf_instance
  the_cpu : cpu
    port map(
      A_ci_multi_a => cpu_custom_instruction_master_multi_a,
      A_ci_multi_b => cpu_custom_instruction_master_multi_b,
      A_ci_multi_c => cpu_custom_instruction_master_multi_c,
      A_ci_multi_clk_en => cpu_custom_instruction_master_multi_clk_en,
      A_ci_multi_clock => cpu_custom_instruction_master_multi_clk,
      A_ci_multi_dataa => cpu_custom_instruction_master_multi_dataa,
      A_ci_multi_datab => cpu_custom_instruction_master_multi_datab,
      A_ci_multi_estatus => cpu_custom_instruction_master_multi_estatus,
      A_ci_multi_ipending => cpu_custom_instruction_master_multi_ipending,
      A_ci_multi_n => cpu_custom_instruction_master_multi_n,
      A_ci_multi_readra => cpu_custom_instruction_master_multi_readra,
      A_ci_multi_readrb => cpu_custom_instruction_master_multi_readrb,
      A_ci_multi_reset => cpu_custom_instruction_master_multi_reset,
      A_ci_multi_start => cpu_custom_instruction_master_multi_start,
      A_ci_multi_status => cpu_custom_instruction_master_multi_status,
      A_ci_multi_writerc => cpu_custom_instruction_master_multi_writerc,
      d_address => cpu_data_master_address,
      d_byteenable => cpu_data_master_byteenable,
      d_read => cpu_data_master_read,
      d_write => cpu_data_master_write,
      d_writedata => cpu_data_master_writedata,
      i_address => cpu_instruction_master_address,
      i_read => cpu_instruction_master_read,
      jtag_debug_module_debugaccess_to_roms => cpu_data_master_debugaccess,
      jtag_debug_module_readdata => cpu_jtag_debug_module_readdata,
      jtag_debug_module_resetrequest => cpu_jtag_debug_module_resetrequest,
      A_ci_multi_done => cpu_custom_instruction_master_multi_done,
      A_ci_multi_result => cpu_custom_instruction_master_multi_result,
      clk => internal_sys_clk,
      d_irq => cpu_data_master_irq,
      d_readdata => cpu_data_master_readdata,
      d_readdatavalid => cpu_data_master_readdatavalid,
      d_waitrequest => cpu_data_master_waitrequest,
      i_readdata => cpu_instruction_master_readdata,
      i_readdatavalid => cpu_instruction_master_readdatavalid,
      i_waitrequest => cpu_instruction_master_waitrequest,
      jtag_debug_module_address => cpu_jtag_debug_module_address,
      jtag_debug_module_begintransfer => cpu_jtag_debug_module_begintransfer,
      jtag_debug_module_byteenable => cpu_jtag_debug_module_byteenable,
      jtag_debug_module_debugaccess => cpu_jtag_debug_module_debugaccess,
      jtag_debug_module_select => cpu_jtag_debug_module_chipselect,
      jtag_debug_module_write => cpu_jtag_debug_module_write,
      jtag_debug_module_writedata => cpu_jtag_debug_module_writedata,
      reset_n => cpu_custom_instruction_master_reset_n
    );


  --the_cpu_altera_nios_custom_instr_floating_point_inst_s1, which is an e_instance
  the_cpu_altera_nios_custom_instr_floating_point_inst_s1 : cpu_altera_nios_custom_instr_floating_point_inst_s1_arbitrator
    port map(
      cpu_altera_nios_custom_instr_floating_point_inst_s1_clk_en => cpu_altera_nios_custom_instr_floating_point_inst_s1_clk_en,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_dataa => cpu_altera_nios_custom_instr_floating_point_inst_s1_dataa,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_datab => cpu_altera_nios_custom_instr_floating_point_inst_s1_datab,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa => cpu_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_n => cpu_altera_nios_custom_instr_floating_point_inst_s1_n,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_reset => cpu_altera_nios_custom_instr_floating_point_inst_s1_reset,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa => cpu_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_start => cpu_altera_nios_custom_instr_floating_point_inst_s1_start,
      clk => internal_sys_clk,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_done => cpu_altera_nios_custom_instr_floating_point_inst_s1_done,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_result => cpu_altera_nios_custom_instr_floating_point_inst_s1_result,
      cpu_altera_nios_custom_instr_floating_point_inst_s1_select => cpu_altera_nios_custom_instr_floating_point_inst_s1_select,
      cpu_custom_instruction_master_multi_clk_en => cpu_custom_instruction_master_multi_clk_en,
      cpu_custom_instruction_master_multi_dataa => cpu_custom_instruction_master_multi_dataa,
      cpu_custom_instruction_master_multi_datab => cpu_custom_instruction_master_multi_datab,
      cpu_custom_instruction_master_multi_n => cpu_custom_instruction_master_multi_n,
      cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1 => cpu_custom_instruction_master_start_cpu_altera_nios_custom_instr_floating_point_inst_s1,
      reset_n => sys_clk_reset_n
    );


  --the_cpu_altera_nios_custom_instr_floating_point_inst, which is an e_ptf_instance
  the_cpu_altera_nios_custom_instr_floating_point_inst : cpu_altera_nios_custom_instr_floating_point_inst
    port map(
      done => cpu_altera_nios_custom_instr_floating_point_inst_s1_done,
      result => cpu_altera_nios_custom_instr_floating_point_inst_s1_result,
      clk => internal_sys_clk,
      clk_en => cpu_altera_nios_custom_instr_floating_point_inst_s1_clk_en,
      dataa => cpu_altera_nios_custom_instr_floating_point_inst_s1_dataa,
      datab => cpu_altera_nios_custom_instr_floating_point_inst_s1_datab,
      n => cpu_altera_nios_custom_instr_floating_point_inst_s1_n,
      reset => cpu_altera_nios_custom_instr_floating_point_inst_s1_reset,
      start => cpu_altera_nios_custom_instr_floating_point_inst_s1_start
    );


  --the_data_tx_s1, which is an e_instance
  the_data_tx_s1 : data_tx_s1_arbitrator
    port map(
      cpu_data_master_granted_data_tx_s1 => cpu_data_master_granted_data_tx_s1,
      cpu_data_master_qualified_request_data_tx_s1 => cpu_data_master_qualified_request_data_tx_s1,
      cpu_data_master_read_data_valid_data_tx_s1 => cpu_data_master_read_data_valid_data_tx_s1,
      cpu_data_master_requests_data_tx_s1 => cpu_data_master_requests_data_tx_s1,
      d1_data_tx_s1_end_xfer => d1_data_tx_s1_end_xfer,
      data_tx_s1_address => data_tx_s1_address,
      data_tx_s1_chipselect => data_tx_s1_chipselect,
      data_tx_s1_readdata_from_sa => data_tx_s1_readdata_from_sa,
      data_tx_s1_reset_n => data_tx_s1_reset_n,
      data_tx_s1_write_n => data_tx_s1_write_n,
      data_tx_s1_writedata => data_tx_s1_writedata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      data_tx_s1_readdata => data_tx_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_data_tx, which is an e_ptf_instance
  the_data_tx : data_tx
    port map(
      out_port => internal_out_port_from_the_data_tx,
      readdata => data_tx_s1_readdata,
      address => data_tx_s1_address,
      chipselect => data_tx_s1_chipselect,
      clk => internal_sys_clk,
      reset_n => data_tx_s1_reset_n,
      write_n => data_tx_s1_write_n,
      writedata => data_tx_s1_writedata
    );


  --the_duty_1_s1, which is an e_instance
  the_duty_1_s1 : duty_1_s1_arbitrator
    port map(
      cpu_data_master_granted_duty_1_s1 => cpu_data_master_granted_duty_1_s1,
      cpu_data_master_qualified_request_duty_1_s1 => cpu_data_master_qualified_request_duty_1_s1,
      cpu_data_master_read_data_valid_duty_1_s1 => cpu_data_master_read_data_valid_duty_1_s1,
      cpu_data_master_requests_duty_1_s1 => cpu_data_master_requests_duty_1_s1,
      d1_duty_1_s1_end_xfer => d1_duty_1_s1_end_xfer,
      duty_1_s1_address => duty_1_s1_address,
      duty_1_s1_readdata_from_sa => duty_1_s1_readdata_from_sa,
      duty_1_s1_reset_n => duty_1_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      duty_1_s1_readdata => duty_1_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_duty_1, which is an e_ptf_instance
  the_duty_1 : duty_1
    port map(
      readdata => duty_1_s1_readdata,
      address => duty_1_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_duty_1,
      reset_n => duty_1_s1_reset_n
    );


  --the_duty_2_s1, which is an e_instance
  the_duty_2_s1 : duty_2_s1_arbitrator
    port map(
      cpu_data_master_granted_duty_2_s1 => cpu_data_master_granted_duty_2_s1,
      cpu_data_master_qualified_request_duty_2_s1 => cpu_data_master_qualified_request_duty_2_s1,
      cpu_data_master_read_data_valid_duty_2_s1 => cpu_data_master_read_data_valid_duty_2_s1,
      cpu_data_master_requests_duty_2_s1 => cpu_data_master_requests_duty_2_s1,
      d1_duty_2_s1_end_xfer => d1_duty_2_s1_end_xfer,
      duty_2_s1_address => duty_2_s1_address,
      duty_2_s1_readdata_from_sa => duty_2_s1_readdata_from_sa,
      duty_2_s1_reset_n => duty_2_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      duty_2_s1_readdata => duty_2_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_duty_2, which is an e_ptf_instance
  the_duty_2 : duty_2
    port map(
      readdata => duty_2_s1_readdata,
      address => duty_2_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_duty_2,
      reset_n => duty_2_s1_reset_n
    );


  --the_duty_3_s1, which is an e_instance
  the_duty_3_s1 : duty_3_s1_arbitrator
    port map(
      cpu_data_master_granted_duty_3_s1 => cpu_data_master_granted_duty_3_s1,
      cpu_data_master_qualified_request_duty_3_s1 => cpu_data_master_qualified_request_duty_3_s1,
      cpu_data_master_read_data_valid_duty_3_s1 => cpu_data_master_read_data_valid_duty_3_s1,
      cpu_data_master_requests_duty_3_s1 => cpu_data_master_requests_duty_3_s1,
      d1_duty_3_s1_end_xfer => d1_duty_3_s1_end_xfer,
      duty_3_s1_address => duty_3_s1_address,
      duty_3_s1_readdata_from_sa => duty_3_s1_readdata_from_sa,
      duty_3_s1_reset_n => duty_3_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      duty_3_s1_readdata => duty_3_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_duty_3, which is an e_ptf_instance
  the_duty_3 : duty_3
    port map(
      readdata => duty_3_s1_readdata,
      address => duty_3_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_duty_3,
      reset_n => duty_3_s1_reset_n
    );


  --the_duty_4_s1, which is an e_instance
  the_duty_4_s1 : duty_4_s1_arbitrator
    port map(
      cpu_data_master_granted_duty_4_s1 => cpu_data_master_granted_duty_4_s1,
      cpu_data_master_qualified_request_duty_4_s1 => cpu_data_master_qualified_request_duty_4_s1,
      cpu_data_master_read_data_valid_duty_4_s1 => cpu_data_master_read_data_valid_duty_4_s1,
      cpu_data_master_requests_duty_4_s1 => cpu_data_master_requests_duty_4_s1,
      d1_duty_4_s1_end_xfer => d1_duty_4_s1_end_xfer,
      duty_4_s1_address => duty_4_s1_address,
      duty_4_s1_readdata_from_sa => duty_4_s1_readdata_from_sa,
      duty_4_s1_reset_n => duty_4_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      duty_4_s1_readdata => duty_4_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_duty_4, which is an e_ptf_instance
  the_duty_4 : duty_4
    port map(
      readdata => duty_4_s1_readdata,
      address => duty_4_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_duty_4,
      reset_n => duty_4_s1_reset_n
    );


  --the_entrada_ac_eje_X_s1, which is an e_instance
  the_entrada_ac_eje_X_s1 : entrada_ac_eje_X_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_ac_eje_X_s1 => cpu_data_master_granted_entrada_ac_eje_X_s1,
      cpu_data_master_qualified_request_entrada_ac_eje_X_s1 => cpu_data_master_qualified_request_entrada_ac_eje_X_s1,
      cpu_data_master_read_data_valid_entrada_ac_eje_X_s1 => cpu_data_master_read_data_valid_entrada_ac_eje_X_s1,
      cpu_data_master_requests_entrada_ac_eje_X_s1 => cpu_data_master_requests_entrada_ac_eje_X_s1,
      d1_entrada_ac_eje_X_s1_end_xfer => d1_entrada_ac_eje_X_s1_end_xfer,
      entrada_ac_eje_X_s1_address => entrada_ac_eje_X_s1_address,
      entrada_ac_eje_X_s1_readdata_from_sa => entrada_ac_eje_X_s1_readdata_from_sa,
      entrada_ac_eje_X_s1_reset_n => entrada_ac_eje_X_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_ac_eje_X_s1_readdata => entrada_ac_eje_X_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_ac_eje_X, which is an e_ptf_instance
  the_entrada_ac_eje_X : entrada_ac_eje_X
    port map(
      readdata => entrada_ac_eje_X_s1_readdata,
      address => entrada_ac_eje_X_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_ac_eje_X,
      reset_n => entrada_ac_eje_X_s1_reset_n
    );


  --the_entrada_ac_eje_Y_s1, which is an e_instance
  the_entrada_ac_eje_Y_s1 : entrada_ac_eje_Y_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_ac_eje_Y_s1 => cpu_data_master_granted_entrada_ac_eje_Y_s1,
      cpu_data_master_qualified_request_entrada_ac_eje_Y_s1 => cpu_data_master_qualified_request_entrada_ac_eje_Y_s1,
      cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1 => cpu_data_master_read_data_valid_entrada_ac_eje_Y_s1,
      cpu_data_master_requests_entrada_ac_eje_Y_s1 => cpu_data_master_requests_entrada_ac_eje_Y_s1,
      d1_entrada_ac_eje_Y_s1_end_xfer => d1_entrada_ac_eje_Y_s1_end_xfer,
      entrada_ac_eje_Y_s1_address => entrada_ac_eje_Y_s1_address,
      entrada_ac_eje_Y_s1_readdata_from_sa => entrada_ac_eje_Y_s1_readdata_from_sa,
      entrada_ac_eje_Y_s1_reset_n => entrada_ac_eje_Y_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_ac_eje_Y_s1_readdata => entrada_ac_eje_Y_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_ac_eje_Y, which is an e_ptf_instance
  the_entrada_ac_eje_Y : entrada_ac_eje_Y
    port map(
      readdata => entrada_ac_eje_Y_s1_readdata,
      address => entrada_ac_eje_Y_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_ac_eje_Y,
      reset_n => entrada_ac_eje_Y_s1_reset_n
    );


  --the_entrada_ac_eje_Z_s1, which is an e_instance
  the_entrada_ac_eje_Z_s1 : entrada_ac_eje_Z_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_ac_eje_Z_s1 => cpu_data_master_granted_entrada_ac_eje_Z_s1,
      cpu_data_master_qualified_request_entrada_ac_eje_Z_s1 => cpu_data_master_qualified_request_entrada_ac_eje_Z_s1,
      cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1 => cpu_data_master_read_data_valid_entrada_ac_eje_Z_s1,
      cpu_data_master_requests_entrada_ac_eje_Z_s1 => cpu_data_master_requests_entrada_ac_eje_Z_s1,
      d1_entrada_ac_eje_Z_s1_end_xfer => d1_entrada_ac_eje_Z_s1_end_xfer,
      entrada_ac_eje_Z_s1_address => entrada_ac_eje_Z_s1_address,
      entrada_ac_eje_Z_s1_readdata_from_sa => entrada_ac_eje_Z_s1_readdata_from_sa,
      entrada_ac_eje_Z_s1_reset_n => entrada_ac_eje_Z_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_ac_eje_Z_s1_readdata => entrada_ac_eje_Z_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_ac_eje_Z, which is an e_ptf_instance
  the_entrada_ac_eje_Z : entrada_ac_eje_Z
    port map(
      readdata => entrada_ac_eje_Z_s1_readdata,
      address => entrada_ac_eje_Z_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_ac_eje_Z,
      reset_n => entrada_ac_eje_Z_s1_reset_n
    );


  --the_entrada_gy_eje_X_s1, which is an e_instance
  the_entrada_gy_eje_X_s1 : entrada_gy_eje_X_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_gy_eje_X_s1 => cpu_data_master_granted_entrada_gy_eje_X_s1,
      cpu_data_master_qualified_request_entrada_gy_eje_X_s1 => cpu_data_master_qualified_request_entrada_gy_eje_X_s1,
      cpu_data_master_read_data_valid_entrada_gy_eje_X_s1 => cpu_data_master_read_data_valid_entrada_gy_eje_X_s1,
      cpu_data_master_requests_entrada_gy_eje_X_s1 => cpu_data_master_requests_entrada_gy_eje_X_s1,
      d1_entrada_gy_eje_X_s1_end_xfer => d1_entrada_gy_eje_X_s1_end_xfer,
      entrada_gy_eje_X_s1_address => entrada_gy_eje_X_s1_address,
      entrada_gy_eje_X_s1_readdata_from_sa => entrada_gy_eje_X_s1_readdata_from_sa,
      entrada_gy_eje_X_s1_reset_n => entrada_gy_eje_X_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_gy_eje_X_s1_readdata => entrada_gy_eje_X_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_gy_eje_X, which is an e_ptf_instance
  the_entrada_gy_eje_X : entrada_gy_eje_X
    port map(
      readdata => entrada_gy_eje_X_s1_readdata,
      address => entrada_gy_eje_X_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_gy_eje_X,
      reset_n => entrada_gy_eje_X_s1_reset_n
    );


  --the_entrada_gy_eje_Y_s1, which is an e_instance
  the_entrada_gy_eje_Y_s1 : entrada_gy_eje_Y_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_gy_eje_Y_s1 => cpu_data_master_granted_entrada_gy_eje_Y_s1,
      cpu_data_master_qualified_request_entrada_gy_eje_Y_s1 => cpu_data_master_qualified_request_entrada_gy_eje_Y_s1,
      cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1 => cpu_data_master_read_data_valid_entrada_gy_eje_Y_s1,
      cpu_data_master_requests_entrada_gy_eje_Y_s1 => cpu_data_master_requests_entrada_gy_eje_Y_s1,
      d1_entrada_gy_eje_Y_s1_end_xfer => d1_entrada_gy_eje_Y_s1_end_xfer,
      entrada_gy_eje_Y_s1_address => entrada_gy_eje_Y_s1_address,
      entrada_gy_eje_Y_s1_readdata_from_sa => entrada_gy_eje_Y_s1_readdata_from_sa,
      entrada_gy_eje_Y_s1_reset_n => entrada_gy_eje_Y_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_gy_eje_Y_s1_readdata => entrada_gy_eje_Y_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_gy_eje_Y, which is an e_ptf_instance
  the_entrada_gy_eje_Y : entrada_gy_eje_Y
    port map(
      readdata => entrada_gy_eje_Y_s1_readdata,
      address => entrada_gy_eje_Y_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_gy_eje_Y,
      reset_n => entrada_gy_eje_Y_s1_reset_n
    );


  --the_entrada_gy_eje_Z_s1, which is an e_instance
  the_entrada_gy_eje_Z_s1 : entrada_gy_eje_Z_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_gy_eje_Z_s1 => cpu_data_master_granted_entrada_gy_eje_Z_s1,
      cpu_data_master_qualified_request_entrada_gy_eje_Z_s1 => cpu_data_master_qualified_request_entrada_gy_eje_Z_s1,
      cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1 => cpu_data_master_read_data_valid_entrada_gy_eje_Z_s1,
      cpu_data_master_requests_entrada_gy_eje_Z_s1 => cpu_data_master_requests_entrada_gy_eje_Z_s1,
      d1_entrada_gy_eje_Z_s1_end_xfer => d1_entrada_gy_eje_Z_s1_end_xfer,
      entrada_gy_eje_Z_s1_address => entrada_gy_eje_Z_s1_address,
      entrada_gy_eje_Z_s1_readdata_from_sa => entrada_gy_eje_Z_s1_readdata_from_sa,
      entrada_gy_eje_Z_s1_reset_n => entrada_gy_eje_Z_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_gy_eje_Z_s1_readdata => entrada_gy_eje_Z_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_gy_eje_Z, which is an e_ptf_instance
  the_entrada_gy_eje_Z : entrada_gy_eje_Z
    port map(
      readdata => entrada_gy_eje_Z_s1_readdata,
      address => entrada_gy_eje_Z_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_gy_eje_Z,
      reset_n => entrada_gy_eje_Z_s1_reset_n
    );


  --the_entrada_ma_eje_X_s1, which is an e_instance
  the_entrada_ma_eje_X_s1 : entrada_ma_eje_X_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_ma_eje_X_s1 => cpu_data_master_granted_entrada_ma_eje_X_s1,
      cpu_data_master_qualified_request_entrada_ma_eje_X_s1 => cpu_data_master_qualified_request_entrada_ma_eje_X_s1,
      cpu_data_master_read_data_valid_entrada_ma_eje_X_s1 => cpu_data_master_read_data_valid_entrada_ma_eje_X_s1,
      cpu_data_master_requests_entrada_ma_eje_X_s1 => cpu_data_master_requests_entrada_ma_eje_X_s1,
      d1_entrada_ma_eje_X_s1_end_xfer => d1_entrada_ma_eje_X_s1_end_xfer,
      entrada_ma_eje_X_s1_address => entrada_ma_eje_X_s1_address,
      entrada_ma_eje_X_s1_readdata_from_sa => entrada_ma_eje_X_s1_readdata_from_sa,
      entrada_ma_eje_X_s1_reset_n => entrada_ma_eje_X_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_ma_eje_X_s1_readdata => entrada_ma_eje_X_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_ma_eje_X, which is an e_ptf_instance
  the_entrada_ma_eje_X : entrada_ma_eje_X
    port map(
      readdata => entrada_ma_eje_X_s1_readdata,
      address => entrada_ma_eje_X_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_ma_eje_X,
      reset_n => entrada_ma_eje_X_s1_reset_n
    );


  --the_entrada_ma_eje_Y_s1, which is an e_instance
  the_entrada_ma_eje_Y_s1 : entrada_ma_eje_Y_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_ma_eje_Y_s1 => cpu_data_master_granted_entrada_ma_eje_Y_s1,
      cpu_data_master_qualified_request_entrada_ma_eje_Y_s1 => cpu_data_master_qualified_request_entrada_ma_eje_Y_s1,
      cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1 => cpu_data_master_read_data_valid_entrada_ma_eje_Y_s1,
      cpu_data_master_requests_entrada_ma_eje_Y_s1 => cpu_data_master_requests_entrada_ma_eje_Y_s1,
      d1_entrada_ma_eje_Y_s1_end_xfer => d1_entrada_ma_eje_Y_s1_end_xfer,
      entrada_ma_eje_Y_s1_address => entrada_ma_eje_Y_s1_address,
      entrada_ma_eje_Y_s1_readdata_from_sa => entrada_ma_eje_Y_s1_readdata_from_sa,
      entrada_ma_eje_Y_s1_reset_n => entrada_ma_eje_Y_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_ma_eje_Y_s1_readdata => entrada_ma_eje_Y_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_ma_eje_Y, which is an e_ptf_instance
  the_entrada_ma_eje_Y : entrada_ma_eje_Y
    port map(
      readdata => entrada_ma_eje_Y_s1_readdata,
      address => entrada_ma_eje_Y_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_ma_eje_Y,
      reset_n => entrada_ma_eje_Y_s1_reset_n
    );


  --the_entrada_ma_eje_Z_s1, which is an e_instance
  the_entrada_ma_eje_Z_s1 : entrada_ma_eje_Z_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_ma_eje_Z_s1 => cpu_data_master_granted_entrada_ma_eje_Z_s1,
      cpu_data_master_qualified_request_entrada_ma_eje_Z_s1 => cpu_data_master_qualified_request_entrada_ma_eje_Z_s1,
      cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1 => cpu_data_master_read_data_valid_entrada_ma_eje_Z_s1,
      cpu_data_master_requests_entrada_ma_eje_Z_s1 => cpu_data_master_requests_entrada_ma_eje_Z_s1,
      d1_entrada_ma_eje_Z_s1_end_xfer => d1_entrada_ma_eje_Z_s1_end_xfer,
      entrada_ma_eje_Z_s1_address => entrada_ma_eje_Z_s1_address,
      entrada_ma_eje_Z_s1_readdata_from_sa => entrada_ma_eje_Z_s1_readdata_from_sa,
      entrada_ma_eje_Z_s1_reset_n => entrada_ma_eje_Z_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_ma_eje_Z_s1_readdata => entrada_ma_eje_Z_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_ma_eje_Z, which is an e_ptf_instance
  the_entrada_ma_eje_Z : entrada_ma_eje_Z
    port map(
      readdata => entrada_ma_eje_Z_s1_readdata,
      address => entrada_ma_eje_Z_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_ma_eje_Z,
      reset_n => entrada_ma_eje_Z_s1_reset_n
    );


  --the_entrada_temp_s1, which is an e_instance
  the_entrada_temp_s1 : entrada_temp_s1_arbitrator
    port map(
      cpu_data_master_granted_entrada_temp_s1 => cpu_data_master_granted_entrada_temp_s1,
      cpu_data_master_qualified_request_entrada_temp_s1 => cpu_data_master_qualified_request_entrada_temp_s1,
      cpu_data_master_read_data_valid_entrada_temp_s1 => cpu_data_master_read_data_valid_entrada_temp_s1,
      cpu_data_master_requests_entrada_temp_s1 => cpu_data_master_requests_entrada_temp_s1,
      d1_entrada_temp_s1_end_xfer => d1_entrada_temp_s1_end_xfer,
      entrada_temp_s1_address => entrada_temp_s1_address,
      entrada_temp_s1_readdata_from_sa => entrada_temp_s1_readdata_from_sa,
      entrada_temp_s1_reset_n => entrada_temp_s1_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      entrada_temp_s1_readdata => entrada_temp_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_entrada_temp, which is an e_ptf_instance
  the_entrada_temp : entrada_temp
    port map(
      readdata => entrada_temp_s1_readdata,
      address => entrada_temp_s1_address,
      clk => internal_sys_clk,
      in_port => in_port_to_the_entrada_temp,
      reset_n => entrada_temp_s1_reset_n
    );


  --the_epcs_flash_controller_epcs_control_port, which is an e_instance
  the_epcs_flash_controller_epcs_control_port : epcs_flash_controller_epcs_control_port_arbitrator
    port map(
      cpu_data_master_granted_epcs_flash_controller_epcs_control_port => cpu_data_master_granted_epcs_flash_controller_epcs_control_port,
      cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port => cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port,
      cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port => cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port,
      cpu_data_master_requests_epcs_flash_controller_epcs_control_port => cpu_data_master_requests_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port => cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port => cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port => cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port => cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port,
      d1_epcs_flash_controller_epcs_control_port_end_xfer => d1_epcs_flash_controller_epcs_control_port_end_xfer,
      epcs_flash_controller_epcs_control_port_address => epcs_flash_controller_epcs_control_port_address,
      epcs_flash_controller_epcs_control_port_chipselect => epcs_flash_controller_epcs_control_port_chipselect,
      epcs_flash_controller_epcs_control_port_dataavailable_from_sa => epcs_flash_controller_epcs_control_port_dataavailable_from_sa,
      epcs_flash_controller_epcs_control_port_endofpacket_from_sa => epcs_flash_controller_epcs_control_port_endofpacket_from_sa,
      epcs_flash_controller_epcs_control_port_irq_from_sa => epcs_flash_controller_epcs_control_port_irq_from_sa,
      epcs_flash_controller_epcs_control_port_read_n => epcs_flash_controller_epcs_control_port_read_n,
      epcs_flash_controller_epcs_control_port_readdata_from_sa => epcs_flash_controller_epcs_control_port_readdata_from_sa,
      epcs_flash_controller_epcs_control_port_readyfordata_from_sa => epcs_flash_controller_epcs_control_port_readyfordata_from_sa,
      epcs_flash_controller_epcs_control_port_reset_n => epcs_flash_controller_epcs_control_port_reset_n,
      epcs_flash_controller_epcs_control_port_write_n => epcs_flash_controller_epcs_control_port_write_n,
      epcs_flash_controller_epcs_control_port_writedata => epcs_flash_controller_epcs_control_port_writedata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      epcs_flash_controller_epcs_control_port_dataavailable => epcs_flash_controller_epcs_control_port_dataavailable,
      epcs_flash_controller_epcs_control_port_endofpacket => epcs_flash_controller_epcs_control_port_endofpacket,
      epcs_flash_controller_epcs_control_port_irq => epcs_flash_controller_epcs_control_port_irq,
      epcs_flash_controller_epcs_control_port_readdata => epcs_flash_controller_epcs_control_port_readdata,
      epcs_flash_controller_epcs_control_port_readyfordata => epcs_flash_controller_epcs_control_port_readyfordata,
      reset_n => sys_clk_reset_n
    );


  --the_epcs_flash_controller, which is an e_ptf_instance
  the_epcs_flash_controller : epcs_flash_controller
    port map(
      dataavailable => epcs_flash_controller_epcs_control_port_dataavailable,
      dclk => internal_dclk_from_the_epcs_flash_controller,
      endofpacket => epcs_flash_controller_epcs_control_port_endofpacket,
      irq => epcs_flash_controller_epcs_control_port_irq,
      readdata => epcs_flash_controller_epcs_control_port_readdata,
      readyfordata => epcs_flash_controller_epcs_control_port_readyfordata,
      sce => internal_sce_from_the_epcs_flash_controller,
      sdo => internal_sdo_from_the_epcs_flash_controller,
      address => epcs_flash_controller_epcs_control_port_address,
      chipselect => epcs_flash_controller_epcs_control_port_chipselect,
      clk => internal_sys_clk,
      data0 => data0_to_the_epcs_flash_controller,
      read_n => epcs_flash_controller_epcs_control_port_read_n,
      reset_n => epcs_flash_controller_epcs_control_port_reset_n,
      write_n => epcs_flash_controller_epcs_control_port_write_n,
      writedata => epcs_flash_controller_epcs_control_port_writedata
    );


  --the_jtag_uart_avalon_jtag_slave, which is an e_instance
  the_jtag_uart_avalon_jtag_slave : jtag_uart_avalon_jtag_slave_arbitrator
    port map(
      cpu_data_master_granted_jtag_uart_avalon_jtag_slave => cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
      cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave => cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
      cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave => cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
      cpu_data_master_requests_jtag_uart_avalon_jtag_slave => cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
      d1_jtag_uart_avalon_jtag_slave_end_xfer => d1_jtag_uart_avalon_jtag_slave_end_xfer,
      jtag_uart_avalon_jtag_slave_address => jtag_uart_avalon_jtag_slave_address,
      jtag_uart_avalon_jtag_slave_chipselect => jtag_uart_avalon_jtag_slave_chipselect,
      jtag_uart_avalon_jtag_slave_dataavailable_from_sa => jtag_uart_avalon_jtag_slave_dataavailable_from_sa,
      jtag_uart_avalon_jtag_slave_irq_from_sa => jtag_uart_avalon_jtag_slave_irq_from_sa,
      jtag_uart_avalon_jtag_slave_read_n => jtag_uart_avalon_jtag_slave_read_n,
      jtag_uart_avalon_jtag_slave_readdata_from_sa => jtag_uart_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_avalon_jtag_slave_readyfordata_from_sa => jtag_uart_avalon_jtag_slave_readyfordata_from_sa,
      jtag_uart_avalon_jtag_slave_reset_n => jtag_uart_avalon_jtag_slave_reset_n,
      jtag_uart_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
      jtag_uart_avalon_jtag_slave_write_n => jtag_uart_avalon_jtag_slave_write_n,
      jtag_uart_avalon_jtag_slave_writedata => jtag_uart_avalon_jtag_slave_writedata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      jtag_uart_avalon_jtag_slave_dataavailable => jtag_uart_avalon_jtag_slave_dataavailable,
      jtag_uart_avalon_jtag_slave_irq => jtag_uart_avalon_jtag_slave_irq,
      jtag_uart_avalon_jtag_slave_readdata => jtag_uart_avalon_jtag_slave_readdata,
      jtag_uart_avalon_jtag_slave_readyfordata => jtag_uart_avalon_jtag_slave_readyfordata,
      jtag_uart_avalon_jtag_slave_waitrequest => jtag_uart_avalon_jtag_slave_waitrequest,
      reset_n => sys_clk_reset_n
    );


  --the_jtag_uart, which is an e_ptf_instance
  the_jtag_uart : jtag_uart
    port map(
      av_irq => jtag_uart_avalon_jtag_slave_irq,
      av_readdata => jtag_uart_avalon_jtag_slave_readdata,
      av_waitrequest => jtag_uart_avalon_jtag_slave_waitrequest,
      dataavailable => jtag_uart_avalon_jtag_slave_dataavailable,
      readyfordata => jtag_uart_avalon_jtag_slave_readyfordata,
      av_address => jtag_uart_avalon_jtag_slave_address,
      av_chipselect => jtag_uart_avalon_jtag_slave_chipselect,
      av_read_n => jtag_uart_avalon_jtag_slave_read_n,
      av_write_n => jtag_uart_avalon_jtag_slave_write_n,
      av_writedata => jtag_uart_avalon_jtag_slave_writedata,
      clk => internal_sys_clk,
      rst_n => jtag_uart_avalon_jtag_slave_reset_n
    );


  --the_out_test_s1, which is an e_instance
  the_out_test_s1 : out_test_s1_arbitrator
    port map(
      cpu_data_master_granted_out_test_s1 => cpu_data_master_granted_out_test_s1,
      cpu_data_master_qualified_request_out_test_s1 => cpu_data_master_qualified_request_out_test_s1,
      cpu_data_master_read_data_valid_out_test_s1 => cpu_data_master_read_data_valid_out_test_s1,
      cpu_data_master_requests_out_test_s1 => cpu_data_master_requests_out_test_s1,
      d1_out_test_s1_end_xfer => d1_out_test_s1_end_xfer,
      out_test_s1_address => out_test_s1_address,
      out_test_s1_chipselect => out_test_s1_chipselect,
      out_test_s1_readdata_from_sa => out_test_s1_readdata_from_sa,
      out_test_s1_reset_n => out_test_s1_reset_n,
      out_test_s1_write_n => out_test_s1_write_n,
      out_test_s1_writedata => out_test_s1_writedata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      out_test_s1_readdata => out_test_s1_readdata,
      reset_n => sys_clk_reset_n
    );


  --the_out_test, which is an e_ptf_instance
  the_out_test : out_test
    port map(
      out_port => internal_out_port_from_the_out_test,
      readdata => out_test_s1_readdata,
      address => out_test_s1_address,
      chipselect => out_test_s1_chipselect,
      clk => internal_sys_clk,
      reset_n => out_test_s1_reset_n,
      write_n => out_test_s1_write_n,
      writedata => out_test_s1_writedata
    );


  --the_pll_pll_slave, which is an e_instance
  the_pll_pll_slave : pll_pll_slave_arbitrator
    port map(
      NiosII_clock_2_out_granted_pll_pll_slave => NiosII_clock_2_out_granted_pll_pll_slave,
      NiosII_clock_2_out_qualified_request_pll_pll_slave => NiosII_clock_2_out_qualified_request_pll_pll_slave,
      NiosII_clock_2_out_read_data_valid_pll_pll_slave => NiosII_clock_2_out_read_data_valid_pll_pll_slave,
      NiosII_clock_2_out_requests_pll_pll_slave => NiosII_clock_2_out_requests_pll_pll_slave,
      d1_pll_pll_slave_end_xfer => d1_pll_pll_slave_end_xfer,
      pll_pll_slave_address => pll_pll_slave_address,
      pll_pll_slave_read => pll_pll_slave_read,
      pll_pll_slave_readdata_from_sa => pll_pll_slave_readdata_from_sa,
      pll_pll_slave_reset => pll_pll_slave_reset,
      pll_pll_slave_write => pll_pll_slave_write,
      pll_pll_slave_writedata => pll_pll_slave_writedata,
      NiosII_clock_2_out_address_to_slave => NiosII_clock_2_out_address_to_slave,
      NiosII_clock_2_out_read => NiosII_clock_2_out_read,
      NiosII_clock_2_out_write => NiosII_clock_2_out_write,
      NiosII_clock_2_out_writedata => NiosII_clock_2_out_writedata,
      clk => clk_50,
      pll_pll_slave_readdata => pll_pll_slave_readdata,
      reset_n => clk_50_reset_n
    );


  --sys_clk out_clk assignment, which is an e_assign
  internal_sys_clk <= out_clk_pll_c0;
  --sdram_clk out_clk assignment, which is an e_assign
  internal_sdram_clk <= out_clk_pll_c1;
  --the_pll, which is an e_ptf_instance
  the_pll : pll
    port map(
      c0 => out_clk_pll_c0,
      c1 => out_clk_pll_c1,
      locked => internal_locked_from_the_pll,
      phasedone => internal_phasedone_from_the_pll,
      readdata => pll_pll_slave_readdata,
      address => pll_pll_slave_address,
      areset => areset_to_the_pll,
      clk => clk_50,
      read => pll_pll_slave_read,
      reset => pll_pll_slave_reset,
      write => pll_pll_slave_write,
      writedata => pll_pll_slave_writedata
    );


  --the_sample_time_s1, which is an e_instance
  the_sample_time_s1 : sample_time_s1_arbitrator
    port map(
      cpu_data_master_granted_sample_time_s1 => cpu_data_master_granted_sample_time_s1,
      cpu_data_master_qualified_request_sample_time_s1 => cpu_data_master_qualified_request_sample_time_s1,
      cpu_data_master_read_data_valid_sample_time_s1 => cpu_data_master_read_data_valid_sample_time_s1,
      cpu_data_master_requests_sample_time_s1 => cpu_data_master_requests_sample_time_s1,
      d1_sample_time_s1_end_xfer => d1_sample_time_s1_end_xfer,
      sample_time_s1_address => sample_time_s1_address,
      sample_time_s1_chipselect => sample_time_s1_chipselect,
      sample_time_s1_irq_from_sa => sample_time_s1_irq_from_sa,
      sample_time_s1_readdata_from_sa => sample_time_s1_readdata_from_sa,
      sample_time_s1_reset_n => sample_time_s1_reset_n,
      sample_time_s1_write_n => sample_time_s1_write_n,
      sample_time_s1_writedata => sample_time_s1_writedata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n,
      sample_time_s1_irq => sample_time_s1_irq,
      sample_time_s1_readdata => sample_time_s1_readdata
    );


  --the_sample_time, which is an e_ptf_instance
  the_sample_time : sample_time
    port map(
      irq => sample_time_s1_irq,
      readdata => sample_time_s1_readdata,
      address => sample_time_s1_address,
      chipselect => sample_time_s1_chipselect,
      clk => internal_sys_clk,
      reset_n => sample_time_s1_reset_n,
      write_n => sample_time_s1_write_n,
      writedata => sample_time_s1_writedata
    );


  --the_sdram_s1, which is an e_instance
  the_sdram_s1 : sdram_s1_arbitrator
    port map(
      NiosII_clock_0_out_granted_sdram_s1 => NiosII_clock_0_out_granted_sdram_s1,
      NiosII_clock_0_out_qualified_request_sdram_s1 => NiosII_clock_0_out_qualified_request_sdram_s1,
      NiosII_clock_0_out_read_data_valid_sdram_s1 => NiosII_clock_0_out_read_data_valid_sdram_s1,
      NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register => NiosII_clock_0_out_read_data_valid_sdram_s1_shift_register,
      NiosII_clock_0_out_requests_sdram_s1 => NiosII_clock_0_out_requests_sdram_s1,
      NiosII_clock_1_out_granted_sdram_s1 => NiosII_clock_1_out_granted_sdram_s1,
      NiosII_clock_1_out_qualified_request_sdram_s1 => NiosII_clock_1_out_qualified_request_sdram_s1,
      NiosII_clock_1_out_read_data_valid_sdram_s1 => NiosII_clock_1_out_read_data_valid_sdram_s1,
      NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register => NiosII_clock_1_out_read_data_valid_sdram_s1_shift_register,
      NiosII_clock_1_out_requests_sdram_s1 => NiosII_clock_1_out_requests_sdram_s1,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      sdram_s1_address => sdram_s1_address,
      sdram_s1_byteenable_n => sdram_s1_byteenable_n,
      sdram_s1_chipselect => sdram_s1_chipselect,
      sdram_s1_read_n => sdram_s1_read_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_reset_n => sdram_s1_reset_n,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa,
      sdram_s1_write_n => sdram_s1_write_n,
      sdram_s1_writedata => sdram_s1_writedata,
      NiosII_clock_0_out_address_to_slave => NiosII_clock_0_out_address_to_slave,
      NiosII_clock_0_out_byteenable => NiosII_clock_0_out_byteenable,
      NiosII_clock_0_out_read => NiosII_clock_0_out_read,
      NiosII_clock_0_out_write => NiosII_clock_0_out_write,
      NiosII_clock_0_out_writedata => NiosII_clock_0_out_writedata,
      NiosII_clock_1_out_address_to_slave => NiosII_clock_1_out_address_to_slave,
      NiosII_clock_1_out_byteenable => NiosII_clock_1_out_byteenable,
      NiosII_clock_1_out_read => NiosII_clock_1_out_read,
      NiosII_clock_1_out_write => NiosII_clock_1_out_write,
      NiosII_clock_1_out_writedata => NiosII_clock_1_out_writedata,
      clk => internal_sdram_clk,
      reset_n => sdram_clk_reset_n,
      sdram_s1_readdata => sdram_s1_readdata,
      sdram_s1_readdatavalid => sdram_s1_readdatavalid,
      sdram_s1_waitrequest => sdram_s1_waitrequest
    );


  --the_sdram, which is an e_ptf_instance
  the_sdram : sdram
    port map(
      za_data => sdram_s1_readdata,
      za_valid => sdram_s1_readdatavalid,
      za_waitrequest => sdram_s1_waitrequest,
      zs_addr => internal_zs_addr_from_the_sdram,
      zs_ba => internal_zs_ba_from_the_sdram,
      zs_cas_n => internal_zs_cas_n_from_the_sdram,
      zs_cke => internal_zs_cke_from_the_sdram,
      zs_cs_n => internal_zs_cs_n_from_the_sdram,
      zs_dq => zs_dq_to_and_from_the_sdram,
      zs_dqm => internal_zs_dqm_from_the_sdram,
      zs_ras_n => internal_zs_ras_n_from_the_sdram,
      zs_we_n => internal_zs_we_n_from_the_sdram,
      az_addr => sdram_s1_address,
      az_be_n => sdram_s1_byteenable_n,
      az_cs => sdram_s1_chipselect,
      az_data => sdram_s1_writedata,
      az_rd_n => sdram_s1_read_n,
      az_wr_n => sdram_s1_write_n,
      clk => internal_sdram_clk,
      reset_n => sdram_s1_reset_n
    );


  --the_sysid_control_slave, which is an e_instance
  the_sysid_control_slave : sysid_control_slave_arbitrator
    port map(
      cpu_data_master_granted_sysid_control_slave => cpu_data_master_granted_sysid_control_slave,
      cpu_data_master_qualified_request_sysid_control_slave => cpu_data_master_qualified_request_sysid_control_slave,
      cpu_data_master_read_data_valid_sysid_control_slave => cpu_data_master_read_data_valid_sysid_control_slave,
      cpu_data_master_requests_sysid_control_slave => cpu_data_master_requests_sysid_control_slave,
      d1_sysid_control_slave_end_xfer => d1_sysid_control_slave_end_xfer,
      sysid_control_slave_address => sysid_control_slave_address,
      sysid_control_slave_readdata_from_sa => sysid_control_slave_readdata_from_sa,
      sysid_control_slave_reset_n => sysid_control_slave_reset_n,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => sys_clk_reset_n,
      sysid_control_slave_readdata => sysid_control_slave_readdata
    );


  --the_sysid, which is an e_ptf_instance
  the_sysid : sysid
    port map(
      readdata => sysid_control_slave_readdata,
      address => sysid_control_slave_address,
      clock => sysid_control_slave_clock,
      reset_n => sysid_control_slave_reset_n
    );


  --the_timer_ONOF_s1, which is an e_instance
  the_timer_ONOF_s1 : timer_ONOF_s1_arbitrator
    port map(
      cpu_data_master_granted_timer_ONOF_s1 => cpu_data_master_granted_timer_ONOF_s1,
      cpu_data_master_qualified_request_timer_ONOF_s1 => cpu_data_master_qualified_request_timer_ONOF_s1,
      cpu_data_master_read_data_valid_timer_ONOF_s1 => cpu_data_master_read_data_valid_timer_ONOF_s1,
      cpu_data_master_requests_timer_ONOF_s1 => cpu_data_master_requests_timer_ONOF_s1,
      d1_timer_ONOF_s1_end_xfer => d1_timer_ONOF_s1_end_xfer,
      timer_ONOF_s1_address => timer_ONOF_s1_address,
      timer_ONOF_s1_chipselect => timer_ONOF_s1_chipselect,
      timer_ONOF_s1_irq_from_sa => timer_ONOF_s1_irq_from_sa,
      timer_ONOF_s1_readdata_from_sa => timer_ONOF_s1_readdata_from_sa,
      timer_ONOF_s1_reset_n => timer_ONOF_s1_reset_n,
      timer_ONOF_s1_write_n => timer_ONOF_s1_write_n,
      timer_ONOF_s1_writedata => timer_ONOF_s1_writedata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n,
      timer_ONOF_s1_irq => timer_ONOF_s1_irq,
      timer_ONOF_s1_readdata => timer_ONOF_s1_readdata
    );


  --the_timer_ONOF, which is an e_ptf_instance
  the_timer_ONOF : timer_ONOF
    port map(
      irq => timer_ONOF_s1_irq,
      readdata => timer_ONOF_s1_readdata,
      address => timer_ONOF_s1_address,
      chipselect => timer_ONOF_s1_chipselect,
      clk => internal_sys_clk,
      reset_n => timer_ONOF_s1_reset_n,
      write_n => timer_ONOF_s1_write_n,
      writedata => timer_ONOF_s1_writedata
    );


  --the_uart_gps_s1, which is an e_instance
  the_uart_gps_s1 : uart_gps_s1_arbitrator
    port map(
      cpu_data_master_granted_uart_gps_s1 => cpu_data_master_granted_uart_gps_s1,
      cpu_data_master_qualified_request_uart_gps_s1 => cpu_data_master_qualified_request_uart_gps_s1,
      cpu_data_master_read_data_valid_uart_gps_s1 => cpu_data_master_read_data_valid_uart_gps_s1,
      cpu_data_master_requests_uart_gps_s1 => cpu_data_master_requests_uart_gps_s1,
      d1_uart_gps_s1_end_xfer => d1_uart_gps_s1_end_xfer,
      uart_gps_s1_address => uart_gps_s1_address,
      uart_gps_s1_begintransfer => uart_gps_s1_begintransfer,
      uart_gps_s1_chipselect => uart_gps_s1_chipselect,
      uart_gps_s1_dataavailable_from_sa => uart_gps_s1_dataavailable_from_sa,
      uart_gps_s1_irq_from_sa => uart_gps_s1_irq_from_sa,
      uart_gps_s1_read_n => uart_gps_s1_read_n,
      uart_gps_s1_readdata_from_sa => uart_gps_s1_readdata_from_sa,
      uart_gps_s1_readyfordata_from_sa => uart_gps_s1_readyfordata_from_sa,
      uart_gps_s1_reset_n => uart_gps_s1_reset_n,
      uart_gps_s1_write_n => uart_gps_s1_write_n,
      uart_gps_s1_writedata => uart_gps_s1_writedata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n,
      uart_gps_s1_dataavailable => uart_gps_s1_dataavailable,
      uart_gps_s1_irq => uart_gps_s1_irq,
      uart_gps_s1_readdata => uart_gps_s1_readdata,
      uart_gps_s1_readyfordata => uart_gps_s1_readyfordata
    );


  --the_uart_gps, which is an e_ptf_instance
  the_uart_gps : uart_gps
    port map(
      dataavailable => uart_gps_s1_dataavailable,
      irq => uart_gps_s1_irq,
      readdata => uart_gps_s1_readdata,
      readyfordata => uart_gps_s1_readyfordata,
      txd => internal_txd_from_the_uart_gps,
      address => uart_gps_s1_address,
      begintransfer => uart_gps_s1_begintransfer,
      chipselect => uart_gps_s1_chipselect,
      clk => internal_sys_clk,
      read_n => uart_gps_s1_read_n,
      reset_n => uart_gps_s1_reset_n,
      rxd => rxd_to_the_uart_gps,
      write_n => uart_gps_s1_write_n,
      writedata => uart_gps_s1_writedata
    );


  --the_uart_xbee_s1, which is an e_instance
  the_uart_xbee_s1 : uart_xbee_s1_arbitrator
    port map(
      cpu_data_master_granted_uart_xbee_s1 => cpu_data_master_granted_uart_xbee_s1,
      cpu_data_master_qualified_request_uart_xbee_s1 => cpu_data_master_qualified_request_uart_xbee_s1,
      cpu_data_master_read_data_valid_uart_xbee_s1 => cpu_data_master_read_data_valid_uart_xbee_s1,
      cpu_data_master_requests_uart_xbee_s1 => cpu_data_master_requests_uart_xbee_s1,
      d1_uart_xbee_s1_end_xfer => d1_uart_xbee_s1_end_xfer,
      uart_xbee_s1_address => uart_xbee_s1_address,
      uart_xbee_s1_begintransfer => uart_xbee_s1_begintransfer,
      uart_xbee_s1_chipselect => uart_xbee_s1_chipselect,
      uart_xbee_s1_dataavailable_from_sa => uart_xbee_s1_dataavailable_from_sa,
      uart_xbee_s1_irq_from_sa => uart_xbee_s1_irq_from_sa,
      uart_xbee_s1_read_n => uart_xbee_s1_read_n,
      uart_xbee_s1_readdata_from_sa => uart_xbee_s1_readdata_from_sa,
      uart_xbee_s1_readyfordata_from_sa => uart_xbee_s1_readyfordata_from_sa,
      uart_xbee_s1_reset_n => uart_xbee_s1_reset_n,
      uart_xbee_s1_write_n => uart_xbee_s1_write_n,
      uart_xbee_s1_writedata => uart_xbee_s1_writedata,
      clk => internal_sys_clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => sys_clk_reset_n,
      uart_xbee_s1_dataavailable => uart_xbee_s1_dataavailable,
      uart_xbee_s1_irq => uart_xbee_s1_irq,
      uart_xbee_s1_readdata => uart_xbee_s1_readdata,
      uart_xbee_s1_readyfordata => uart_xbee_s1_readyfordata
    );


  --the_uart_xbee, which is an e_ptf_instance
  the_uart_xbee : uart_xbee
    port map(
      dataavailable => uart_xbee_s1_dataavailable,
      irq => uart_xbee_s1_irq,
      readdata => uart_xbee_s1_readdata,
      readyfordata => uart_xbee_s1_readyfordata,
      txd => internal_txd_from_the_uart_xbee,
      address => uart_xbee_s1_address,
      begintransfer => uart_xbee_s1_begintransfer,
      chipselect => uart_xbee_s1_chipselect,
      clk => internal_sys_clk,
      read_n => uart_xbee_s1_read_n,
      reset_n => uart_xbee_s1_reset_n,
      rxd => rxd_to_the_uart_xbee,
      write_n => uart_xbee_s1_write_n,
      writedata => uart_xbee_s1_writedata
    );


  --reset is asserted asynchronously and deasserted synchronously
  NiosII_reset_sys_clk_domain_synch : NiosII_reset_sys_clk_domain_synch_module
    port map(
      data_out => sys_clk_reset_n,
      clk => internal_sys_clk,
      data_in => module_input6,
      reset_n => reset_n_sources
    );

  module_input6 <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT (((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_resetrequest_from_sa)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_resetrequest_from_sa)))) OR std_logic_vector'("00000000000000000000000000000000")) OR std_logic_vector'("00000000000000000000000000000000"))));
  --reset is asserted asynchronously and deasserted synchronously
  NiosII_reset_clk_50_domain_synch : NiosII_reset_clk_50_domain_synch_module
    port map(
      data_out => clk_50_reset_n,
      clk => clk_50,
      data_in => module_input7,
      reset_n => reset_n_sources
    );

  module_input7 <= std_logic'('1');

  --reset is asserted asynchronously and deasserted synchronously
  NiosII_reset_sdram_clk_domain_synch : NiosII_reset_sdram_clk_domain_synch_module
    port map(
      data_out => sdram_clk_reset_n,
      clk => internal_sdram_clk,
      data_in => module_input8,
      reset_n => reset_n_sources
    );

  module_input8 <= std_logic'('1');

  --NiosII_clock_0_in_writedata of type writedata does not connect to anything so wire it to default (0)
  NiosII_clock_0_in_writedata <= std_logic_vector'("0000000000000000");
  --NiosII_clock_0_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  NiosII_clock_0_out_endofpacket <= std_logic'('0');
  --NiosII_clock_1_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  NiosII_clock_1_out_endofpacket <= std_logic'('0');
  --NiosII_clock_2_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  NiosII_clock_2_out_endofpacket <= std_logic'('0');
  --sysid_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  sysid_control_slave_clock <= std_logic'('0');
  --vhdl renameroo for output signals
  dclk_from_the_epcs_flash_controller <= internal_dclk_from_the_epcs_flash_controller;
  --vhdl renameroo for output signals
  locked_from_the_pll <= internal_locked_from_the_pll;
  --vhdl renameroo for output signals
  out_port_from_the_PWM_1 <= internal_out_port_from_the_PWM_1;
  --vhdl renameroo for output signals
  out_port_from_the_PWM_2 <= internal_out_port_from_the_PWM_2;
  --vhdl renameroo for output signals
  out_port_from_the_PWM_3 <= internal_out_port_from_the_PWM_3;
  --vhdl renameroo for output signals
  out_port_from_the_PWM_4 <= internal_out_port_from_the_PWM_4;
  --vhdl renameroo for output signals
  out_port_from_the_data_tx <= internal_out_port_from_the_data_tx;
  --vhdl renameroo for output signals
  out_port_from_the_out_test <= internal_out_port_from_the_out_test;
  --vhdl renameroo for output signals
  phasedone_from_the_pll <= internal_phasedone_from_the_pll;
  --vhdl renameroo for output signals
  sce_from_the_epcs_flash_controller <= internal_sce_from_the_epcs_flash_controller;
  --vhdl renameroo for output signals
  sdo_from_the_epcs_flash_controller <= internal_sdo_from_the_epcs_flash_controller;
  --vhdl renameroo for output signals
  sdram_clk <= internal_sdram_clk;
  --vhdl renameroo for output signals
  sys_clk <= internal_sys_clk;
  --vhdl renameroo for output signals
  txd_from_the_uart_gps <= internal_txd_from_the_uart_gps;
  --vhdl renameroo for output signals
  txd_from_the_uart_xbee <= internal_txd_from_the_uart_xbee;
  --vhdl renameroo for output signals
  zs_addr_from_the_sdram <= internal_zs_addr_from_the_sdram;
  --vhdl renameroo for output signals
  zs_ba_from_the_sdram <= internal_zs_ba_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cas_n_from_the_sdram <= internal_zs_cas_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cke_from_the_sdram <= internal_zs_cke_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cs_n_from_the_sdram <= internal_zs_cs_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_dqm_from_the_sdram <= internal_zs_dqm_from_the_sdram;
  --vhdl renameroo for output signals
  zs_ras_n_from_the_sdram <= internal_zs_ras_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_we_n_from_the_sdram <= internal_zs_we_n_from_the_sdram;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your libraries here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>

entity test_bench is 
end entity test_bench;


architecture europa of test_bench is
component NiosII is 
           port (
                 -- 1) global signals:
                    signal clk_50 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_clk : OUT STD_LOGIC;
                    signal sys_clk : OUT STD_LOGIC;

                 -- the_PWM_1
                    signal out_port_from_the_PWM_1 : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);

                 -- the_PWM_2
                    signal out_port_from_the_PWM_2 : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);

                 -- the_PWM_3
                    signal out_port_from_the_PWM_3 : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);

                 -- the_PWM_4
                    signal out_port_from_the_PWM_4 : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);

                 -- the_data_tx
                    signal out_port_from_the_data_tx : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);

                 -- the_duty_1
                    signal in_port_to_the_duty_1 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

                 -- the_duty_2
                    signal in_port_to_the_duty_2 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

                 -- the_duty_3
                    signal in_port_to_the_duty_3 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

                 -- the_duty_4
                    signal in_port_to_the_duty_4 : IN STD_LOGIC_VECTOR (11 DOWNTO 0);

                 -- the_entrada_ac_eje_X
                    signal in_port_to_the_entrada_ac_eje_X : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_ac_eje_Y
                    signal in_port_to_the_entrada_ac_eje_Y : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_ac_eje_Z
                    signal in_port_to_the_entrada_ac_eje_Z : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_gy_eje_X
                    signal in_port_to_the_entrada_gy_eje_X : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_gy_eje_Y
                    signal in_port_to_the_entrada_gy_eje_Y : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_gy_eje_Z
                    signal in_port_to_the_entrada_gy_eje_Z : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_ma_eje_X
                    signal in_port_to_the_entrada_ma_eje_X : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_ma_eje_Y
                    signal in_port_to_the_entrada_ma_eje_Y : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_ma_eje_Z
                    signal in_port_to_the_entrada_ma_eje_Z : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_entrada_temp
                    signal in_port_to_the_entrada_temp : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- the_epcs_flash_controller
                    signal data0_to_the_epcs_flash_controller : IN STD_LOGIC;
                    signal dclk_from_the_epcs_flash_controller : OUT STD_LOGIC;
                    signal sce_from_the_epcs_flash_controller : OUT STD_LOGIC;
                    signal sdo_from_the_epcs_flash_controller : OUT STD_LOGIC;

                 -- the_out_test
                    signal out_port_from_the_out_test : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

                 -- the_pll
                    signal areset_to_the_pll : IN STD_LOGIC;
                    signal locked_from_the_pll : OUT STD_LOGIC;
                    signal phasedone_from_the_pll : OUT STD_LOGIC;

                 -- the_sdram
                    signal zs_addr_from_the_sdram : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
                    signal zs_ba_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_cke_from_the_sdram : OUT STD_LOGIC;
                    signal zs_cs_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_dq_to_and_from_the_sdram : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_we_n_from_the_sdram : OUT STD_LOGIC;

                 -- the_uart_gps
                    signal rxd_to_the_uart_gps : IN STD_LOGIC;
                    signal txd_from_the_uart_gps : OUT STD_LOGIC;

                 -- the_uart_xbee
                    signal rxd_to_the_uart_xbee : IN STD_LOGIC;
                    signal txd_from_the_uart_xbee : OUT STD_LOGIC
                 );
end component NiosII;

                signal NiosII_clock_0_in_endofpacket_from_sa :  STD_LOGIC;
                signal NiosII_clock_0_in_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal NiosII_clock_0_out_endofpacket :  STD_LOGIC;
                signal NiosII_clock_0_out_nativeaddress :  STD_LOGIC_VECTOR (23 DOWNTO 0);
                signal NiosII_clock_1_in_endofpacket_from_sa :  STD_LOGIC;
                signal NiosII_clock_1_out_endofpacket :  STD_LOGIC;
                signal NiosII_clock_1_out_nativeaddress :  STD_LOGIC_VECTOR (23 DOWNTO 0);
                signal NiosII_clock_2_in_endofpacket_from_sa :  STD_LOGIC;
                signal NiosII_clock_2_out_endofpacket :  STD_LOGIC;
                signal NiosII_clock_2_out_nativeaddress :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal areset_to_the_pll :  STD_LOGIC;
                signal clk :  STD_LOGIC;
                signal clk_50 :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_a :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_b :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_c :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_clk :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_estatus :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_ipending :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_multi_readra :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_readrb :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_reset :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_status :  STD_LOGIC;
                signal cpu_custom_instruction_master_multi_writerc :  STD_LOGIC;
                signal data0_to_the_epcs_flash_controller :  STD_LOGIC;
                signal dclk_from_the_epcs_flash_controller :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal in_port_to_the_duty_1 :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal in_port_to_the_duty_2 :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal in_port_to_the_duty_3 :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal in_port_to_the_duty_4 :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal in_port_to_the_entrada_ac_eje_X :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_ac_eje_Y :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_ac_eje_Z :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_gy_eje_X :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_gy_eje_Y :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_gy_eje_Z :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_ma_eje_X :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_ma_eje_Y :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_ma_eje_Z :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal in_port_to_the_entrada_temp :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal locked_from_the_pll :  STD_LOGIC;
                signal out_port_from_the_PWM_1 :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal out_port_from_the_PWM_2 :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal out_port_from_the_PWM_3 :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal out_port_from_the_PWM_4 :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal out_port_from_the_data_tx :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal out_port_from_the_out_test :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal phasedone_from_the_pll :  STD_LOGIC;
                signal reset_n :  STD_LOGIC;
                signal rxd_to_the_uart_gps :  STD_LOGIC;
                signal rxd_to_the_uart_xbee :  STD_LOGIC;
                signal sce_from_the_epcs_flash_controller :  STD_LOGIC;
                signal sdo_from_the_epcs_flash_controller :  STD_LOGIC;
                signal sdram_clk :  STD_LOGIC;
                signal sys_clk :  STD_LOGIC;
                signal sysid_control_slave_clock :  STD_LOGIC;
                signal txd_from_the_uart_gps :  STD_LOGIC;
                signal txd_from_the_uart_xbee :  STD_LOGIC;
                signal uart_gps_s1_dataavailable_from_sa :  STD_LOGIC;
                signal uart_gps_s1_readyfordata_from_sa :  STD_LOGIC;
                signal uart_xbee_s1_dataavailable_from_sa :  STD_LOGIC;
                signal uart_xbee_s1_readyfordata_from_sa :  STD_LOGIC;
                signal zs_addr_from_the_sdram :  STD_LOGIC_VECTOR (12 DOWNTO 0);
                signal zs_ba_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_cas_n_from_the_sdram :  STD_LOGIC;
                signal zs_cke_from_the_sdram :  STD_LOGIC;
                signal zs_cs_n_from_the_sdram :  STD_LOGIC;
                signal zs_dq_to_and_from_the_sdram :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal zs_dqm_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_ras_n_from_the_sdram :  STD_LOGIC;
                signal zs_we_n_from_the_sdram :  STD_LOGIC;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : NiosII
    port map(
      dclk_from_the_epcs_flash_controller => dclk_from_the_epcs_flash_controller,
      locked_from_the_pll => locked_from_the_pll,
      out_port_from_the_PWM_1 => out_port_from_the_PWM_1,
      out_port_from_the_PWM_2 => out_port_from_the_PWM_2,
      out_port_from_the_PWM_3 => out_port_from_the_PWM_3,
      out_port_from_the_PWM_4 => out_port_from_the_PWM_4,
      out_port_from_the_data_tx => out_port_from_the_data_tx,
      out_port_from_the_out_test => out_port_from_the_out_test,
      phasedone_from_the_pll => phasedone_from_the_pll,
      sce_from_the_epcs_flash_controller => sce_from_the_epcs_flash_controller,
      sdo_from_the_epcs_flash_controller => sdo_from_the_epcs_flash_controller,
      sdram_clk => sdram_clk,
      sys_clk => sys_clk,
      txd_from_the_uart_gps => txd_from_the_uart_gps,
      txd_from_the_uart_xbee => txd_from_the_uart_xbee,
      zs_addr_from_the_sdram => zs_addr_from_the_sdram,
      zs_ba_from_the_sdram => zs_ba_from_the_sdram,
      zs_cas_n_from_the_sdram => zs_cas_n_from_the_sdram,
      zs_cke_from_the_sdram => zs_cke_from_the_sdram,
      zs_cs_n_from_the_sdram => zs_cs_n_from_the_sdram,
      zs_dq_to_and_from_the_sdram => zs_dq_to_and_from_the_sdram,
      zs_dqm_from_the_sdram => zs_dqm_from_the_sdram,
      zs_ras_n_from_the_sdram => zs_ras_n_from_the_sdram,
      zs_we_n_from_the_sdram => zs_we_n_from_the_sdram,
      areset_to_the_pll => areset_to_the_pll,
      clk_50 => clk_50,
      data0_to_the_epcs_flash_controller => data0_to_the_epcs_flash_controller,
      in_port_to_the_duty_1 => in_port_to_the_duty_1,
      in_port_to_the_duty_2 => in_port_to_the_duty_2,
      in_port_to_the_duty_3 => in_port_to_the_duty_3,
      in_port_to_the_duty_4 => in_port_to_the_duty_4,
      in_port_to_the_entrada_ac_eje_X => in_port_to_the_entrada_ac_eje_X,
      in_port_to_the_entrada_ac_eje_Y => in_port_to_the_entrada_ac_eje_Y,
      in_port_to_the_entrada_ac_eje_Z => in_port_to_the_entrada_ac_eje_Z,
      in_port_to_the_entrada_gy_eje_X => in_port_to_the_entrada_gy_eje_X,
      in_port_to_the_entrada_gy_eje_Y => in_port_to_the_entrada_gy_eje_Y,
      in_port_to_the_entrada_gy_eje_Z => in_port_to_the_entrada_gy_eje_Z,
      in_port_to_the_entrada_ma_eje_X => in_port_to_the_entrada_ma_eje_X,
      in_port_to_the_entrada_ma_eje_Y => in_port_to_the_entrada_ma_eje_Y,
      in_port_to_the_entrada_ma_eje_Z => in_port_to_the_entrada_ma_eje_Z,
      in_port_to_the_entrada_temp => in_port_to_the_entrada_temp,
      reset_n => reset_n,
      rxd_to_the_uart_gps => rxd_to_the_uart_gps,
      rxd_to_the_uart_xbee => rxd_to_the_uart_xbee
    );


  process
  begin
    clk_50 <= '0';
    loop
       wait for 10 ns;
       clk_50 <= not clk_50;
    end loop;
  end process;
  PROCESS
    BEGIN
       reset_n <= '0';
       wait for 200 ns;
       reset_n <= '1'; 
    WAIT;
  END PROCESS;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add additional architecture here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


end europa;



--synthesis translate_on
