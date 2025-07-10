`timescale 1ns / 1ps

module votingMachine_tb();

    reg clk;
    reg rst;
    reg mode;
    reg button1, button2, button3, button4;
    wire [7:0] led;

    votingMachine uut (
        .clk(clk),
        .rst(rst),
        .mode(mode),
        .button1(button1),
        .button2(button2),
        .button3(button3),
        .button4(button4),
        .led(led)
    );

    // Clock generation: 100 MHz → 10 ns period
    always #5 clk = ~clk;

   initial begin
    // Initial reset setup
    clk = 1;
    rst = 1;
    mode = 0;
    button1 = 0; button2 = 0; button3 = 0; button4 = 0;

    #100;
    rst = 0;

    // ========================================
    // TEST CASE: Candidate 1 vote (50 ns)
    // ========================================
    button1 = 1;
    #50;        // Hold 60 ns (6 clock cycles)
    button1 = 0; // Release

    // ========================================
    // View Candidate 1's vote
    // ========================================
    mode = 1;
    #50;
    button1 = 1;
    #50;
    button1 = 0;
    

    // ========================================
    // View Candidate 2's vote (should be 0)
    // ========================================
    button2 = 1;
    #50;
    button2 = 0;

    // ========================================
    // Vote for Candidate 1 again
    // ========================================
    mode = 0;
    #50;
    button1 = 1;
    #50;
    button1 = 0;
    #50;
    button2 = 1;
    #50;
    button2 = 0;

    // ========================================
    // View results for both candidates again
    // ========================================
    mode = 1;
    #50;
    button1 = 1;    // Candidate 1
    #50;
    button1 = 0;

    button2 = 1;    // Candidate 2
    #50;
    button2 = 0;

    $stop;
end

    // =========================================================
    //  TEST CASE: 1 Second Vote Casting (Real Time)
    // Uncomment below block to simulate actual 1s press
    // =========================================================
    /*
    initial begin
        // Initial reset setup
        clk = 1;
        rst = 1;
        mode = 0;
        button1 = 0; button2 = 0; button3 = 0; button4 = 0;

        #100;
        rst = 0;

        // Simulate 1-second vote for Candidate 1
        button1 = 1;
        #1000000500;    // Hold for 1s (100,000,000 cycles at 100 MHz)
        button1 = 0;

        #200000000;     // Wait 0.2s before showing result

        // Switch to result mode
        mode = 1;
        #100;

        // View Candidate 1's vote count
        button1 = 1;
        #100;
        button1 = 0;

        #100;

        $stop;
    end
    */

endmodule
/*
✅ What Your led Values Show:
Time (approx)	LED Value	Meaning
~100 ns	0	Initial/reset state
~200–300 ns	255	Voting acknowledgment (LEDs all ON)
~400 ns	0	LEDs OFF after delay
~500 ns	255	Another LED blink during 2nd vote
~580 ns	1	Candidate 1 vote count shown (✅ correct!)

*/
