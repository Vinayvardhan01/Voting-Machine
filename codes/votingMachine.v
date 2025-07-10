`timescale 1ns / 1ps

module votingMachine(
    input clk, rst, mode,
    input button1, button2, button3, button4,
    output [7:0] led
);

    wire valid_vote_c1, valid_vote_c2, valid_vote_c3, valid_vote_c4;
    wire [7:0] vote_count1, vote_count2, vote_count3, vote_count4;

    wire any_valid_vote;
    assign any_valid_vote = valid_vote_c1 | valid_vote_c2 | valid_vote_c3 | valid_vote_c4;

    buttoncontrol bc1(.clk(clk), .rst(rst), .button(button1), .valid_vote(valid_vote_c1));
    buttoncontrol bc2(.clk(clk), .rst(rst), .button(button2), .valid_vote(valid_vote_c2));
    buttoncontrol bc3(.clk(clk), .rst(rst), .button(button3), .valid_vote(valid_vote_c3));
    buttoncontrol bc4(.clk(clk), .rst(rst), .button(button4), .valid_vote(valid_vote_c4));

    votelogger vl(
        .clk(clk), .rst(rst),.mode(mode),
        .cand1_validvote(valid_vote_c1),
        .cand2_validvote(valid_vote_c2),
        .cand3_validvote(valid_vote_c3),
        .cand4_validvote(valid_vote_c4),
        .cand1_vote_recvd(vote_count1),
        .cand2_vote_recvd(vote_count2),
        .cand3_vote_recvd(vote_count3),
        .cand4_vote_recvd(vote_count4)
    );

    modeControl mc(
        .clk(clk), .rst(rst), .mode(mode),
        .valid_vote_casted(any_valid_vote),
        .cand1_vote(vote_count1),
        .cand2_vote(vote_count2),
        .cand3_vote(vote_count3),
        .cand4_vote(vote_count4),
        .cand1_button(button1),
        .cand2_button(button2),
        .cand3_button(button3),
        .cand4_button(button4),
        .leds(led)
    );

endmodule
