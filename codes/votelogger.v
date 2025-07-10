`timescale 1ns / 1ps

module votelogger(
    input clk, rst,mode,
    input cand1_validvote, cand2_validvote, cand3_validvote, cand4_validvote,
    output reg [7:0] cand1_vote_recvd, cand2_vote_recvd, cand3_vote_recvd, cand4_vote_recvd
);

always @(posedge clk) begin
    if (rst) begin
        cand1_vote_recvd <= 0;
        cand2_vote_recvd <= 0;
        cand3_vote_recvd <= 0;
        cand4_vote_recvd <= 0;
    end else begin
        if (cand1_validvote & mode==0)
            cand1_vote_recvd <= cand1_vote_recvd + 1;
        else if (cand2_validvote & mode==0)
            cand2_vote_recvd <= cand2_vote_recvd + 1;
        else if (cand3_validvote& mode==0)
            cand3_vote_recvd <= cand3_vote_recvd + 1;
        else if (cand4_validvote & mode==0)
            cand4_vote_recvd <= cand4_vote_recvd + 1;
    end
end

endmodule
