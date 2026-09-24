module ALU # (
    parameter OPERAND_WIDTH = 8,
              OUT_WIDTH     = 2 * OPERAND_WIDTH
) 
(
  input   wire  [OPERAND_WIDTH - 1 : 0]  A, 
  input   wire  [OPERAND_WIDTH - 1 : 0]  B,
  input   wire                           EN,
  input   wire  [3:0]                    ALU_FUN,
  input   wire                           CLK,
  input   wire                           RST,  
  output  reg  [OUT_WIDTH-1:0]           ALU_OUT,
  output  reg                            OUT_VALID 
);

reg [OUT_WIDTH-1:0] ALU_OUT_Comb;
reg                 OUT_VALID_Comb;


localparam   ADD=4'b0000, SUB=4'b0001 , MUL=4'b0010 , DIV=4'b0011,
             AND=4'b0100, OR=4'b0101  , NAND=4'b0110, NOR=4'b0111,
             XOR=4'b1000, XNOR=4'b1001, EQL=4'b1010 , GT=4'b1011,
             ST=4'b1100 , SHR=4'b1101 , SHL=4'b1110 ;


always @(posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    ALU_OUT   <= 'b0 ;
    OUT_VALID <= 1'b0 ;	
   end
  else 
   begin  
    ALU_OUT   <= ALU_OUT_Comb ;
    OUT_VALID <= OUT_VALID_Comb ;
   end	
 end

 always @(*)
 begin
   OUT_VALID_Comb = 'b0 ;
   ALU_OUT_Comb   = 'b0 ;
   if(EN)
    begin   
	 OUT_VALID_Comb = 1'b1 ;
     case (ALU_FUN) 
     ADD    : begin
               ALU_OUT_Comb = A+B;
              end
     SUB    : begin
               ALU_OUT_Comb = A-B;
              end
     MUL    : begin
               ALU_OUT_Comb = A*B;
              end
     DIV    : begin
               ALU_OUT_Comb = A/B;
              end
     AND    : begin
               ALU_OUT_Comb = A & B;
              end
     OR     : begin
               ALU_OUT_Comb = A | B;
              end
     NAND   : begin
               ALU_OUT_Comb = ~ (A & B);
              end
     NOR    : begin
               ALU_OUT_Comb = ~ (A | B);
              end     
     XOR    : begin
               ALU_OUT_Comb =  (A ^ B);
              end
     XNOR   : begin
               ALU_OUT_Comb = ~ (A ^ B);
              end           
     EQL    : begin
              if (A==B)
                 ALU_OUT_Comb = 'b1;
              else
                 ALU_OUT_Comb = 'b0;
              end
     GT     : begin
               if (A>B)
                 ALU_OUT_Comb = 'b10;
               else
                 ALU_OUT_Comb = 'b0;
              end 
     ST     : begin
               if (A<B)
                 ALU_OUT_Comb = 'b11;
               else
                 ALU_OUT_Comb = 'b0;
              end     
     SHR    : begin
               ALU_OUT_Comb = A>>1;
              end
     SHL    : begin 
               ALU_OUT_Comb = A<<1;
              end
    default: begin
               ALU_OUT_Comb = 'b0;
             end
    endcase
   end
  else
   begin
	 OUT_VALID_Comb = 1'b0 ;
   end   
 end    

endmodule
