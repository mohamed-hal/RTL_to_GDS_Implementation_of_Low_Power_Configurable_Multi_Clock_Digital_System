module Register_File(
    input [15:0] WrData ,
    input [2:0] Address ,
    input WrEn , RdEn ,
    input CLK , RST ,
    output reg [15:0] RdData
    );
    reg [15:0] regfile [0:7];
    integer i;

    always @(posedge CLK , negedge RST) begin
        if (!RST) begin
            for(i=0 ; i<8 ; i=i+1)begin
              regfile[i] <= 0;
            end
        end 
        else if(WrEn && !RdEn) regfile[Address] <= WrData;
        else if(!WrEn && RdEn) RdData <= regfile[Address]; 
    end
endmodule
