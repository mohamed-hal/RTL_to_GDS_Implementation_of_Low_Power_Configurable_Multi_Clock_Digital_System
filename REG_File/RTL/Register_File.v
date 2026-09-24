module Register_File #(
    parameter ADDRESS_WIDTH = 4 ,
              DATA_WIDTH    = 8 ,
              DEPTH         = 16
)(
    input   wire  [DATA_WIDTH - 1 : 0]    WrData ,
    input   wire  [ADDRESS_WIDTH - 1 : 0] Address ,
    input   wire                          WrEn ,
    input   wire                          RdEn ,
    input   wire                          CLK ,
    input   wire                          RST ,
    output  reg   [DATA_WIDTH - 1 : 0]    RdData,
    output  reg                           RdData_Valid,
    output  wire  [DATA_WIDTH - 1 : 0]    REG0,
    output  wire  [DATA_WIDTH - 1 : 0]    REG1,
    output  wire  [DATA_WIDTH - 1 : 0]    REG2,
    output  wire  [DATA_WIDTH - 1 : 0]    REG3
    );
    
    reg [DATA_WIDTH - 1 : 0] regfile [0 : DEPTH - 1];
    integer i;

    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            RdData       <= 'd0;
            RdData_Valid <= 'd0;
            for(i=0 ; i < DEPTH ; i = i + 1)begin
                if (i == 2) begin
                    regfile[i] <= 'b100000_01;
                end
                else if (i == 3) begin
                    regfile[i] <= 'b0010_0000;
                end
                else begin
                    regfile[i] <= 'd0;
                end 
            end
        end 
        else if(WrEn && !RdEn) regfile[Address] <= WrData;
        else if(!WrEn && RdEn) begin
             RdData       <= regfile[Address];
             RdData_Valid <= 'd1;
        end
        else begin
            RdData_Valid <= 'd0;
        end
    end

    assign REG0 = regfile[0];
    assign REG1 = regfile[1];
    assign REG2 = regfile[2];
    assign REG3 = regfile[3];
endmodule
