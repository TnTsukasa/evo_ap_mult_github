// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : unsi_wall_8b_a.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 14:48
// Last Modified : 2022-11-23 17:55
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// -FHDR----------------------------------------------------------------------------
module ap_unsi_wall_8b_r8 (
    input  [7:0] muld,
    input  [7:0] mulr,
    
    output [15:0] res
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
