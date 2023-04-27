// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : unsi_wall_8b_a.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 14:48
// Last Modified : 2023-02-08 19:24
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// -FHDR----------------------------------------------------------------------------
module ap_unsi_wall_4b_r2 (
    input  [3:0] muld,
    input  [3:0] mulr,
    
    output [7:0] res
);

wire [15:0] pp;

ppgen #(
    .DW                             ( 4                             ))
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
