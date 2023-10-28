module mux_9to1(input wire [8:0] data,
                input wire [3:0] select,
           output reg data_out
          );


  always @(*) begin
    casez (select)  
      4'b0001 : data_out = data[0]; 
      4'b0010 : data_out = data[1]; 
      4'b0011 : data_out = data[2];
      4'b0100 : data_out = data[3];
      4'b0101 : data_out = data[4];
      4'b0110 : data_out = data[5]; 
      4'b0111 : data_out = data[6]; 
      4'b1000 : data_out = data[7];
      4'b1001 : data_out = data[8];
      

      default :  data_out = 1'b0;
     endcase  
   end  
  
endmodule
