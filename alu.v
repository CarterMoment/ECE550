module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result,
    isNotEqual, isLessThan, overflow);

    input  [31:0] data_operandA, data_operandB;
    input  [4:0]  ctrl_ALUopcode, ctrl_shiftamt;
    output reg [31:0] data_result;
    output reg isNotEqual, isLessThan, overflow;

    localparam OP_ADD = 5'b00000;
    localparam OP_SUB = 5'b00001;
    localparam OP_AND = 5'b00010;
    localparam OP_OR  = 5'b00011;
    localparam OP_SLL = 5'b00100;
    localparam OP_SRA = 5'b00101;

    always @(*) begin
        // isNotEqual/isLessThan are a dedicated signed comparison of A and B,
        // always active regardless of which opcode is selected.
        isNotEqual = (data_operandA != data_operandB);
        isLessThan = ($signed(data_operandA) < $signed(data_operandB));

        overflow = 1'b0;

        case (ctrl_ALUopcode)
            OP_ADD: begin
                data_result = data_operandA + data_operandB;
                overflow = (data_operandA[31] == data_operandB[31]) &&
                           (data_result[31] != data_operandA[31]);
            end

            OP_SUB: begin
                data_result = data_operandA - data_operandB;
                overflow = (data_operandA[31] != data_operandB[31]) &&
                           (data_result[31] != data_operandA[31]);
            end

            OP_AND:
                data_result = data_operandA & data_operandB;

            OP_OR:
                data_result = data_operandA | data_operandB;

            OP_SLL:
                data_result = data_operandA << ctrl_shiftamt;

            OP_SRA:
                data_result = $signed(data_operandA) >>> ctrl_shiftamt;

            default:
                data_result = 32'b0;
        endcase
    end

endmodule
