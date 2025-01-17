module Counter (
  input clk,
  input reset_n,
  input [2:0] count_to,
  input load,
  input count_en,
  output reg done,
  output reg [2:0] count
);

  reg [2:0] next_count;

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      // Reset logic
      count <= 3'b0;
      done <= 1'b0;
    end else begin
      // Counter logic
      if (load) begin
        // Load new value
        next_count = count_to;
        count <= next_count;
        done <= 1'b0;
      end else if (count_en) begin
        // Count down
        if (count == 3'b0) begin
          next_count = 3'b0;
          done <= 1'b1;
        end else begin
          next_count <= count - 1;
          done <= 1'b0;
        end
        count <= next_count;
      end
    end
  end

endmodule
