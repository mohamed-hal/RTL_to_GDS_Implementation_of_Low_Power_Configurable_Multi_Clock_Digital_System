module FSM_RX #(parameter DATA_WIDTH = 8)(
    input   wire       CLK,
    input   wire       RST,
    input   wire       PAR_EN,
    input   wire       RX_IN,
    input   wire [5:0] edge_cnt,
    input   wire [3:0] bit_cnt,
    input   wire [5:0] Prescale,
    input   wire       par_err,
    input   wire       strt_glitch,
    input   wire       stp_err,

    output  reg        enable,
    output  reg        dat_samp_en,
    output  reg        par_chk_en,
    output  reg        strt_chk_en,
    output  reg        stp_chk_en,
    output  reg        deser_en,
    output  reg        Data_Valid
    );


    //STATES
    localparam  IDLE      = 3'b000,
                start_bit = 3'b001, 
                ser_data  = 3'b011,
                par_bit   = 3'b010,
                stop_bit  = 3'b110,
                check     = 3'b111;

    reg [2:0] Current_State,
              Next_State; 


    wire [5:0] edge_check;          



    always @(posedge CLK , negedge RST ) begin
        if (!RST) begin
            Current_State <= IDLE;
        end
        else begin
            Current_State <= Next_State;
        end
    end




    always @(*) begin
        case (Current_State)

        IDLE    :  begin

            if (RX_IN) begin
                Next_State = IDLE;
            end else begin
                Next_State = start_bit;
            end

        end

        start_bit : begin

            if (edge_cnt == edge_check && bit_cnt == 'd0) begin
                if (strt_glitch) begin
                    Next_State = IDLE;
                end else begin
                    Next_State = ser_data;
                end
            end else begin
                    Next_State = start_bit;
            end
  

        end

        ser_data  : begin

            if (edge_cnt == edge_check && bit_cnt == DATA_WIDTH) begin
                if (PAR_EN) begin
                    Next_State = par_bit;
                end else begin
                    Next_State = stop_bit;
                end
            end else begin
                    Next_State = ser_data;
            end

        end

        par_bit   : begin

            if (edge_cnt == edge_check && bit_cnt == DATA_WIDTH + 1) begin
                Next_State =stop_bit;
            end else begin
                Next_State = par_bit;
            end

        end

        stop_bit  : begin

            if (PAR_EN) begin
                if (edge_cnt == edge_check - 'd1 && bit_cnt == DATA_WIDTH + 2) begin
                    Next_State = check;
                end else begin
                    Next_State = stop_bit;
                end
                
            end else begin
                if (edge_cnt == edge_check - 'd1 && bit_cnt == DATA_WIDTH + 1) begin
                    Next_State = check;
                end else begin
                    Next_State = stop_bit;
                end
            end

        end

        check     : begin
            
            if (RX_IN) begin
                Next_State = IDLE;
            end else begin
                Next_State = start_bit;
            end
        end

        default   : begin
                Next_State = IDLE;
        end 
        endcase
        
    end


    always @(*) begin

            enable      = 'b0;
            dat_samp_en = 'b0;
            par_chk_en  = 'b0;
            strt_chk_en = 'b0;
            stp_chk_en  = 'b0;
            deser_en    = 'b0;
            Data_Valid  = 'b0;

        case (Current_State)

        IDLE     :  begin
            if (RX_IN) begin
                enable      = 'b0;
                dat_samp_en = 'b0;
                par_chk_en  = 'b0;
                strt_chk_en = 'b0;
                stp_chk_en  = 'b0;
                deser_en    = 'b0;
                Data_Valid  = 'b0;
                
            end else begin
                strt_chk_en = 'b1;
                enable      = 'b1;
                dat_samp_en = 'b1;   
            end
        end

        start_bit : begin
            strt_chk_en = 'b1;
            enable      = 'b1;
            dat_samp_en = 'b1;
        end

        ser_data  : begin
            deser_en    = 'b1;
            enable      = 'b1;
            dat_samp_en = 'b1;  
        end

        par_bit   : begin
            enable      = 'b1;
            dat_samp_en = 'b1;
            par_chk_en  = 'b1;
        end

        stop_bit  : begin
            stp_chk_en  = 'b1;
            enable      = 'b1;
            dat_samp_en = 'b1;
        end

        check     : begin
            dat_samp_en = 'b1;
            if (par_err || stp_err) begin
                Data_Valid = 'b0;
            end else begin
                Data_Valid = 'b1;
            end
        end
        default   : begin
            enable      = 'b0;
            dat_samp_en = 'b0;
            par_chk_en  = 'b0;
            strt_chk_en = 'b0;
            stp_chk_en  = 'b0;
            deser_en    = 'b0;
            Data_Valid  = 'b0;
        end
        endcase
    end

    assign edge_check = Prescale - 'b1;

endmodule
