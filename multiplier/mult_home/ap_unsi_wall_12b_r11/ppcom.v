// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : ppcom_a.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 11:21
// Last Modified : 2023-02-09 13:50
// ---------------------------------------------------------------------------------
// Description   : 
//         approximate compressed tree using n-1 compressor in wallace tree 
//         using feature index is given to approximate compressor name
//
// -FHDR----------------------------------------------------------------------------
module ppcom (
    input  [143:0] pp,
    output [23:0] res
);

// -----------------------------------------------------------
//          arrange 12 parital products in row
// -----------------------------------------------------------
wire [11:0] pps [11:0];
genvar i;
generate
    for (i = 0; i < 12; i++) begin
        assign pps[i][11:0] = pp[12*i+:12];  
    end
endgenerate

// -----------------------------------------------------------
//			            stage 1 compress		
// -----------------------------------------------------------
wire [14:0]  stg1_r0;
wire [12:9]  stg1_r1;
wire [9:8]   stg1_r0_r1_c;

wire [14:0] stg1_r2;
wire [12:5] stg1_r3;
wire [9:4]  stg1_r2_r3_c;

wire [14:0] stg1_r4;
wire [12:1] stg1_r5;
wire [9:0]  stg1_r4_r5_c;

// r0 and r1
// approximate part
assign stg1_r0[0] = pps[0][0];
ap_com_2_index_21  u_ap_com_2_index_21 (.b(pps[0][1]), .a(pps[1][0]), .y(stg1_r0[1]));
ap_com_3_index_20  u_ap_com_3_index_20 (.c(pps[0][2]), .b(pps[1][1]), .a(pps[2][0]), .y(stg1_r0[2]));
ap_com_4_index_19  u_ap_com_4_index_19 (.d(pps[0][3]), .c(pps[1][2]), .b(pps[2][1]), .a(pps[3][0]), .y(stg1_r0[3]));
ap_com_4_index_18  u_ap_com_4_index_18 (.d(pps[0][4]), .c(pps[1][3]), .b(pps[2][2]), .a(pps[3][1]), .y(stg1_r0[4]));
ap_com_4_index_16  u_ap_com_4_index_16 (.d(pps[0][5]), .c(pps[1][4]), .b(pps[2][3]), .a(pps[3][2]), .y(stg1_r0[5]));
ap_com_4_index_14  u_ap_com_4_index_14 (.d(pps[0][6]), .c(pps[1][5]), .b(pps[2][4]), .a(pps[3][3]), .y(stg1_r0[6]));
ap_com_4_index_12  u_ap_com_4_index_12 (.d(pps[0][7]), .c(pps[1][6]), .b(pps[2][5]), .a(pps[3][4]), .y(stg1_r0[7]));
ap_com_4_index_10  u_ap_com_4_index_10 (.d(pps[0][8]), .c(pps[1][7]), .b(pps[2][6]), .a(pps[3][5]), .y(stg1_r0[8]));
ap_com_4_index_7   u_ap_com_4_index_7  (.d(pps[0][9]), .c(pps[1][8]), .b(pps[2][7]), .a(pps[3][6]), .y(stg1_r0[9]));
ap_com_4_index_4   u_ap_com_4_index_4  (.d(pps[0][10]),.c(pps[1][9]), .b(pps[2][8]), .a(pps[3][7]), .y(stg1_r0[10]));
ap_com_4_index_0   u_ap_com_4_index_0  (.d(pps[0][10]),.c(pps[1][9]), .b(pps[2][8]), .a(pps[3][7]), .y(stg1_r1[9]));

// accurate part
com u_stg1_r0_r1_8_com(.a(pps[0][11]), .b(pps[1][10]), .c(pps[2][9]),  .d(pps[3][8]), .cin(1'b0),            .cout(stg1_r0_r1_c[8]), .carry(stg1_r1[10]), .sum(stg1_r0[11]));
com u_stg1_r0_r1_9_com(.a(1'b0),       .b(pps[1][11]), .c(pps[2][10]), .d(pps[3][9]), .cin(stg1_r0_r1_c[8]), .cout(stg1_r0_r1_c[9]), .carry(stg1_r1[11]), .sum(stg1_r0[12]));
fa  u_stg1_r0_r1_1_fa (.a(pps[2][11]), .b(pps[3][10]), .cin(stg1_r0_r1_c[9]), .cout(stg1_r1[12]), .sum(stg1_r0[13]));
assign stg1_r0[14] = pps[3][11];


// r2 and r3
// approximate part
assign stg1_r2[0] = pps[4][0];
ap_com_2_index_17  u_ap_com_2_index_17 (.b(pps[4][1]), .a(pps[5][0]), .y(stg1_r2[1]));
ap_com_3_index_15  u_ap_com_3_index_15 (.c(pps[4][2]), .b(pps[5][1]), .a(pps[6][0]), .y(stg1_r2[2]));
ap_com_4_index_13  u_ap_com_4_index_13 (.d(pps[4][3]), .c(pps[5][2]), .b(pps[6][1]), .a(pps[7][0]), .y(stg1_r2[3]));
ap_com_4_index_11  u_ap_com_4_index_11 (.d(pps[4][4]), .c(pps[5][3]), .b(pps[6][2]), .a(pps[7][1]), .y(stg1_r2[4]));
ap_com_4_index_8   u_ap_com_4_index_8  (.d(pps[4][5]), .c(pps[5][4]), .b(pps[6][3]), .a(pps[7][2]), .y(stg1_r2[5]));
ap_com_4_index_5   u_ap_com_4_index_5  (.d(pps[4][6]), .c(pps[5][5]), .b(pps[6][4]), .a(pps[7][3]), .y(stg1_r2[6]));
ap_com_4_index_1   u_ap_com_4_index_1  (.d(pps[4][6]), .c(pps[5][5]), .b(pps[6][4]), .a(pps[7][3]), .y(stg1_r3[5]));

// accurate part
com u_stg1_r2_r3_4_com(.a(pps[4][7]),  .b(pps[5][6]),  .c(pps[6][5]),  .d(pps[7][4]), .cin(1'b0),            .cout(stg1_r2_r3_c[4]), .carry(stg1_r3[6]),  .sum(stg1_r2[7]));
com u_stg1_r2_r3_5_com(.a(pps[4][8]),  .b(pps[5][7]),  .c(pps[6][6]),  .d(pps[7][5]), .cin(stg1_r2_r3_c[4]), .cout(stg1_r2_r3_c[5]), .carry(stg1_r3[7]),  .sum(stg1_r2[8]));
com u_stg1_r2_r3_6_com(.a(pps[4][9]),  .b(pps[5][8]),  .c(pps[6][7]),  .d(pps[7][6]), .cin(stg1_r2_r3_c[5]), .cout(stg1_r2_r3_c[6]), .carry(stg1_r3[8]),  .sum(stg1_r2[9]));
com u_stg1_r2_r3_7_com(.a(pps[4][10]), .b(pps[5][9]),  .c(pps[6][8]),  .d(pps[7][7]), .cin(stg1_r2_r3_c[6]), .cout(stg1_r2_r3_c[7]), .carry(stg1_r3[9]),  .sum(stg1_r2[10]));
com u_stg1_r2_r3_8_com(.a(pps[4][11]), .b(pps[5][10]), .c(pps[6][9]),  .d(pps[7][8]), .cin(stg1_r2_r3_c[7]), .cout(stg1_r2_r3_c[8]), .carry(stg1_r3[10]), .sum(stg1_r2[11]));
com u_stg1_r2_r3_9_com(.a(1'b0),       .b(pps[5][11]), .c(pps[6][10]), .d(pps[7][9]), .cin(stg1_r2_r3_c[8]), .cout(stg1_r2_r3_c[9]), .carry(stg1_r3[11]), .sum(stg1_r2[12]));
fa  u_stg1_r2_r3_1_fa (.a(pps[6][11]), .b(pps[7][10]), .cin(stg1_r2_r3_c[9]), .cout(stg1_r3[12]), .sum(stg1_r2[13]));
assign stg1_r2[14] = pps[7][11];



// r4 and r5
// approximate part
assign stg1_r4[0] = pps[8][0];
ap_com_2_index_9  u_ap_com_2_index_9 (.b(pps[8][1]), .a(pps[9][0]),  .y(stg1_r4[1]));
ap_com_3_index_6  u_ap_com_3_index_6 (.c(pps[8][2]), .b(pps[9][1]),  .a(pps[10][0]), .y(stg1_r4[2]));
ap_com_3_index_2  u_ap_com_3_index_2 (.c(pps[8][2]), .b(pps[9][1]),  .a(pps[10][0]), .y(stg1_r5[1]));

// accurate part
com u_stg1_r4_r5_0_com(.a(pps[8][3]), .b(pps[9][2]),  .c(pps[10][1]),  .d(pps[11][0]), .cin(1'b0), .cout(stg1_r4_r5_c[0]), .carry(stg1_r5[2]), .sum(stg1_r4[3]));
com u_stg1_r4_r5_1_com(.a(pps[8][4]), .b(pps[9][3]),  .c(pps[10][2]),  .d(pps[11][1]), .cin(stg1_r4_r5_c[0]), .cout(stg1_r4_r5_c[1]), .carry(stg1_r5[3]),  .sum(stg1_r4[4]));
com u_stg1_r4_r5_2_com(.a(pps[8][5]), .b(pps[9][4]),  .c(pps[10][3]),  .d(pps[11][2]), .cin(stg1_r4_r5_c[1]), .cout(stg1_r4_r5_c[2]), .carry(stg1_r5[4]),  .sum(stg1_r4[5]));
com u_stg1_r4_r5_3_com(.a(pps[8][6]), .b(pps[9][5]),  .c(pps[10][4]),  .d(pps[11][3]), .cin(stg1_r4_r5_c[2]), .cout(stg1_r4_r5_c[3]), .carry(stg1_r5[5]),  .sum(stg1_r4[6]));
com u_stg1_r4_r5_4_com(.a(pps[8][7]), .b(pps[9][6]),  .c(pps[10][5]),  .d(pps[11][4]), .cin(stg1_r4_r5_c[3]), .cout(stg1_r4_r5_c[4]), .carry(stg1_r5[6]),  .sum(stg1_r4[7]));
com u_stg1_r4_r5_5_com(.a(pps[8][8]), .b(pps[9][7]),  .c(pps[10][6]),  .d(pps[11][5]), .cin(stg1_r4_r5_c[4]), .cout(stg1_r4_r5_c[5]), .carry(stg1_r5[7]),  .sum(stg1_r4[8]));
com u_stg1_r4_r5_6_com(.a(pps[8][9]), .b(pps[9][8]),  .c(pps[10][7]),  .d(pps[11][6]), .cin(stg1_r4_r5_c[5]), .cout(stg1_r4_r5_c[6]), .carry(stg1_r5[8]),  .sum(stg1_r4[9]));
com u_stg1_r4_r5_7_com(.a(pps[8][10]),.b(pps[9][9]),  .c(pps[10][8]),  .d(pps[11][7]), .cin(stg1_r4_r5_c[6]), .cout(stg1_r4_r5_c[7]), .carry(stg1_r5[9]),  .sum(stg1_r4[10]));
com u_stg1_r4_r5_8_com(.a(pps[8][11]),.b(pps[9][10]), .c(pps[10][9]),  .d(pps[11][8]), .cin(stg1_r4_r5_c[7]), .cout(stg1_r4_r5_c[8]), .carry(stg1_r5[10]), .sum(stg1_r4[11]));
com u_stg1_r4_r5_9_com(.a(1'b0),      .b(pps[9][11]), .c(pps[10][10]), .d(pps[11][9]), .cin(stg1_r4_r5_c[8]), .cout(stg1_r4_r5_c[9]), .carry(stg1_r5[11]), .sum(stg1_r4[12]));
fa  u_stg1_r4_r5_1_fa (.a(pps[10][11]),.b(pps[11][10]), .cin(stg1_r4_r5_c[9]), .cout(stg1_r5[12]), .sum(stg1_r4[13]));
assign stg1_r4[14] = pps[11][11];



// -----------------------------------------------------------
//			            stage 2 compress		
// -----------------------------------------------------------
wire [18:0] stg2_r0;
wire [16:8] stg2_r1;
wire [8:5]  stg2_r0_r1_c;

wire [14:3] stg2_r2;
wire [12:1] stg2_r3;

// r0 and r1
// approximate part
assign stg2_r0[0] = stg1_r0[0];
assign stg2_r0[1] = stg1_r0[1];
assign stg2_r0[2] = stg1_r0[2];
assign stg2_r0[3] = stg1_r0[3];
ap_com_2_index_28 u_ap_com_2_index_28(.b(stg1_r0[4]), .a(stg1_r2[0]),  .y(stg2_r0[4]));
ap_com_2_index_27 u_ap_com_2_index_27(.b(stg1_r0[5]), .a(stg1_r2[1]),  .y(stg2_r0[5]));
ap_com_2_index_26 u_ap_com_2_index_26(.b(stg1_r0[6]), .a(stg1_r2[2]),  .y(stg2_r0[6]));
ap_com_2_index_25 u_ap_com_2_index_25(.b(stg1_r0[7]), .a(stg1_r2[3]),  .y(stg2_r0[7]));
ap_com_3_index_24 u_ap_com_3_index_24(.c(stg1_r0[8]),  .b(stg1_r2[4]), .a(stg1_r4[0]), .y(stg2_r0[8]));
ap_com_3_index_23 u_ap_com_3_index_23(.c(stg1_r0[9]),  .b(stg1_r2[5]), .a(stg1_r4[1]), .y(stg2_r0[9]));
ap_com_3_index_22 u_ap_com_3_index_22(.c(stg1_r0[10]), .b(stg1_r2[6]), .a(stg1_r4[2]), .y(stg2_r0[10]));
ap_com_3_index_3  u_ap_com_3_index_3 (.c(stg1_r0[10]), .b(stg1_r2[6]), .a(stg1_r4[2]), .y(stg2_r1[8]));

// accurate part
com u_stg2_r0_r1_5_com(.a(stg1_r0[11]), .b(stg1_r1[9]),  .c(stg1_r2[7]),  .d(stg1_r3[5]), .cin(1'b0),            .cout(stg2_r0_r1_c[5]), .carry(stg2_r1[9]),  .sum(stg2_r0[11]));
com u_stg2_r0_r1_6_com(.a(stg1_r0[12]), .b(stg1_r1[10]), .c(stg1_r2[8]),  .d(stg1_r3[6]), .cin(stg2_r0_r1_c[5]), .cout(stg2_r0_r1_c[6]), .carry(stg2_r1[10]), .sum(stg2_r0[12]));
com u_stg2_r0_r1_7_com(.a(stg1_r0[13]), .b(stg1_r1[11]), .c(stg1_r2[9]),  .d(stg1_r3[7]), .cin(stg2_r0_r1_c[6]), .cout(stg2_r0_r1_c[7]), .carry(stg2_r1[11]), .sum(stg2_r0[13]));
com u_stg2_r0_r1_8_com(.a(stg1_r0[14]), .b(stg1_r1[12]), .c(stg1_r2[10]), .d(stg1_r3[8]), .cin(stg2_r0_r1_c[7]), .cout(stg2_r0_r1_c[8]), .carry(stg2_r1[12]), .sum(stg2_r0[14]));
fa  u_stg2_r0_r1_2_fa (.a(stg1_r2[11]), .b(stg1_r3[9]),  .cin(stg2_r0_r1_c[8]),  .cout(stg2_r1[13]), .sum(stg2_r0[15]));
ha  u_stg2_r0_r1_2_ha (.a(stg1_r2[12]), .b(stg1_r3[10]), .cout(stg2_r1[14]), .sum(stg2_r0[16]));
ha  u_stg2_r0_r1_3_ha (.a(stg1_r2[13]), .b(stg1_r3[11]), .cout(stg2_r1[15]), .sum(stg2_r0[17]));
ha  u_stg2_r0_r1_4_ha (.a(stg1_r2[14]), .b(stg1_r3[12]), .cout(stg2_r1[16]), .sum(stg2_r0[18]));



// r2 and r3
assign stg2_r2[3]  = stg1_r4[3];
assign stg2_r2[4]  = stg1_r4[4];
assign stg2_r2[5]  = stg1_r4[5];
assign stg2_r2[6]  = stg1_r4[6];
assign stg2_r2[7]  = stg1_r4[7];
assign stg2_r2[8]  = stg1_r4[8];
assign stg2_r2[9]  = stg1_r4[9];
assign stg2_r2[10] = stg1_r4[10];
assign stg2_r2[11] = stg1_r4[11];
assign stg2_r2[12] = stg1_r4[12];
assign stg2_r2[13] = stg1_r4[13];
assign stg2_r2[14] = stg1_r4[14];

assign stg2_r3[1]  = stg1_r5[1];
assign stg2_r3[2]  = stg1_r5[2];
assign stg2_r3[3]  = stg1_r5[3];
assign stg2_r3[4]  = stg1_r5[4];
assign stg2_r3[5]  = stg1_r5[5];
assign stg2_r3[6]  = stg1_r5[6];
assign stg2_r3[7]  = stg1_r5[7];
assign stg2_r3[8]  = stg1_r5[8];
assign stg2_r3[9]  = stg1_r5[9];
assign stg2_r3[10] = stg1_r5[10];
assign stg2_r3[11] = stg1_r5[11];
assign stg2_r3[12] = stg1_r5[12];

// -----------------------------------------------------------
//			            stage 3 compress		
// -----------------------------------------------------------
wire [22:0] stg3_r0;
wire [19:8] stg3_r1;
wire [9:1]  stg3_r0_r1_c;

assign stg3_r0[0] = stg2_r0[0];
assign stg3_r0[1] = stg2_r0[1];
assign stg3_r0[2] = stg2_r0[2];
assign stg3_r0[3] = stg2_r0[3];
assign stg3_r0[4] = stg2_r0[4];
assign stg3_r0[5] = stg2_r0[5];
assign stg3_r0[6] = stg2_r0[6];
assign stg3_r0[7] = stg2_r0[7];
assign stg3_r0[8] = stg2_r0[8];
assign stg3_r0[9] = stg2_r0[9];
assign stg3_r0[10] = stg2_r0[10];


com u_stg3_r0_r1_1_com(.a(stg2_r0[11]), .b(stg2_r1[8]),  .c(stg2_r2[3]),  .d(stg2_r3[1]), .cin(1'b0),            .cout(stg3_r0_r1_c[1]), .carry(stg3_r1[8]),  .sum(stg3_r0[11]));
com u_stg3_r0_r1_2_com(.a(stg2_r0[12]), .b(stg2_r1[9]),  .c(stg2_r2[4]),  .d(stg2_r3[2]), .cin(stg3_r0_r1_c[1]), .cout(stg3_r0_r1_c[2]), .carry(stg3_r1[9]),  .sum(stg3_r0[12]));
com u_stg3_r0_r1_3_com(.a(stg2_r0[13]), .b(stg2_r1[10]), .c(stg2_r2[5]),  .d(stg2_r3[3]), .cin(stg3_r0_r1_c[2]), .cout(stg3_r0_r1_c[3]), .carry(stg3_r1[10]), .sum(stg3_r0[13]));
com u_stg3_r0_r1_4_com(.a(stg2_r0[14]), .b(stg2_r1[11]), .c(stg2_r2[6]),  .d(stg2_r3[4]), .cin(stg3_r0_r1_c[3]), .cout(stg3_r0_r1_c[4]), .carry(stg3_r1[11]), .sum(stg3_r0[14]));
com u_stg3_r0_r1_5_com(.a(stg2_r0[15]), .b(stg2_r1[12]), .c(stg2_r2[7]),  .d(stg2_r3[5]), .cin(stg3_r0_r1_c[4]), .cout(stg3_r0_r1_c[5]), .carry(stg3_r1[12]), .sum(stg3_r0[15]));
com u_stg3_r0_r1_6_com(.a(stg2_r0[16]), .b(stg2_r1[13]), .c(stg2_r2[8]),  .d(stg2_r3[6]), .cin(stg3_r0_r1_c[5]), .cout(stg3_r0_r1_c[6]), .carry(stg3_r1[13]), .sum(stg3_r0[16]));
com u_stg3_r0_r1_7_com(.a(stg2_r0[17]), .b(stg2_r1[14]), .c(stg2_r2[9]),  .d(stg2_r3[7]), .cin(stg3_r0_r1_c[6]), .cout(stg3_r0_r1_c[7]), .carry(stg3_r1[14]), .sum(stg3_r0[17]));
com u_stg3_r0_r1_8_com(.a(stg2_r0[18]), .b(stg2_r1[15]), .c(stg2_r2[10]), .d(stg2_r3[8]), .cin(stg3_r0_r1_c[7]), .cout(stg3_r0_r1_c[8]), .carry(stg3_r1[15]), .sum(stg3_r0[18]));
com u_stg3_r0_r1_9_com(.a(1'b0),        .b(stg2_r1[16]), .c(stg2_r2[11]), .d(stg2_r3[9]), .cin(stg3_r0_r1_c[8]), .cout(stg3_r0_r1_c[9]), .carry(stg3_r1[16]), .sum(stg3_r0[19]));
fa  u_stg3_r0_r1_2_fa (.a(stg2_r2[12]), .b(stg2_r3[10]), .cin(stg3_r0_r1_c[9]),  .cout(stg3_r1[17]), .sum(stg3_r0[20]));
ha  u_stg3_r0_r1_5_ha (.a(stg2_r2[13]), .b(stg2_r3[11]),  .cout(stg3_r1[18]), .sum(stg3_r0[21]));
ha  u_stg3_r0_r1_6_ha (.a(stg2_r2[14]), .b(stg2_r3[12]),  .cout(stg3_r1[19]), .sum(stg3_r0[22]));


// -----------------------------------------------------------
//			            final stage adder		
// -----------------------------------------------------------

assign res = {1'b0, stg3_r0} + {stg3_r1, 12'b0};

endmodule
