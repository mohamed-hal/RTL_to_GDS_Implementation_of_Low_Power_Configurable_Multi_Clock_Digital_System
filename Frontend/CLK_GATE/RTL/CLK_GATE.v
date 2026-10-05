module CLK_GATE (
input  wire      CLK_EN,
input  wire      CLK,
output wire      GATED_CLK
);


//FOR SIMULATION
reg     Latch_Out ;

//latch 
always @(CLK or CLK_EN)
 begin
  if(!CLK)      // active low
   begin
    Latch_Out <= CLK_EN ;
   end
 end

assign  GATED_CLK = CLK && Latch_Out ;



/*
//FOR SYNTHESIS
TLATNCAX4M U0 (
.E(CLK_EN),
.CK(CLK),
.ECK(GATED_CLK)
); 
*/


endmodule