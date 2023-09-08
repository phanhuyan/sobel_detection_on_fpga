`timescale 1ns / 1ps


// those outputs which are assigned in an always block of sobel shoud be changes to reg (such as output reg Done).

module sobel
	#(	parameter width = 8, 			// width is the number of bits per location
		parameter A_depth_bits = 3, 	// depth is the number of locations (2^number of address bits) (need to change)
		parameter GX_depth_bits = 3, 
		parameter GY_depth_bits = 3
	) 
	(
		input clk,										
		input Start,									// myip_v1_0 -> sobel_0.
		output reg Done,									// sobel_0 -> myip_v1_0. Possibly reg.
		
		output reg A_read_en,  								// sobel_0 -> A_RAM. Possibly reg.
		output reg [A_depth_bits-1:0] A_read_address, 		// sobel_0 -> A_RAM. Possibly reg.
		input [width-1:0] A_read_data_out,				// A_RAM -> sobel_0.
		
		output reg GX_write_en, 							// sobel_0 -> GX_RAM. Possibly reg.
		output reg [GX_depth_bits-1:0] GX_write_address, 	// sobel_0 -> GX_RAM. Possibly reg.
		output reg [width-1:0] GX_write_data_in, 			// sobel_0 -> GX_RAM. Possibly reg.

		output reg GY_write_en, 							// sobel_0 -> GX_RAM. Possibly reg.
		output reg [GY_depth_bits-1:0] GY_write_address, 	// sobel_0 -> GX_RAM. Possibly reg.
		output reg[width-1:0] GY_write_data_in 			// sobel_0 -> GX_RAM. Possibly reg.
	);
	
	// implement the logic to read A_RAM, do the sobel operation and write the results to GX_RAM, GY RAM
	// Note: A_RAM are to be read synchronously.							
    localparam Idle  = 4'b1000;
    localparam Read_Inputs = 4'b0100;
    localparam Compute = 4'b0010;		// currently unused, but needed for our project
    localparam Write_Outputs  = 4'b0001;
    reg [width-1:0] A_read_data;
    reg [width-1:0] GX_temp = 0, GY_temp = 0;
    reg [A_depth_bits-1:0]address = 0;
    reg [3:0] state;
    integer nr_of_reads;
    integer nr_of_writes;
    reg i_pixel_data_valid;
    reg [71:0] i_pixel_data;
   // Accumulator to hold sum of inputs read at any point in time

    // dummy code. Change as appropriate.

    always @(posedge clk)
    begin

      /****** Synchronous reset (active low) ******/
      if (Start == 1)
        begin
           // CAUTION: make sure your reset polarity is consistent with the
           // system reset polarity
           state <= Idle;

        end
      /************** state machine **************/
      else
        case (state)

          Idle:
            begin
              if(address == 15876) begin
                Done <= 1;
              end  
              state       <= Read_Inputs;
              nr_of_reads <= 9;
              A_read_address <= address;
              A_read_en <= 1;
              Done <= 0;
            end

          Read_Inputs:
            begin
              // --- Coprocessor function happens below --- //
              
              // --- Coprocessor function happens above --- //
            if (nr_of_reads == 9) begin
                i_pixel_data[0:7] <= A_read_data_out;
                A_read_address <= A_read_address + 1;
                end
            if (nr_of_reads == 8) begin
                i_pixel_data[8:15] <= A_read_data_out;
                A_read_address <= A_read_address + 1;
                end
            if (nr_of_reads == 7) begin
                i_pixel_data[16:23] <= A_read_data_out;
                A_read_address <= A_read_address + 126;
                end
            if (nr_of_reads == 6) begin
                i_pixel_data[24:31] <= A_read_data_out;
                A_read_address <= A_read_address + 1;
                end 
            if (nr_of_reads == 5) begin
                i_pixel_data[32:39] <= A_read_data_out;
                A_read_address <= A_read_address + 1;
                end
            if (nr_of_reads == 4) begin
                i_pixel_data[40:47] <= A_read_data_out;
                A_read_address <= A_read_address + 126;
                end
            if (nr_of_reads == 3) begin
                i_pixel_data[48:55] <= A_read_data_out;
                A_read_address <= A_read_address + 1;
                end
            if (nr_of_reads == 2) begin
                 i_pixel_data[56:63] <= A_read_data_out;
                 A_read_address <= A_read_address + 1;
                 end
            if (nr_of_reads == 1) begin
                 i_pixel_data[64:71] <= A_read_data_out;
                 end
            if (nr_of_reads == 0)
                begin
                  state        <= Compute;
                  nr_of_writes <= 1;
                  A_read_en <= 0;
                  i_pixel_data_valid <= 1;
                end
             nr_of_reads <= nr_of_reads -1;          
            end
            
          Compute:
          if (convolved_data_valid == 1)
          begin
           state <= Write_Outputs;
           i_pixel_data_valid <= 0;
           GX_write_en <= 1;
           GX_write_address <= address;
           GY_write_en <= 1;
           GY_write_address <= address;
          end
				
          Write_Outputs:
            begin
              if (nr_of_writes == 0) 
              begin
                 state <= Idle;
                 A_read_en <= 0;
                 GX_write_en <= 0;
                 GY_write_en <= 0;
                 address <= address + 1;
              end
              else
                 GX_write_data_in = GX;
                 GY_write_data_in = GY;
                 nr_of_writes <= nr_of_writes - 1;
            end
        endcase
   end

	 // dummy code. Change as appropriate
 conv conv(
     .i_clk(clk),
     .i_pixel_data(pixel_data),
     .i_pixel_data_valid(pixel_data_valid),
     .GX(GX),
     .GY(GY),
     .o_convolved_data(convolved_data),
     .o_convolved_data_valid(convolved_data_valid)
 ); 

endmodule


