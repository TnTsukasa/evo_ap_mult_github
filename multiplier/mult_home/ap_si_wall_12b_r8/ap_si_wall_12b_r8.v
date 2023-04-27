// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : unsi_wall_8b_a.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 14:48
// Last Modified : 2023-02-11 13:41
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// -FHDR----------------------------------------------------------------------------
module ap_si_wall_12b_r8 (
    input  signed [11:0] muld,
    input  signed [11:0] mulr,
    
    output signed [23:0] res
);

wire [143:0] pp;

ppgen #(
    .DW                             (  12                           ))
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
