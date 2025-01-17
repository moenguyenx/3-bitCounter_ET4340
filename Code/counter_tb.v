`timescale 1ns/1ps

module Counter_tb;

  reg clk;
  reg reset_n;
  reg [2:0] count_to;
  reg load;
  reg count_en;
  wire done;
  wire [2:0] count;

  // Instantiate the Counter module
  Counter uut (
    .clk(clk),
    .reset_n(reset_n),
    .count_to(count_to),
    .load(load),
    .count_en(count_en),
    .done(done),
    .count(count)
  );

  // Clock Generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock period = 10ns
  end

  // Test Procedure
  initial begin
    // Initialize signals
    reset_n = 0;
    count_to = 3'b0;
    load = 0;
    count_en = 0;

    // Apply Reset
    #10 reset_n = 1;

    // Test Case 1: Load a value and start counting
    #5 count_to = 3'b111; // Set count_to
    load = 1; // Assert load to load the counter value
    #10 load = 0; // Deassert load
    count_en = 1; // Start counting
    wait(done); // Wait until done signal is asserted
    $display("Test Case 1: Counter reached zero. Count: %0d, Done: %0b", count, done);

    // Test Case 2: Reload a new value
    #10 count_to = 3'b011; // Load a smaller value
    load = 1; // Assert load
    #10 load = 0; // Deassert load
    wait(done); // Wait until done signal is asserted
    $display("Test Case 2: Counter reached zero. Count: %0d, Done: %0b", count, done);
    
    // Test Case 3: Reload a new value
    #10 count_to = 3'b101; // Load a smaller value
    load = 1; // Assert load
    #10 load = 0; // Deassert load
    wait(done); // Wait until done signal is asserted
    $display("Test Case 3: Counter reached zero. Count: %0d, Done: %0b", count, done);
    
    // Test Case 4: Reload a new value
    #10 count_to = 3'b001; // Load a smaller value
    load = 1; // Assert load
    #10 load = 0; // Deassert load
    wait(done); // Wait until done signal is asserted
    $display("Test Case 4: Counter reached zero. Count: %0d, Done: %0b", count, done);

    // End simulation
    #50;
    $stop;
  end

  // Dump Waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Counter_tb);
  end

endmodule
