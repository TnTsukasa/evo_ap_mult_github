module ap_com_2_index_0(
	input wire a,
	input wire b,
	output reg y
);

always @(*) begin
	case({a, b})
		2'b00: y = 0;
		2'b01: y = 0;
		2'b10: y = 0;
		2'b11: y = 0;
		default:;
	endcase
end

endmodule


module ap_com_2_index_1(
	input wire a,
	input wire b,
	output reg y
);

always @(*) begin
	case({a, b})
		2'b00: y = 1;
		2'b01: y = 1;
		2'b10: y = 1;
		2'b11: y = 1;
		default:;
	endcase
end

endmodule


