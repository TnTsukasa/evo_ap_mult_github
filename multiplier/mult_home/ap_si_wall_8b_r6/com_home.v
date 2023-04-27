// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : com.v
// Author        : Zeyang peng
// Created On    : 2022-11-10 11:15
// Last Modified : 2022-12-02 15:44
// ---------------------------------------------------------------------------------
// Description   : 
//              compressor home
//
// -FHDR----------------------------------------------------------------------------


module ha (
    input  a,
    input  b,
    output cout,
    output sum
);

`ifdef  ARITH_CELL
    ADDHX1 U0_ADDHX1(.A(a), .B(b), .CO(cout), .S(sum));
`elsif DEF_CELL
    XOR2X1 U0_XOR2X1(.A(a), .B(b), .Y(sum));
    AND2X1 U0_AND2X1(.A(a), .B(b), .Y(cout));
`else 
    assign {cout, sum} = a + b;
`endif

endmodule


module fa (
    input  a,
    input  b,
    input  cin,
    output cout,
    output sum
);

`ifdef ARITH_CELL
    ADDFX1 U0_ADDFX1(.A(a), .B(b), .CI(cin), .CO(cout), .S(sum));
`elsif DEF_CELL
    wire n1, n2, n3;
    XOR3X1 U0_XOR3X1(.A(a), .B(b), .C(cin), .Y(sum));
    XOR2X1 U0_XOR2X1(.A(a), .B(b), .Y(n1));
    AND2X1 U0_AND2X1(.A(n1), .B(cin), .Y(n2));
    AND2X1 U1_AND2X1(.A(a), .B(b), .Y(n3));
    OR2X1  U0_OR2X1 (.A(n2), .B(n3), .Y(cout));
`else
    assign {cout, sum} = a + b + cin;
`endif
    
endmodule



/*
*  42 compressor
*/
module com (
    input  a,
    input  b,
    input  c,
    input  d,
    input  cin,
    output cout,
    output carry,
    output sum
);

`ifdef ARITH_CELL
    CMPR42X1 U0_CMPR42(.A(a), .B(b), .C(c), .D(d), .ICI(cin), .ICO(cout), .CO(carry), .S(sum));
`elsif DEF_CELL
    wire n1, IS, n2;
    XOR2X1 U0_XOR2X1(.A(a), .B(b), .Y(n1));
    XOR2X1 U1_XOR2X1(.A(n1), .B(c), .Y(IS));
    XOR2X1 U2_XOR2X1(.A(IS), .B(d), .Y(n2));
    XOR2X1 U3_XOR2X1(.A(n2), .B(cin), .Y(sum));

    wire n3, n4, n5;
    AND2X1 U0_AND2X1(.A(a), .B(b), .Y(n3));
    AND2X1 U1_AND2X1(.A(a), .B(c), .Y(n4));
    AND2X1 U2_AND2X1(.A(b), .B(c), .Y(n5));
    OR3X1  U0_OR3X1 (.A(n3), .B(n4), .C(n5), .Y(cout));

    wire n6, n7, n8;
    AND2X1 U3_AND2X1(.A(IS), .B(d), .Y(n6));
    AND2X1 U4_AND2X1(.A(IS), .B(cin), .Y(n7));
    AND2X1 U5_AND2X1(.A(d), .B(cin), .Y(n8));
    OR3X1  U1_OR3X1 (.A(n6), .B(n7), .C(n8), .Y(carry));

`else
    wire sum_tmp;
    
    fa U_FA_0(
        .a                              ( a                             ),
        .b                              ( b                             ),
        .cin                            ( c                             ),
        .cout                           ( cout                          ),
        .sum                            ( sum_tmp                       )
    );
    
    fa U_FA_1(
        .a                              ( d                             ),
        .b                              ( sum_tmp                       ),
        .cin                            ( cin                           ),
        .cout                           ( carry                         ),
        .sum                            ( sum                           )
    );
`endif
    
endmodule




