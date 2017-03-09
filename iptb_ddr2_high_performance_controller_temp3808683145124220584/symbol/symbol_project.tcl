package require ::quartus::project
set project_name tempproject
if [catch {project_open $project_name}] {
        project_new $project_name
}
export_assignments
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/ram.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/ram_alt_mem_ddrx_controller_top.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_controller.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_addr_cmd.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_addr_cmd_wrap.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_controller_st_top.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ddr2_odt_gen.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ddr3_odt_gen.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_lpddr2_addr_cmd.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_odt_gen.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_rdwr_data_tmg.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_arbiter.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_burst_gen.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_cmd_gen.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_csr.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_buffer.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_buffer_manager.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_burst_tracking.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_dataid_manager.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_fifo.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_list.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_rdata_path.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_wdata_path.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_define.iv";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ecc_decoder.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ecc_decoder_32_syn.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ecc_decoder_64_syn.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ecc_encoder.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ecc_encoder_32_syn.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ecc_encoder_64_syn.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_input_if.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_mm_st_converter.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_rank_timer.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_sideband.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_tbp.v";
set_global_assignment -name "VERILOG_FILE" "D:/Projects/FPGA/USB3_to_DA/iptb_ddr2_high_performance_controller_temp3808683145124220584/alt_mem_ddrx_timing_param.v";
set_global_assignment -name USER_LIBRARIES "D:/Apps/Altera/13.1/ip/altera/ddr2_high_perf/lib"
set_global_assignment -name "DEVICE" "AUTO";
project_close
