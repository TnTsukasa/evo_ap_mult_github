// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : unsi_wall_8b_a.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 14:48
// Last Modified : 2023-02-11 13:06
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// -FHDR----------------------------------------------------------------------------
module ap_si_wall_8b_r4 (
    input  signed [7:0] muld,
    input  signed [7:0] mulr,
    
    output signed [15:0] res
);

wire [63:0] pp;

ppgen #(
    .DW                             ( 8                             ))
U_PPGEN_0(
    .muld                           ( muld                          ),
    .mulr                           ( mulr                          ),
    .pp                             ( pp                            )
);


ppcom U_PPCOM_0(
    .pp                             ( pp                            ),
    .res                            ( res                           )
);


endmodule
