//SW[2:0] data inputs
//SW[9] select signal


module Part2(LEDR, SW);
    input [9:0] SW; // 1-4 FIRST DIGIT, 5-8 SECOND DIGIT,0 FIRST CARRY
    output [9:0] LEDR;
    wire WIRE0;
	 wire WIRE1;
	 wire WIRE2;

	 fullAdder bo(
	     .A(SW[1]),
		  .B(SW[5]),
		  .cin(SW[0]),
		  .S(LEDR[0]),
		  .cout(WIRE0)
	 );
	 
	 fullAdder b1(
	     .A(SW[2]),
		  .B(SW[6]),
		  .cin(WIRE0),
		  .S(LEDR[1]),
		  .cout(WIRE1)
	 );
	 
	 fullAdder b2(
	     .A(SW[3]),
		  .B(SW[7]),
		  .cin(WIRE1),
		  .S(LEDR[2]),
		  .cout(WIRE2)
	 );
	 
	 fullAdder b3(
	     .A(SW[4]),
		  .B(SW[8]),
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
