`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2025 16:30:09
// Design Name: 
// Module Name: load_file
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


module load_file(
    output reg [7:0] data,  
    output reg send         
);
    integer file;
    
    integer cycle_count; 
    integer i;

    initial begin
         
        send = 0;
        cycle_count = 12;  

        file = $fopen("E:/Studia/SystemyKonfig/inputfile_ver.bin", "rb");
        if (file == 0) begin
            $display("B³¹d otwarcia pliku!");
            $finish;
        end

        for(i=0;i<208 ;i=i+1)
            if (cycle_count == 12) begin
               
                data = $fgetc(file);  
                
                if (data === -1) begin
                   
                    send = 0;
                end else begin
                    send = 1;  
                    #4;  
                    send = 0;  
                end

                cycle_count = 0; 
            end 
            else begin
                #4;  
                cycle_count = cycle_count + 1;
            end
        
        $fclose(file);
        $finish;
    end
endmodule