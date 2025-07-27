`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2025 01:52:06
// Design Name: 
// Module Name: pwm_generator
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


module pwm_generator (
    input  logic        clk,
    input  logic        reset_n,
    input  logic        enable,
    input  logic [15:0] PERIOD,
    input  logic [15:0] DUTY_CYCLE,
    input  logic [7:0]  DEAD_TIME,
    output logic        pwm_high,
    output logic        pwm_low
);

    logic [15:0] counter_reg;

    
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter_reg <= 16'b0;
        end else if (enable) begin
            
            if (counter_reg >= PERIOD) begin
                counter_reg <= 16'b0;
            end else begin
                counter_reg <= counter_reg + 1;
            end
        end else begin
            counter_reg <= 16'b0;
        end
    end

    
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            pwm_high <= 1'b0;
            pwm_low  <= 1'b0;
        end else if (enable) begin
            
            if (counter_reg == 0) begin
                pwm_high <= 1'b1;
                pwm_low  <= 1'b0;
            
            end else if (counter_reg == DUTY_CYCLE) begin
                pwm_high <= 1'b0;
            
            end else if (counter_reg == (DUTY_CYCLE + DEAD_TIME)) begin
                pwm_low <= 1'b1;
            end
        end else begin
            
            pwm_high <= 1'b0;
            pwm_low  <= 1'b0;
        end
    end

endmodule