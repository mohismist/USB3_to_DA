library verilog;
use verilog.vl_types.all;
entity ram_bb is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0);
        delay_ca0       : in     vl_logic_vector(9 downto 0);
        delay_ca1       : in     vl_logic_vector(9 downto 0);
        delay_ca2       : in     vl_logic_vector(9 downto 0);
        delay_ca3       : in     vl_logic_vector(9 downto 0);
        delay_ca4       : in     vl_logic_vector(9 downto 0);
        delay_ca5       : in     vl_logic_vector(9 downto 0);
        delay_ca6       : in     vl_logic_vector(9 downto 0);
        delay_ca7       : in     vl_logic_vector(9 downto 0);
        clk_1023k       : in     vl_logic_vector(7 downto 0);
        wren            : in     vl_logic_vector(15 downto 0);
        data_ca         : out    vl_logic_vector(7 downto 0);
        data_msg        : out    vl_logic_vector(7 downto 0)
    );
end ram_bb;
