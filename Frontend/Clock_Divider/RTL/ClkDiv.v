module ClkDiv #(parameter WIDTH = 8) (
    input   wire                    i_ref_clk,
    input   wire                    i_rst_n,
    input   wire                    i_clk_en,
    input   wire  [WIDTH - 1 : 0]   i_div_ratio,
    output  reg                     o_div_clk
    );

    wire                 CLK_DIV_EN;
    wire                 odd;
    wire [WIDTH - 1 : 0] half_even;  
    wire [WIDTH - 1 : 0] half_ceil;   

    reg  [WIDTH - 1 : 0] cnt_even;
    reg                  even_clk;

    reg  [WIDTH - 1 : 0] cnt_odd_pos;
    reg  [WIDTH - 1 : 0] cnt_odd_neg;
    wire                 outA, outB;
    reg                  outA_r, outB_r, even_r;
    wire                 bypass;   // ratio 0 or 1: pass the input clock through


    always @(posedge i_ref_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            cnt_even <= 'd0;
            even_clk <= 'b0;
        end else if (CLK_DIV_EN && !odd) begin
            if (cnt_even == half_even - 'd1) begin
                cnt_even <= 'd0;
                even_clk <= ~even_clk;
            end else begin
                cnt_even <= cnt_even + 'd1;
            end
        end
    end

    always @(posedge i_ref_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            cnt_odd_pos <= 'd0;
        end else if (CLK_DIV_EN && odd) begin
            if (cnt_odd_pos == i_div_ratio - 'd1)
                cnt_odd_pos <= 'd0;
            else
                cnt_odd_pos <= cnt_odd_pos + 'd1;
        end
    end

    always @(negedge i_ref_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            cnt_odd_neg <= 'd0;
        end else if (CLK_DIV_EN && odd) begin
            if (cnt_odd_neg == i_div_ratio - 'd1)
                cnt_odd_neg <= 'd0;
            else
                cnt_odd_neg <= cnt_odd_neg + 'd1;
        end
    end

    // Registered outputs (one ref-clock period of latency on every path).
    // outA_r is captured on the rising edge and outB_r on the falling edge,
    // so the half-cycle offset between them (the 50% duty cycle for odd
    // ratios) is preserved. even_r adds the same delay on the even path.
    always @(posedge i_ref_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            outA_r <= 1'b0;
            even_r <= 1'b0;
        end else begin
            outA_r <= outA;
            even_r <= even_clk;
        end
    end

    always @(negedge i_ref_clk or negedge i_rst_n) begin
        if (!i_rst_n) outB_r <= 1'b0;
        else          outB_r <= outB;
    end

    always @(*) begin
        if (bypass) o_div_clk = i_ref_clk;
        else        o_div_clk = odd ? (outA_r & outB_r) : even_r;
    end

    assign outA = (cnt_odd_pos < half_ceil);
    assign outB = (cnt_odd_neg < half_ceil);

    assign bypass     = ~|i_div_ratio[WIDTH - 1 : 1];   // ratio == 0 or 1
    assign CLK_DIV_EN = i_clk_en && (i_div_ratio != 'd0) && (i_div_ratio != 'd1);
    assign odd        = i_div_ratio[0];
    assign half_even  = i_div_ratio >> 1;
    assign half_ceil  = (i_div_ratio + 'd1) >> 1;
    

endmodule
