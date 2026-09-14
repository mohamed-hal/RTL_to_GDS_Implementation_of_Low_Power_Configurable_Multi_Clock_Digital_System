module ClkDiv(
    input   wire          i_ref_clk,
    input   wire          i_rst_n,
    input   wire          i_clk_en,
    input   wire  [7:0]   i_div_ratio,
    output  reg           o_div_clk
    );

    wire       CLK_DIV_EN;
    wire       odd;
    wire [7:0] half_even;  
    wire [7:0] half_ceil;   

    reg  [7:0] cnt_even;
    reg        even_clk;

    reg  [7:0] cnt_odd_pos;
    reg  [7:0] cnt_odd_neg;
    wire       outA, outB;


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

    always @(*) begin
        o_div_clk = odd ? (outA & outB) : even_clk;
    end

    assign outA = (cnt_odd_pos < half_ceil);
    assign outB = (cnt_odd_neg < half_ceil);

    assign CLK_DIV_EN = i_clk_en && (i_div_ratio != 'd0) && (i_div_ratio != 'd1);
    assign odd        = i_div_ratio[0];
    assign half_even  = i_div_ratio >> 1;
    assign half_ceil  = (i_div_ratio + 'd1) >> 1;
    

endmodule
