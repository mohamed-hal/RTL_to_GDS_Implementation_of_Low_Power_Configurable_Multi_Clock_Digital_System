module FIFO_MEM #(parameter DATA_WIDTH = 8 , ADDR_SIZE = 3) (
    input   wire                         wclk,
    input   wire                         wclken,
    input   wire                         wfull,
    input   wire  [ADDR_SIZE - 1 : 0]    waddr,
    input   wire  [ADDR_SIZE - 1 : 0]    raddr,
    input   wire  [DATA_WIDTH - 1 : 0]   wdata,
    output  wire  [DATA_WIDTH - 1 : 0]   rdata
    );

    localparam Depth = 1 << ADDR_SIZE ;
    reg [DATA_WIDTH - 1 : 0] mem [Depth - 1 : 0];


    assign rdata = mem[raddr];

    always @(posedge wclk) begin
        if (wclken && !wfull) begin
            mem[waddr] <= wdata;
        end
    end 
endmodule
