`timescale 1ns / 1ps

module buttoncontrol(
    input clk, rst, button,
    output reg valid_vote
);

// Active: 50 ns vote casting → 5 clock cycles
reg [5:0] counter;                                        //for 50ns 

// Uncomment below for 1 second vote casting
// reg [30:0] counter; // 100_000_000 cycles at 100 MHz = 1s

always @(posedge clk) begin
    if (rst)
        counter <= 0;
    else begin
        if (button && counter < 5)        // Change 5 → 100_000_000 for 1s
            counter <= counter + 1;
        else if (!button)
            counter <= 0;
    end
end

always @(posedge clk) begin
    if (rst)
        valid_vote <= 1'b0;
    else begin
        if (counter == 5)                 // Change 5 → 100_000_000 for 1s
            valid_vote <= 1'b1;
        else
            valid_vote <= 1'b0;
    end
end

endmodule
