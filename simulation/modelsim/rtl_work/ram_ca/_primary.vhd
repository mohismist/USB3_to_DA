library verilog;
use verilog.vl_types.all;
entity ram_ca is
    port(
        data            : in     vl_logic_vector(31 downto 0);
        rdaddress       : in     vl_logic_vector(9 downto 0);
        rdclock         : in     vl_logic;
        wraddress       : in     vl_logic_vector(4 downto 0);
        wrclock         : in     vl_logic;
        wren            : in     vl_logic;
        q               : out    vl_logic_vector(0 downto 0)
    );
end ram_ca;
