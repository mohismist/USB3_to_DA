library verilog;
use verilog.vl_types.all;
entity sig_pll is
    port(
        inclk0          : in     vl_logic;
        c0              : out    vl_logic;
        locked          : out    vl_logic
    );
end sig_pll;
