library verilog;
use verilog.vl_types.all;
entity NCO is
    generic(
        DATA_WIDTH      : integer := 28
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        fre_chtr        : in     vl_logic_vector(27 downto 0);
        pha_chtr        : in     vl_logic_vector(27 downto 0);
        sin             : out    vl_logic_vector(15 downto 0);
        cos             : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end NCO;
