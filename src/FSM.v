/*
A clock divider in Verilog, using the cascading
flip-flop method.
*/

module FSM(input clk, input reset, input wire ovf, ovf_RTC, output reg a0, a1, a2, a3, SL, out_rst);

  reg [3:0] counter_register;
initial begin
  counter_register = 4'b0;
end
//-- Output is 26-bit bus, initialized at 0
 reg zero, one;
  
  localparam [3:0]
  s0 = 0,
  s1 = 1,
  s2 = 2,
  s3 = 3,
  s4 = 4,
  s5 = 5,
  s6 = 6,
  s7 = 7,
  s8 = 8,
  s9 = 9;
  
  reg[3:0] state_reg, state_next/* synthesis syn_preserve=1 */;

  
  always @(posedge clk or posedge reset) begin
  
    if(reset == 1) begin
      	counter_register <= 4'b0;
    	
    end
    else if (reset == 0 && clk == 1 && (ovf == 1 || ovf_RTC == 1))
      counter_register <= counter_register + 1;
    if(counter_register == 4'b1011) begin
      counter_register <= 4'b0;
      
    end
  end
  always @(posedge clk or posedge reset) begin
  
    if(reset == 1)
      	state_reg <= s0;
    	
    else if (zero == 1 && clk == 1) begin
      if(ovf == 1 || ovf_RTC == 1) begin
      state_reg <= state_next;
      end
      else if (ovf || ovf_RTC == 0)
        state_reg <= s0;
    end
  //  if(state_reg == s5) 
    //  state_reg <= s0;
  end
  
  always @(*) begin
    if(counter_register == 4'b0)
      zero = 1;
    else
      zero = 0;
    if(counter_register == 4'b1)
      SL = 1;
    else
      SL = 0;
    if(counter_register == 4'b1011 && a0 == 0 && a1 == 0 && a2 == 0 && a3 == 1 && ovf_RTC == 1)
      out_rst = 1;
    else
      out_rst = 0;
   
    
  end
  always @(clk, reset, SL, zero) begin 
    state_next = state_reg; // default state_next
    case (state_reg)
        s0 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s1; 
            end
            else begin // remain in current state
                state_next = s0; 
            end
        end
        s1 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s2; 
            end
            else begin // remain in current state
                state_next = s1; 
            end
        end
        s2 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s3; 
            end
            else begin // remain in current state
                state_next = s2; 
            end
        end
      s3 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s4; 
            end
            else begin // remain in current state
                state_next = s3; 
            end
        end
      s4 : begin
        if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s5; 
            end
            else begin // remain in current state
                state_next = s4; 
            end
        end
      s5 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s6; 
            end
            else begin // remain in current state
                state_next = s5; 
            end
        end
       s6 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s7; 
            end
            else begin // remain in current state
                state_next = s6; 
            end
        end
       s7 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s8; 
            end
            else begin // remain in current state
                state_next = s7; 
            end
        end
       s8 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s9; 
            end
            else begin // remain in current state
                state_next = s8; 
            end
        end
       s9 : begin
          if (counter_register == 4'b1011 || counter_register == 4'b0) begin  // if (input1 = 2'b01) then
                state_next = s0; 
            end
            else begin // remain in current state
                state_next = s9; 
            end
        end
      default : begin
        state_next = s0;
      end
    endcase
end 
  always @(state_reg) begin
    // default outputs
    case (state_reg)
   	 s0 : begin
          a0 = 0;
          a1 = 0;
          a2 = 0;
          a3 = 0;
           
          
        end
        s1 : begin
          a0 = 1;
          a1 = 0;
          a2 = 0;
          a3 = 1;
          
        end
        s2 : begin
          a0 = 1;
          a1 = 0;
          a2 = 0;
          a3 = 0;
          
            end
      s3 : begin
          a0 = 0;
          a1 = 1;
          a2 = 0;
          a3 = 0;
          
        end
      s4 : begin
          a0 = 1;
          a1 = 1;
          a2 = 0;
          a3 = 0;
          
        end
      s5 : begin
          a0 = 0;
          a1 = 0;
          a2 = 1;
          a3 = 0;
          
        end
      s6 : begin
          a0 = 1;
          a1 = 0;
          a2 = 1;
          a3 = 0;
          
        end
      s7 : begin
          a0 = 0;
          a1 = 1;
          a2 = 1;
          a3 = 0;
          
        end
      s8 : begin
          a0 = 1;
          a1 = 1;
          a2 = 1;
          a3 = 0;
          
        end
      s9 : begin
          a0 = 0;
          a1 = 0;
          a2 = 0;
          a3 = 1;
          
        end
      
      
      default: begin
        a0 = 0;
        a1 = 0;
        a2 = 0;
        a3 = 0;
        
      end
    endcase
end 
  
endmodule
