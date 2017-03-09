library verilog;
use verilog.vl_types.all;
entity NCO_bb is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        fre_1023k0      : in     vl_logic_vector(27 downto 0);
        pha_1023k0      : in     vl_logic_vector(27 downto 0);
        fre_carrier0    : in     vl_logic_vector(27 downto 0);
        fre_1023k1      : in     vl_logic_vector(27 downto 0);
        pha_1023k1      : in     vl_logic_vector(27 downto 0);
        fre_carrier1    : in     vl_logic_vector(27 downto 0);
        fre_1023k2      : in     vl_logic_vector(27 downto 0);
        pha_1023k2      : in     vl_logic_vector(27 downto 0);
        fre_carrier2    : in     vl_logic_vector(27 downto 0);
        fre_1023k3      : in     vl_logic_vector(27 downto 0);
        pha_1023k3      : in     vl_logic_vector(27 downto 0);
        fre_carrier3    : in     vl_logic_vector(27 downto 0);
        fre_1023k4      : in     vl_logic_vector(27 downto 0);
        pha_1023k4      : in     vl_logic_vector(27 downto 0);
        fre_carrier4    : in     vl_logic_vector(27 downto 0);
        fre_1023k5      : in     vl_logic_vector(27 downto 0);
        pha_1023k5      : in     vl_logic_vector(27 downto 0);
        fre_carrier5    : in     vl_logic_vector(27 downto 0);
        fre_1023k6      : in     vl_logic_vector(27 downto 0);
        pha_1023k6      : in     vl_logic_vector(27 downto 0);
        fre_carrier6    : in     vl_logic_vector(27 downto 0);
        fre_1023k7      : in     vl_logic_vector(27 downto 0);
        pha_1023k7      : in     vl_logic_vector(27 downto 0);
        fre_carrier7    : in     vl_logic_vector(27 downto 0);
        clk_1023k       : out    vl_logic_vector(7 downto 0);
        clk_carrier     : out    vl_logic_vector(7 downto 0)
    );
end NCO_bb;
