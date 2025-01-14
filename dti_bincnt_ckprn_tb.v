`timescale 1ns/1ps

module dti_bincnt_ckprn_tb();
reg clk;
reg reset_n;
reg load;
reg count_en;
reg [2:0] count_to;
wire done;

dti_bincnt_ckprn dut(
  .clk           (clk           ), 
  .reset_n       (reset_n       ), 
  .count_to      (count_to      ), 
  .load          (load          ), 
  .count_en      (count_en      ), 
  .done          (done          )
);

initial 
begin
  clk = 1;
  reset_n = 0;
  count_to = 0;
  count_en = 0;
  load = 0;
  @(negedge clk) reset_n = 1;
  @(negedge clk) count_to = 3;
  load = 1;
  @(negedge clk) load = 0;
  @(posedge clk) count_en = 1;
  #10;
  count_to = 4;
  load = 1;
  #50;
  $stop;
end

always #1 clk <= !clk;

endmodule