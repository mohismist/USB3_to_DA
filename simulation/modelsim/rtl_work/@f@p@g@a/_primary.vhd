library verilog;
use verilog.vl_types.all;
entity FPGA is
    port(
        CLK_IN          : in     vl_logic;
        RESET_N         : in     vl_logic;
        USB3_CTL4       : in     vl_logic;
        USB3_CTL5       : in     vl_logic;
        USB3_DQ         : inout  vl_logic_vector(31 downto 0);
        data_hnr        : out    vl_logic_vector(31 downto 0);
        USB3_CTL2       : out    vl_logic;
        USB3_CTL3       : out    vl_logic;
        USB3_CTL1       : out    vl_logic;
        USB3_CTL0       : out    vl_logic;
        USB3_PCLK       : out    vl_logic;
        USB3_CTL11      : out    vl_logic;
        USB3_CTL12      : out    vl_logic;
        SCLK            : out    vl_logic
    );
end FPGA;
