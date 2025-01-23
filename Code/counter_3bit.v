module Counter (
  input clk,                  // Tín hiệu xung nhịp (clock)
  input reset_n,              // Tín hiệu reset chủ động mức thấp (active-low reset)
  input [2:0] count_to,       // Giá trị đích cần nạp vào bộ đếm (3-bit)
  input load,                 // Tín hiệu nạp giá trị mới vào bộ đếm
  input count_en,             // Tín hiệu cho phép đếm
  output reg done,            // Tín hiệu báo hoàn thành đếm (1 khi count = 0)
  output reg [2:0] count      // Giá trị hiện tại của bộ đếm (3-bit)
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
