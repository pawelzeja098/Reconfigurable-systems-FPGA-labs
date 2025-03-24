`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2025 16:30:22
// Design Name: 
// Module Name: save_file
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


module save_file(

    input txd
    
);
    integer file;
    reg [7:0] i;
    reg start_flag = 0;
    
    
    always @(posedge txd) begin
        if (txd == 1 && !start_flag) begin
            start_flag = 1;  
        end
    end

    initial begin
        
        file = $fopen("E:/Studia/SystemyKonfig/outputfile_ver", "wb");
        if (file == 0) begin
            $display("B³¹d otwarcia pliku!");
            $finish;
        end
        
        
        $fwrite(file, "To jest wynikada:\n");
        
        for (i = 0; i < 13; i = i + 1) begin
    
            wait(start_flag);
            for (i = 0; i < 10; i = i + 1) begin
                #4; 
   
                if (i == 9) begin
                    #4;
                    $fwrite(file, "%b", txd);
                end
                else begin
                
                    $fwrite(file, "%b", txd);  
                end
              
            end
            #4
            start_flag = 0;
        end
        
        
        // Zamykanie pliku
        $fclose(file);
    end
endmodule
