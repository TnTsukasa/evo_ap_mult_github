// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : unsi_wall_8b_a.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 14:48
// Last Modified : 2023-02-09 14:17
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// -FHDR----------------------------------------------------------------------------
module ap_unsi_wall_12b_r9 (
    input  [11:0] muld,
    input  [11:0] mulr,
    
    output [23:0] res
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
