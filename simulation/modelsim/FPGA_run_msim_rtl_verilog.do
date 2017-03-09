transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/NCO_bb.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/NCO.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/stream.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/SINCOS.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/FPGA.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/hnr_pll.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/hnr_fifo.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/sig_pll.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/ram_ca.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/ram_bb.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA {D:/Projects/FPGA/USB3_to_DA/ram_msg.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA/db {D:/Projects/FPGA/USB3_to_DA/db/sig_pll_altpll.v}
vlog -vlog01compat -work work +incdir+D:/Projects/FPGA/USB3_to_DA/db {D:/Projects/FPGA/USB3_to_DA/db/hnr_pll_altpll.v}

