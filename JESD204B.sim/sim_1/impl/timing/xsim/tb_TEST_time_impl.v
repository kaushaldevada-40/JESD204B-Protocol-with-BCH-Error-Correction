// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Tue Jun  3 11:29:35 2025
// Host        : HP-YD running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/Project/JESD204B/JESD204B.sim/sim_1/impl/timing/xsim/tb_TEST_time_impl.v
// Design      : TEST
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "d6fa7ea8" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module TEST
   (clk,
    sysref,
    rst,
    data_in,
    data_out);
  (* IBUF_LOW_PWR *) input clk;
  input sysref;
  input rst;
  input [13:0]data_in;
  output [13:0]data_out;

  wire [13:0]data_out;

initial begin
 $sdf_annotate("tb_TEST_time_impl.sdf",,,,"tool_control");
end
  OBUF \data_out_OBUF[0]_inst 
       (.I(1'b0),
        .O(data_out[0]));
  OBUF \data_out_OBUF[10]_inst 
       (.I(1'b0),
        .O(data_out[10]));
  OBUF \data_out_OBUF[11]_inst 
       (.I(1'b0),
        .O(data_out[11]));
  OBUF \data_out_OBUF[12]_inst 
       (.I(1'b0),
        .O(data_out[12]));
  OBUF \data_out_OBUF[13]_inst 
       (.I(1'b0),
        .O(data_out[13]));
  OBUF \data_out_OBUF[1]_inst 
       (.I(1'b0),
        .O(data_out[1]));
  OBUF \data_out_OBUF[2]_inst 
       (.I(1'b0),
        .O(data_out[2]));
  OBUF \data_out_OBUF[3]_inst 
       (.I(1'b0),
        .O(data_out[3]));
  OBUF \data_out_OBUF[4]_inst 
       (.I(1'b0),
        .O(data_out[4]));
  OBUF \data_out_OBUF[5]_inst 
       (.I(1'b0),
        .O(data_out[5]));
  OBUF \data_out_OBUF[6]_inst 
       (.I(1'b0),
        .O(data_out[6]));
  OBUF \data_out_OBUF[7]_inst 
       (.I(1'b0),
        .O(data_out[7]));
  OBUF \data_out_OBUF[8]_inst 
       (.I(1'b0),
        .O(data_out[8]));
  OBUF \data_out_OBUF[9]_inst 
       (.I(1'b0),
        .O(data_out[9]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
