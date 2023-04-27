module ap_com_3_index_0(
	input wire a,
	input wire b,
	input wire c,
	output reg y
);

always @(*) begin
	case({a, b, c})
		3'b000: y = 0;
		3'b001: y = 0;
		3'b010: y = 1;
		3'b011: y = 1;
		3'b100: y = 0;
		3'b101: y = 0;
		3'b110: y = 1;
		3'b111: y = 1;
		default:;
	endcase
end

endmodule


module ap_com_3_index_1(
	input wire a,
	input wire b,
	input wire c,
	output reg y
);

always @(*) begin
	case({a, b, c})
		3'b000: y = 0;
		3'b001: y = 0;
		3'b010: y = 0;
		3'b011: y = 0;
		3'b100: y = 0;
		3'b101: y = 0;
		3'b110: y = 0;
		3'b111: y = 0;
		default:;
	endcase
end

endmodule


module ap_com_2_index_2(
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


