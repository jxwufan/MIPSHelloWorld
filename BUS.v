`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:13:13 06/16/2015 
// Design Name: 
// Module Name:    BUS 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BUS(input mem_w,
			  input [31:0] cpu2bus,
			  input [31:0] cpu_address,
			  input [7:0]  vram2bus,
			  input [31:0] ram2bus,
			  output reg ram_w,
			  output reg vram_w,
			  output reg [31:0] bus2cpu,
			  output reg [31:0] bus2ram,
			  output reg [7:0]  bus2vram,
			  output wire [11:0] ram_address,
			  output wire [15:0] vram_address
    );
	 
	assign ram_address = cpu_address[13:2];
	assign vram_address = cpu_address[15:0];

	always @* begin
		ram_w = 0;
		vram_w = 0;
		bus2cpu = 0;
		bus2ram = 0;
		bus2vram = 0;
		if (cpu_address[31:14] == 0) begin
			ram_w = mem_w;
			bus2ram = cpu2bus;
			bus2cpu = ram2bus;
		end else 
		if (cpu_address[31:16] == 16'hf000) begin
			vram_w = mem_w;
			bus2vram = cpu2bus[7:0];
			bus2cpu = {{24{0}}, vram2bus};
		end
	end

endmodule
