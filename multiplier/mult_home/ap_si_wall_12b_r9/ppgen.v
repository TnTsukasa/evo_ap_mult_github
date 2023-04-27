// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : rtl/ppgen.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 10:39
// Last Modified : 2023-02-11 10:29
// ---------------------------------------------------------------------------------
// Description   : 
//          using AND gate array generate parital products for 8-bit multiplier
//          using baugh-wooley algorithm, add 2^n and 2^(2n-1) in ppcom
// -FHDR----------------------------------------------------------------------------
module ppgen #(
    parameter DW = 12 
)(
    input  [DW-1:0]    muld,
    input  [DW-1:0]    mulr,
    
    output [DW**2-1:0] pp
);

genvar i;
generate
    for (i = 0; i < DW; i++) begin
        if (i==DW-1) begin
            assign pp[DW*i+:DW] = {{mulr[i] & muld[DW-1]}, ~{{DW-1{mulr[i]}} & muld[DW-2:0]}};
        end
        else begin
            assign pp[DW*i+:DW] = {~{mulr[i] & muld[DW-1]}, {{DW-1{mulr[i]}} & muld[DW-2:0]}};
        end
    end    
endgenerate

endmodule
