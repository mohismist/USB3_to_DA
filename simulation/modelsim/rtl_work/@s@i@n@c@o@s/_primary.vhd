library verilog;
use verilog.vl_types.all;
entity SINCOS is
    generic(
        DATA_WIDTH      : integer := 28;
        PIPELINE        : integer := 28
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        phase_in        : in     vl_logic_vector;
        sin             : out    vl_logic_vector(15 downto 0);
        cos             : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of PIPELINE : constant is 1;
end SINCOS;
