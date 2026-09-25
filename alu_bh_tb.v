`timescale 1 ns / 100 ps

module alu_tb();

    reg [31:0] dataA, dataB;
    reg [4:0] ctrl_ALUopcode;
    reg clock;

    wire [31:0] data_result;

    alu test_alu(dataA, dataB, ctrl_ALUopcode, data_result);

    initial begin
        $display($time, " simulation start");
        clock = 1'b0;
        @(negedge clock);
        ctrl_ALUopcode = 5'b00000;
        dataA = 32'd10;
        dataB = 32'd20;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00000;
        dataA = 32'd100;
        dataB = 32'd200;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00000;
        dataA = 32'hFFFFFFFF;
        dataB = 32'd1;



        @(negedge clock);
        ctrl_ALUopcode = 5'b00001;
        dataA = 32'd20;
        dataB = 32'd10;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00001;
        dataA = 32'd100;
        dataB = 32'd100;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00001;
        dataA = 32'd10;
        dataB = 32'd20;


        @(negedge clock);
        ctrl_ALUopcode = 5'b00010;
        dataA = 32'hFFFFFFFF;
        dataB = 32'h00000000;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00010;
        dataA = 32'hFFFF0000;
        dataB = 32'h0000FFFF;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00010;
        dataA = 32'hAAAAAAAA;
        dataB = 32'h55555555;


        @(negedge clock);
        ctrl_ALUopcode = 5'b00011;
        dataA = 32'hFFFF0000;
        dataB = 32'h0000FFFF;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00011;
        dataA = 32'hAAAAAAAA;
        dataB = 32'h55555555;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00011;
        dataA = 32'h00000000;
        dataB = 32'h12345678;


    
        @(negedge clock);
        ctrl_ALUopcode = 5'b00100;
        dataA = 32'h00000001;
        dataB = 32'd1;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00100;
        dataA = 32'h00000001;
        dataB = 32'd4;

        @(negedge clock);
        ctrl_ALUopcode = 5'b00100;
        dataA = 32'h0000000F;
        dataB = 32'd8;


    

        // Positive number - fills with 0
        @(negedge clock);
        ctrl_ALUopcode = 5'b00101;
        dataA = 32'h40000000;
        dataB = 32'd1;

        // Negative number - fills with 1
        @(negedge clock);
        ctrl_ALUopcode = 5'b00101;
        dataA = 32'h80000000;
        dataB = 32'd1;

        // Negative number shifted multiple positions
        @(negedge clock);
        ctrl_ALUopcode = 5'b00101;
        dataA = 32'hF0000000;
        dataB = 32'd4;


        // End simulation
        @(negedge clock);
        $stop;

    end

    always
        #10 clock = ~clock;

endmodule