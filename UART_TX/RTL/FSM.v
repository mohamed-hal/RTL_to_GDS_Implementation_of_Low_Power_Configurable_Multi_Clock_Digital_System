module FSM(
       input Data_Valid,
       input PAR_EN, ser_done,
       input RST, clk,
       output reg busy,
       output reg ser_en, 
       output reg [1:0] mux_sel
    );

    reg busy_c;
//STATES
localparam      IDLE      = 3'b000,
                start_bit = 3'b001, 
                ser_data  = 3'b011,
                par_bit   = 3'b010,
                stop_bit  = 3'b110;

reg     [2:0]   Current_State ,
                 Next_State ;

//MUX_SEL
localparam      sel_start = 2'b00,
                sel_stop  = 2'b01, 
                sel_data  = 2'b10,
                sel_par   = 2'b11;
                                

//STATE TRANSITION
always @(posedge clk , negedge RST) 
 begin
       if (!RST) begin
              Current_State <= IDLE;
       end else begin
              Current_State <= Next_State;
       end
 end

//NEXT STATE LOGIC
always @(*)
 begin
       case (Current_State)
       IDLE      :   begin
                      if (Data_Valid) begin
                         Next_State = start_bit;
                      end
                      else begin
                         Next_State = IDLE;
                      end
       end
       start_bit :   begin
                         Next_State = ser_data;  
       end
       ser_data  :   begin
                      if (ser_done) begin
                         if (PAR_EN) begin
                            Next_State = par_bit;
                         end
                         else begin
                            Next_State = stop_bit;
                         end
                      end
                      else begin
                         Next_State = ser_data;   
                      end
       end
       par_bit   :   begin
                         Next_State = stop_bit;
       end
       stop_bit  :   begin
                         Next_State = IDLE;
       end
       default:      begin
                         Next_State = IDLE;
       end
       endcase
end


//OUTPUT LOGIC
always @(*)
 begin
       mux_sel = sel_stop;
       ser_en  = 'b0;
       busy_c  = 'b1;
       case (Current_State)
       IDLE      :   begin
                         busy_c  = 'b0;
       end
       start_bit :   begin
                         mux_sel = sel_start;
       end
       ser_data  :   begin
                         mux_sel = sel_data;
                         ser_en  = 'b1;
       end
       par_bit   :   begin
                         mux_sel = sel_par;
       end
       stop_bit  :   begin
                         mux_sel = sel_stop;
       end
       default:      begin
                         mux_sel = sel_stop;
                         busy_c  = 'b0;
                         ser_en  = 'b0;
       end
       endcase
end


//register output 
always @ (posedge clk or negedge RST)
 begin
  if(!RST)
   begin
    busy <= 1'b0 ;
   end
  else
   begin
    busy <= busy_c ;
   end
 end
endmodule