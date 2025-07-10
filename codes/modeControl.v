// for casting or checking the result of the vote 
`timescale 1ns / 1ps

module modeControl(
    input clk, rst, mode, valid_vote_casted,
    input [7:0] cand1_vote, cand2_vote, cand3_vote, cand4_vote,
    input cand1_button, cand2_button, cand3_button, cand4_button,
    output reg [7:0] leds
);

// Active: LED ON duration for 50 ns → 5 cycles
reg [5:0] counter;

//  Uncomment below for 1-second LED ON
// reg [30:0] counter; // 100_000_000 cycles = 1s

always @(posedge clk) begin
    if (rst)
        counter <= 0;
    else if (valid_vote_casted)
        counter <= 1;
    else if (counter != 0 && counter < 5) // Change 5 → 100_000_000 for 1s
        counter <= counter + 1;
    else
        counter <= 0;
end

always @(posedge clk) begin
    if (rst)
        leds <= 8'b00000000;
    else begin
        if (mode == 0) begin // Voting mode
            if (counter > 0)
                leds <= 8'b11111111;
            else
                leds <= 8'b00000000;
        end else if (mode == 1) begin // Result mode
            if (cand1_button)
                leds <= cand1_vote;
            else if (cand2_button)
                leds <= cand2_vote;
            else if (cand3_button)
                leds <= cand3_vote;
            else if (cand4_button)
                leds <= cand4_vote;
            else
                leds <= 8'b00000000;
        end
    end
end

endmodule
