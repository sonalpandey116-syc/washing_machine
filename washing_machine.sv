module washing_machine (
    input clk,
    input reset,
    input start,

    output reg water_valve,
    output reg wash_motor,
    output reg drain_pump,
    output reg spin_motor,
    output reg done
);

    // State declaration
    parameter IDLE  = 3'b000;
    parameter FILL  = 3'b001;
    parameter WASH  = 3'b010;
    parameter DRAIN = 3'b011;
    parameter SPIN  = 3'b100;
    parameter DONE  = 3'b101;

    reg [2:0] state;
    reg [3:0] count;

    // State register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            state <= IDLE;
            count <= 0;
        end
        else
        begin
            case (state)

                IDLE:
                begin
                    count <= 0;
                    if (start)
                        state <= FILL;
                end

                FILL:
                begin
                    if (count < 4)
                        count <= count + 1;
                    else
                    begin
                        count <= 0;
                        state <= WASH;
                    end
                end

                WASH:
                begin
                    if (count < 5)
                        count <= count + 1;
                    else
                    begin
                        count <= 0;
                        state <= DRAIN;
                    end
                end

                DRAIN:
                begin
                    if (count < 3)
                        count <= count + 1;
                    else
                    begin
                        count <= 0;
                        state <= SPIN;
                    end
                end

                SPIN:
                begin
                    if (count < 5)
                        count <= count + 1;
                    else
                    begin
                        count <= 0;
                        state <= DONE;
                    end
                end

                DONE:
                begin
                    state <= IDLE;
                end

                default:
                    state <= IDLE;

            endcase
        end
    end

    // Output control
    always @(*)
    begin
        // Default outputs
        water_valve = 0;
        wash_motor  = 0;
        drain_pump  = 0;
        spin_motor  = 0;
        done        = 0;

        case (state)

            IDLE:
            begin
            end

            FILL:
            begin
                water_valve = 1;
            end

            WASH:
            begin
                wash_motor = 1;
            end

            DRAIN:
            begin
                drain_pump = 1;
            end

            SPIN:
            begin
                spin_motor = 1;
            end

            DONE:
            begin
                done = 1;
            end

        endcase
    end

endmodule