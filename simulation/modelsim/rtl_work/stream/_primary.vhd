library verilog;
use verilog.vl_types.all;
entity stream is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        FLAGA           : in     vl_logic;
        DATA_DIR        : in     vl_logic;
        wrfull          : in     vl_logic;
        wrreq           : out    vl_logic;
        SLCS            : out    vl_logic;
        SLOE            : out    vl_logic;
        SLRD            : out    vl_logic;
        SLWR            : out    vl_logic;
        A1              : out    vl_logic;
        A0              : out    vl_logic;
        usb_rd_cnt      : out    vl_logic_vector(13 downto 0);
        usb_wr_cnt      : out    vl_logic_vector(31 downto 0);
        usb_rd_state    : out    vl_logic_vector(2 downto 0);
        usb_wr_state    : out    vl_logic_vector(2 downto 0)
    );
end stream;
