// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : rtl/ppgen.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 10:39
// Last Modified : 2022-11-10 11:14
// ---------------------------------------------------------------------------------
// Description   : 
//          using AND gate array generate parital products for 8-bit multiplier
//
// -FHDR----------------------------------------------------------------------------
module ppgen #(
    parameter DW = 8
)(
    input  [DW-1:0]    muld,
    input  [DW-1:0]    mulr,
    
    output [DW**2-1:0] pp
);

genvar i;
generate
    for (i = 0; i < 8; i++) begin
        assign pp[DW*i+:DW] = {DW{mulr[i]}} & muld[DW-1:0];
    end    
endgenerate

endmodule
