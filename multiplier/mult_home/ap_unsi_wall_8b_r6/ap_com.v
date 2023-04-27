module ap_com_4_index_0(
	input wire a,
	input wire b,
	input wire c,
	input wire d,
	output reg y
);

always @(*) begin
	case({a, b, c, d})
		4'b0000: y = 0;
		4'b0001: y = 0;
		4'b0010: y = 1;
		4'b0011: y = 1;
		4'b0100: y = 0;
		4'b0101: y = 1;
		4'b0110: y = 1;
		4'b0111: y = 1;
		4'b1000: y = 0;
		4'b1001: y = 0;
		4'b1010: y = 1;
		4'b1011: y = 1;
		4'b1100: y = 1;
		4'b1101: y = 1;
		4'b1110: y = 1;
		4'b1111: y = 1;
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
		2'b00: y = 0;
		2'b01: y = 1;
		2'b10: y = 0;
		2'b11: y = 1;
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
		2'b00: y = 0;
		2'b01: y = 0;
		2'b10: y = 0;
		2'b11: y = 0;
		default:;
	endcase
end

endmodule


module ap_com_4_index_3(
	input wire a,
	input wire b,
	input wire c,
	input wire d,
	output reg y
);

always @(*) begin
	case({a, b, c, d})
		4'b0000: y = 1;
		4'b0001: y = 1;
		4'b0010: y = 1;
		4'b0011: y = 1;
		4'b0100: y = 0;
		4'b0101: y = 0;
		4'b0110: y = 1;
		4'b0111: y = 1;
		4'b1000: y = 1;
		4'b1001: y = 1;
		4'b1010: y = 1;
		4'b1011: y = 1;
		4'b1100: y = 0;
		4'b1101: y = 0;
		4'b1110: y = 1;
		4'b1111: y = 0;
		default:;
	endcase
end

endmodule


module ap_com_2_index_4(
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


module ap_com_4_index_5(
	input wire a,
	input wire b,
	input wire c,
	input wire d,
	output reg y
);

always @(*) begin
	case({a, b, c, d})
		4'b0000: y = 1;
		4'b0001: y = 1;
		4'b0010: y = 1;
		4'b0011: y = 1;
		4'b0100: y = 1;
		4'b0101: y = 1;
		4'b0110: y = 1;
		4'b0111: y = 1;
		4'b1000: y = 0;
		4'b1001: y = 1;
		4'b1010: y = 0;
		4'b1011: y = 1;
		4'b1100: y = 0;
		4'b1101: y = 1;
		4'b1110: y = 0;
		4'b1111: y = 1;
		default:;
	endcase
end

endmodule


module ap_com_4_index_6(
	input wire a,
	input wire b,
	input wire c,
	input wire d,
	output reg y
);

always @(*) begin
	case({a, b, c, d})
		4'b0000: y = 0;
		4'b0001: y = 0;
		4'b0010: y = 0;
		4'b0011: y = 0;
		4'b0100: y = 1;
		4'b0101: y = 1;
		4'b0110: y = 1;
		4'b0111: y = 1;
		4'b1000: y = 0;
		4'b1001: y = 0;
		4'b1010: y = 0;
		4'b1011: y = 0;
		4'b1100: y = 1;
		4'b1101: y = 1;
		4'b1110: y = 1;
		4'b1111: y = 1;
		default:;
	endcase
end

endmodule


module ap_com_3_index_7(
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


module ap_com_2_index_8(
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


module ap_com_2_index_9(
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


module ap_com_2_index_10(
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


