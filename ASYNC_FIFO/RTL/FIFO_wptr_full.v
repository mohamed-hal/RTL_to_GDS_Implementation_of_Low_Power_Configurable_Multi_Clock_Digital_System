module FIFO_wptr_full #(parameter ADDR_SIZE = 3) (
    input  wire                      wclk,
    input  wire                      wrst_n,
    input  wire                      winc,
    input  wire [ADDR_SIZE     : 0]  wq2_rptr,
    output reg  [ADDR_SIZE - 1 : 0]  waddr,
    output reg  [ADDR_SIZE     : 0]  wptr,
    output reg                       wfull
);

    integer i;
    reg  [ADDR_SIZE : 0] wbin;          // registered binary counter
    reg  [ADDR_SIZE : 0] wbinnext;      // combinational next value
    reg  [ADDR_SIZE : 0] wgraynext;     // combinational next Gray value

    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wbin  <= 'b0;
            wptr  <= 'b0;
            wfull <= 'b0;
        end else begin
            wbin  <= wbinnext;
            wptr  <= wgraynext;
            wfull <= (wgraynext == {~wq2_rptr[ADDR_SIZE:ADDR_SIZE-1], wq2_rptr[ADDR_SIZE-2:0]});
        end
    end

    always @(*) begin
        wbinnext = wbin + (winc & ~wfull);   
        wgraynext[ADDR_SIZE] = wbinnext[ADDR_SIZE];
        for (i = 0; i < ADDR_SIZE; i = i + 1)
            wgraynext[i] = wbinnext[i] ^ wbinnext[i+1];
    end

    always @(*) waddr = wbin[ADDR_SIZE-1:0];   

endmodule