module Part3 (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input [7:0] SW;
	 input [2:0] KEY;
	 output [7:0] LEDR;
	 output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 
	 reg [7:0] ALUout;
	 wire WIRE2, WIRE3, WIRE4, WIRE5, WIRE6;
	 wire [7:0] WIRE0, WIRE1;
	 
	 AddOne a(
	     .LEDR(WIRE0),
		  .SW(SW)
	 );
	 
	 Adder b(
	     .LEDR(WIRE1),
		  .SW(SW)
	 );
	 
	 always @(*)
	 begin
		case(KEY[2:0])
			3'b000: ALUout = WIRE0;
			3'b001: ALUout = WIRE1;
			3'b010: ALUout = {4'b0000, SW[7:4] + SW[3:0]};
			3'b011: ALUout = {SW[7:4] | SW[3:0], SW[7:4] ^ SW[3:0]};
			3'b100: ALUout = {7'b0000000, SW[7] | SW[6] | SW[5] | SW[4] | SW[3] | SW[2] | SW[1] | SW[0]};
			3'b101: ALUout = {SW[7:4], SW[3:0]};
			default: ALUout = 8'b00000000;
		endcase
    end
    assign LEDR = ALUout;
	 
	 seven_seg_decoder B(
	     .SW(SW[3:0]),
		  .HEX(HEX0[6:0])
	 );
	 
	 seven_seg_decoder A(
	     .SW(SW[7:4]),
		  .HEX(HEX2[6:0])
	 );
	 
	 seven_seg_decoder h1(
	     .SW(4'b0000),
		  .HEX(HEX1[6:0])
	 );
	 
	 seven_seg_decoder h2(
	     .SW(4'b0000),
		  .HEX(HEX3[6:0])
	 );
	 
	 seven_seg_decoder out1(
	     .SW(ALUout[3:0]),
		  .HEX(HEX4[6:0])
	 );
	 
	 seven_seg_decoder out2(
	     .SW(ALUout[7:4]),
		  .HEX(HEX5[6:0])
	 );
	 
	 
	 
	 
endmodule

module AddOne(LEDR, SW);
    input [7:0] SW; // 1-4 FIRST DIGIT, 5-8 SECOND DIGIT,0 FIRST CARRY
    output [7:0] LEDR;
    wire WIRE0;
         wire WIRE1;
         wire WIRE2;

         fullAdder bo(
             .A(SW[0]),
                  .B(1'b1),
                  .cin(1'b0),
                  .S(LEDR[0]),
                  .cout(WIRE0)
         );

         fullAdder b1(
             .A(SW[1]),
                  .B(1'b0),
                  .cin(WIRE0),
                  .S(LEDR[1]),
                  .cout(WIRE1)
         );

         fullAdder b2(
             .A(SW[2]),
                  .B(1'b0),
                  .cin(WIRE1),
                  .S(LEDR[2]),
                  .cout(WIRE2)
         );

         fullAdder b3(
             .A(SW[3]),
                  .B(1'b0),
                  .cin(WIRE2),
                  .S(LEDR[3]),
                  .cout(LEDR[4])
         );

         assign LEDR[5] = 1'b0;
         assign LEDR[6] = 1'b0;
         assign LEDR[7] = 1'b0;


endmodule


module Adder(LEDR, SW);
    input [7:0] SW; // 1-4 FIRST DIGIT, 5-8 SECOND DIGIT,0 FIRST CARRY
    output [7:0] LEDR;
    wire WIRE0;
         wire WIRE1;
         wire WIRE2;

         fullAdder bo(
             .A(SW[0]),
                  .B(SW[4]),
                  .cin(1'b0),
                  .S(LEDR[0]),
                  .cout(WIRE0)
         );

         fullAdder b1(
             .A(SW[1]),
                  .B(SW[5]),
                  .cin(WIRE0),
                  .S(LEDR[1]),
                  .cout(WIRE1)
         );

         fullAdder b2(
             .A(SW[2]),
                  .B(SW[6]),
                  .cin(WIRE1),
                  .S(LEDR[2]),
                  .cout(WIRE2)
         );

         fullAdder b3(
             .A(SW[3]),
                  .B(SW[7]),
                  .cin(WIRE2),
                  .S(LEDR[3]),
                  .cout(LEDR[4])
         );

         assign LEDR[5] = 1'b0;
         assign LEDR[6] = 1'b0;
         assign LEDR[7] = 1'b0;
endmodule

module fullAdder(A, B, cin, S, cout);
    input A; // bits to add
    input B;
    input cin; // carry value
         output cout; // carry out
    output S; //output value

    assign S = A ^ B^ cin;
         assign cout = (A&B) | (A&cin) | (B&cin);

endmodule

module seven_seg_decoder(SW, HEX);

    input [3:0] SW;
    output [6:0] HEX;

    assign HEX[0] = (~SW[3]&~SW[2]&~SW[1]&SW[0]) | (~SW[3]&SW[2]&~SW[1]&~SW[0]) | (SW[3]&SW[2]&~SW[1]&SW[0]) | (SW[3]&~SW[2]&SW[1]&SW[0]);
    assign HEX[1] = (SW[3]&SW[2]&~SW[1]&~SW[0]) | (~SW[3]&SW[2]&~SW[1]&SW[0]) | (SW[3]&SW[1]&SW[0]) | (SW[2]&SW[1]&SW[0]) | (SW[3]&SW[2]&SW[1]);
    assign HEX[2] = (SW[3]&SW[2]&~SW[1]&~SW[0]) | (~SW[3]&~SW[2]&SW[1]&~SW[0]) | (SW[3]&SW[2]&SW[1]);
    assign HEX[3] = (~SW[3]&SW[2]&~SW[1]&~SW[0]) | (~SW[3]&~SW[2]&~SW[1]&SW[0]) | (SW[2]&SW[1]&SW[0]) | (SW[3]&~SW[2]&SW[1]&~SW[0]);
    assign HEX[4] = (~SW[3]&SW[0]) | (~SW[3]&SW[2]&~SW[1]) | (~SW[2]&~SW[1]&SW[0]);
    assign HEX[5] = (SW[3]&SW[2]&~SW[1]&SW[0]) | (~SW[3]&SW[1]&SW[0]) | (~SW[3]&~SW[2]&SW[0]) | (~SW[3]&~SW[2]&SW[1]);
    assign HEX[6] = (SW[3]&SW[2]&~SW[1]&~SW[0]) | (~SW[3]&SW[2]&SW[1]&SW[0]) | (~SW[3]&~SW[2]&~SW[1]);

endmodule

