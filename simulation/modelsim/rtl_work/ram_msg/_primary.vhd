library verilog;
use verilog.vl_types.all;
entity ram_msg is
    port(
        data            : in     vl_logic_vector(31 downto 0);
        rdaddress       : in     vl_logic_vector(10 downto 0);
        rdclock         : in     vl_logic;
        wraddress       : in     vl_logic_vector(5 downto 0);
        wrclock         : in     vl_logic;
        wren            : in     vl_logic;
        q               : out    vl_logic_vector(0 downto 0)
    );
end ram_msg;
