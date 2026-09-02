`timescale 1ns/1ns

module washing_machine_tb;

    reg clk;
    reg reset;
    reg start;

    wire water_valve;
    wire wash_motor;
    wire drain_pump;
    wire spin_motor;
    wire done;

    washing_machine uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .water_valve(water_valve),
        .wash_motor(wash_motor),
        .drain_pump(drain_pump),
        .spin_motor(spin_motor),
        .done(done)
    );

    always #5 clk = ~clk;

    initial
    begin
        clk = 0;
        reset = 1;
        start = 0;
        #10;
        reset = 0;
        #10;
        start = 1;
        #10;
        start = 0;
        #250;

        $finish;
    end

endmodule