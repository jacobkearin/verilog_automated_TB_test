`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Jacob Kearin
// 
// Create Date: 10/25/2021 02:03:02 PM
// Design Name: 
// Module Name: auto_testbenches
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module adder4bit(
    input [3:0] x,
    input [3:0] y,
    input ci,
    output [3:0] s,
    output co
    );
    assign {co, s} = x + y + ci;
endmodule

module adder4bit_tb;
    // normal testbench instantiation of device under test:
    reg [3:0] x;
    reg [3:0] y;
    reg ci;
    wire [3:0] s;
    wire co;
    adder4bit dut(x, y, ci, s, co);
    
    // Variables for automated testbench
    reg clk;
    integer vectornum, errors;
    reg [13:0] testvectors [999:0];
    reg expected_co;
    reg [3:0] expected_s;

    // Chunk 1: set up testbench clock
    always begin
        clk = 0; #10; clk = 1; #10;
    end

    // Chunk 2: load test vectors, initialize variables
    initial begin
        // file format: xxxx_yyyy_i_o_ssss
        $readmemb("C:/Users/keajacm/Documents/Digital/Lab_7/Lab_7.srcs/sim_1/imports/Digital/testvectors.txt", testvectors);
        vectornum = 0;
        errors = 0;
    end
    
    // Chunk 3: apply next test vector at clock negedge
    always @(negedge clk) begin
        {x, y, ci, expected_co, expected_s} = testvectors[vectornum];
    end

    // Chunk 4: check output, increment vector num, check for end condition
    always @(posedge clk) begin
        // Part A: check output
        if ({co, s} !== {expected_co, expected_s}) begin
            $display("Error! %d + %d + %d -> %d, expecting %d",
                     x, y, ci, {co, s}, {expected_co, expected_s});
            // printf-style formatting:
            // %d = print number as decimal
            // %u = print number as unsigned decimal
            // %x = print number as hexadecimal value
            // %f = print number as floating point
            // %s = print string
            errors = errors + 1;
        end
        
        // Part B: increment vectornum
        vectornum = vectornum + 1;
        
        // Part C: check for end condition
        // int table[10];
        // int x = table[0]; // access first element of table
        // table[3] = 0x23; // access fourth element of table
        if (testvectors[vectornum] === 14'bx) begin
            $display("Done! %d tests completed with %d errors.",
                     vectornum, errors);
            $finish;
        end
    end
endmodule
