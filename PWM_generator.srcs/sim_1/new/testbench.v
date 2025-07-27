`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2025 01:56:20
// Design Name: 
// Module Name: testbench
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


module testbench;

    logic        clk;
    logic        reset_n;
    logic        enable;
    logic [15:0] PERIOD;
    logic [15:0] DUTY_CYCLE;
    logic [7:0]  DEAD_TIME;
    logic        pwm_high;
    logic        pwm_low;

   
    pwm_generator dut (.*);

    
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    
    initial begin
        reset_n    = 1'b0;
        enable     = 1'b0;
        PERIOD     = 1000; 
        DUTY_CYCLE = 250;  
        DEAD_TIME  = 10;   
        
        #20;
        reset_n = 1'b1;
        #10;
        enable = 1'b1;
        
        #20000; 
        
        DUTY_CYCLE = 750; 
        
        #20000;
        $finish;
    end
    
    
    initial begin
        $monitor("Time=%0t | enable=%b, counter=%d, pwm_high=%b, pwm_low=%b", 
                 $time, enable, dut.counter_reg, pwm_high, pwm_low);
    end

endmodule
