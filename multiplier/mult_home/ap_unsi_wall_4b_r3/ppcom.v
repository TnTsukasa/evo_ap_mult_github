// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : ppcom_a.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 11:21
// Last Modified : 2023-02-08 17:07
// ---------------------------------------------------------------------------------
// Description   : 
//         approximate compressed tree using n-1 compressor in wallace tree 
//         using feature index is given to approximate compressor name
//
// -FHDR----------------------------------------------------------------------------
module ppcom (
    input  [15:0] pp,
    output [7:0] res
);

// -----------------------------------------------------------
//          arrange 16 parital products in row
// -----------------------------------------------------------
wire [3:0] pps [3:0];
genvar i;
generate
    for (i = 0; i < 4; i++) begin
        assign pps[i][3:0] = pp[4*i+:4];  
    end
endgenerate

// -----------------------------------------------------------
//			            stage 1 compress		
// -----------------------------------------------------------
wire [6:0] stg1_r0;
wire [4:1] stg1_r1;
wire [1:0] stg1_r0_r1_c;

// r0 and r1
assign stg1_r0[0] = pps[0][0];
ap_com_2_index_2  u_com_2_index_2 (.b(pps[0][1]), .a(pps[1][0]), .y(stg1_r0[1]));
ap_com_3_index_1  u_com_3_index_1 (.c(pps[0][2]), .b(pps[1][1]), .a(pps[2][0]), .y(stg1_r0[2]));
ap_com_3_index_0  u_com_3_index_0 (.c(pps[0][2]), .b(pps[1][1]), .a(pps[2][0]), .y(stg1_r1[1]));

com u_stg1_0_com(.a(pps[0][3]), .b(pps[1][2]), .c(pps[2][1]), .d(pps[3][0]), .cin(1'b0), .cout(stg1_r0_r1_c[0]), .carry(stg1_r1[2]), .sum(stg1_r0[3]));
com u_stg1_1_com(.a(1'b0), .b(pps[1][3]), .c(pps[2][2]), .d(pps[3][1]), .cin(stg1_r0_r1_c[0]), .cout(stg1_r0_r1_c[1]), .carry(stg1_r1[3]), .sum(stg1_r0[4]));
fa  u_stg1_1_fa (.a(pps[2][3]), .b(pps[3][2]), .cin(stg1_r0_r1_c[1]), .cout(stg1_r1[4]), .sum(stg1_r0[5]));
assign stg1_r0[6] = pps[3][3];

// -----------------------------------------------------------
//			            final stage adder		
// -----------------------------------------------------------

assign res = stg1_r0 + {stg1_r1, 3'b0};

endmodule
