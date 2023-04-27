// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : ppcom_a.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 11:21
// Last Modified : 2023-02-11 12:59
// ---------------------------------------------------------------------------------
// Description   : 
//       
//
// -FHDR----------------------------------------------------------------------------
module ppcom (
    input  [63:0] pp,
    output [15:0] res
);

// -----------------------------------------------------------
//          arrange 64 parital products in row
// -----------------------------------------------------------
wire [7:0] pps [7:0];
genvar i;
generate
    for (i = 0; i < 8; i++) begin
        assign pps[i][7:0] = pp[8*i+:8];  
    end
endgenerate

wire si_ex_n = 1'b1;
wire si_ex_2n1 = 1'b1;

// -----------------------------------------------------------
//			            stage 1 compress		
// -----------------------------------------------------------
wire [10:0] stg1_r0;
wire [8:0]  stg1_r1;
wire [5:0]  stg1_r0_r1_c;

wire [10:0]  stg1_r2;
wire [8:0]  stg1_r3;
wire [5:0]  stg1_r2_r3_c;


// r0 and r1
//approximate
assign stg1_r0[0] = pps[0][0];
ap_com_2_index_8   u_ap_com_2_index_8  (.b(pps[0][1]), .a(pps[1][0]), .y(stg1_r0[1]));
ap_com_3_index_7   u_ap_com_3_index_7  (.c(pps[0][2]), .b(pps[1][1]), .a(pps[2][0]), .y(stg1_r0[2]));
ap_com_4_index_6   u_ap_com_4_index_6  (.d(pps[0][3]), .c(pps[1][2]), .b(pps[2][1]), .a(pps[3][0]), .y(stg1_r0[3]));
ap_com_4_index_5   u_ap_com_r_index_5  (.d(pps[0][4]), .c(pps[1][3]), .b(pps[2][2]), .a(pps[3][1]), .y(stg1_r0[4]));
ap_com_4_index_3   u_ap_com_4_index_3  (.d(pps[0][5]), .c(pps[1][4]), .b(pps[2][3]), .a(pps[3][2]), .y(stg1_r0[5]));
ap_com_4_index_0   u_ap_com_4_index_0  (.d(pps[0][5]), .c(pps[1][4]), .b(pps[2][3]), .a(pps[3][2]), .y(stg1_r1[4]));




//accurate
com u_stg1_3_com(.a(pps[0][6]), .b(pps[1][5]), .c(pps[2][4]), .d(pps[3][3]), .cin(1'b0), .cout(stg1_r0_r1_c[3]), .carry(stg1_r1[5]), .sum(stg1_r0[6]));
com u_stg1_4_com(.a(pps[0][7]), .b(pps[1][6]), .c(pps[2][5]), .d(pps[3][4]), .cin(stg1_r0_r1_c[3]), .cout(stg1_r0_r1_c[4]), .carry(stg1_r1[6]), .sum(stg1_r0[7]));
com u_stg1_5_com(.a(si_ex_n),   .b(pps[1][7]), .c(pps[2][6]), .d(pps[3][5]), .cin(stg1_r0_r1_c[4]), .cout(stg1_r0_r1_c[5]), .carry(stg1_r1[7]), .sum(stg1_r0[8]));
fa  u_stg1_1_fa (.a(pps[2][7]), .b(pps[3][6]), .cin(stg1_r0_r1_c[5]), .cout(stg1_r1[8]), .sum(stg1_r0[9]));
assign stg1_r0[10] = pps[3][7];

// r2 and r3
//approximate
assign stg1_r2[0] = pps[4][0];
ap_com_2_index_4   u_ap_com_2_index_4 (.b(pps[4][1]), .a(pps[5][0]), .y(stg1_r2[1]));
ap_com_2_index_1   u_ap_com_2_index_1 (.b(pps[4][1]), .a(pps[5][0]), .y(stg1_r3[0]));


//accurate
fa  u_stg1_2_fa (.a(pps[4][2]), .b(pps[5][1]), .cin(pps[6][0]), .cout(stg1_r3[1]), .sum(stg1_r2[2]));
com u_stg1_6_com(.a(pps[4][3]), .b(pps[5][2]), .c(pps[6][1]), .d(pps[7][0]), .cin(1'b0), .cout(stg1_r2_r3_c[0]), .carry(stg1_r3[2]), .sum(stg1_r2[3]));
com u_stg1_7_com(.a(pps[4][4]), .b(pps[5][3]), .c(pps[6][2]), .d(pps[7][1]), .cin(stg1_r2_r3_c[0]), .cout(stg1_r2_r3_c[1]), .carry(stg1_r3[3]), .sum(stg1_r2[4]));
com u_stg1_8_com(.a(pps[4][5]), .b(pps[5][4]), .c(pps[6][3]), .d(pps[7][2]), .cin(stg1_r2_r3_c[1]), .cout(stg1_r2_r3_c[2]), .carry(stg1_r3[4]), .sum(stg1_r2[5]));
com u_stg1_9_com(.a(pps[4][6]), .b(pps[5][5]), .c(pps[6][4]), .d(pps[7][3]), .cin(stg1_r2_r3_c[2]), .cout(stg1_r2_r3_c[3]), .carry(stg1_r3[5]), .sum(stg1_r2[6]));
com u_stg1_10_com(.a(pps[4][7]), .b(pps[5][6]), .c(pps[6][5]), .d(pps[7][4]), .cin(stg1_r2_r3_c[3]), .cout(stg1_r2_r3_c[4]), .carry(stg1_r3[6]), .sum(stg1_r2[7]));
com u_stg1_11_com(.a(1'b0),      .b(pps[5][7]), .c(pps[6][6]), .d(pps[7][5]), .cin(stg1_r2_r3_c[4]), .cout(stg1_r2_r3_c[5]), .carry(stg1_r3[7]), .sum(stg1_r2[8]));
fa  u_stg1_3_fa (.a(pps[6][7]), .b(pps[7][6]), .cin(stg1_r2_r3_c[5]), .cout(stg1_r3[8]), .sum(stg1_r2[9]));
assign stg1_r2[10] = pps[7][7];


// -----------------------------------------------------------
//			            stage 2 compress		
// -----------------------------------------------------------
wire [14:0] stg2_r0;
wire [12:0] stg2_r1;
wire [4:0]  stg2_c;

//approximate
assign stg2_r0[0] = stg1_r0[0];
assign stg2_r0[1] = stg1_r0[1];
assign stg2_r0[2] = stg1_r0[2];
assign stg2_r0[3] = stg1_r0[3];
ap_com_2_index_10  u_ap_com_2_index_10 (.b(stg1_r0[4]), .a(stg1_r2[0]), .y(stg2_r0[4]));
ap_com_2_index_9   u_ap_com_2_index_9  (.b(stg1_r0[5]), .a(stg1_r2[1]), .y(stg2_r0[5]));
ap_com_2_index_2   u_ap_com_2_index_2  (.b(stg1_r0[5]), .a(stg1_r2[1]), .y(stg2_r1[3]));


//accurate
com u_stg2_0_com(.a(stg1_r0[6]), .b(stg1_r1[4]), .c(stg1_r2[2]), .d(stg1_r3[0]), .cin(1'b0), .cout(stg2_c[0]), .carry(stg2_r1[4]), .sum(stg2_r0[6]));
com u_stg2_1_com(.a(stg1_r0[7]), .b(stg1_r1[5]), .c(stg1_r2[3]), .d(stg1_r3[1]), .cin(stg2_c[0]), .cout(stg2_c[1]), .carry(stg2_r1[5]), .sum(stg2_r0[7]));
com u_stg2_2_com(.a(stg1_r0[8]), .b(stg1_r1[6]), .c(stg1_r2[4]), .d(stg1_r3[2]), .cin(stg2_c[1]), .cout(stg2_c[2]), .carry(stg2_r1[6]), .sum(stg2_r0[8]));
com u_stg2_3_com(.a(stg1_r0[9]), .b(stg1_r1[7]), .c(stg1_r2[5]), .d(stg1_r3[3]), .cin(stg2_c[2]), .cout(stg2_c[3]), .carry(stg2_r1[7]), .sum(stg2_r0[9]));
com u_stg2_4_com(.a(stg1_r0[10]),.b(stg1_r1[8]), .c(stg1_r2[6]), .d(stg1_r3[4]), .cin(stg2_c[3]), .cout(stg2_c[4]), .carry(stg2_r1[8]), .sum(stg2_r0[10]));
fa  u_stg2_2_fa (.a(stg1_r2[7]), .b(stg1_r3[5]), .cin(stg2_c[4]), .cout(stg2_r1[9]), .sum(stg2_r0[11]));
ha  u_stg2_2_ha (.a(stg1_r2[8]), .b(stg1_r3[6]), .cout(stg2_r1[10]), .sum(stg2_r0[12]));
ha  u_stg2_3_ha (.a(stg1_r2[9]), .b(stg1_r3[7]), .cout(stg2_r1[11]), .sum(stg2_r0[13]));
ha  u_stg2_4_ha (.a(stg1_r2[10]),.b(stg1_r3[8]), .cout(stg2_r1[12]), .sum(stg2_r0[14]));


// -----------------------------------------------------------
//			            final stage adder		
// -----------------------------------------------------------

assign res = {si_ex_2n1, stg2_r0[14:0]} + {stg2_r1[12:3], 6'b0};




endmodule
