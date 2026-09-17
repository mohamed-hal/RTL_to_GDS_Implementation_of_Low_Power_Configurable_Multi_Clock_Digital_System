module Parity_Calc # ( parameter WIDTH = 8 )

(
 input   wire                  clk,
 input   wire                  RST,
 input   wire                  PAR_EN,
 input   wire                  PAR_TYP,
 input   wire                  Busy, 
 input   wire   [WIDTH-1:0]    P_DATA,
 input   wire                  Data_Valid,
 output  reg                   par_bit
);

reg  [WIDTH-1:0]    DATA_V ;

//isolate input 
always @ (posedge clk or negedge RST)
 begin
  if(!RST)
   begin
    DATA_V <= 'b0 ;
   end
  else if(Data_Valid && !Busy)
   begin
    DATA_V <= P_DATA ;
   end 
 end
 

always @ (posedge clk or negedge RST)
 begin
  if(!RST)
   begin
    par_bit <= 'b0 ;
   end
  else
   begin
    if (PAR_EN)
	 begin
	  case(PAR_TYP)
	  1'b0 : begin                 
	          par_bit <= ^DATA_V  ;     // Even Parity
	         end
	  1'b1 : begin
	          par_bit <= ~^DATA_V ;     // Odd Parity
	         end		
	  endcase       	 
	 end
   end
 end 


endmodule
 