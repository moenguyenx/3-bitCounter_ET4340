module Counter (
  input clk,                  // Tín hiệu xung nhịp 
  input reset_n,              // Tín hiệu reset 
  input [2:0] count_to,       // Giá trị đích cần nạp vào bộ đếm 
  input load,                 // Tín hiệu nạp giá trị mới vào bộ đếm
  input count_en,             // Tín hiệu cho phép đếm
  output reg done,            // Tín hiệu báo hoàn thành đếm 
  output reg [2:0] count      // Giá trị hiện tại của bộ đếm 
);

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      // Reset logic
      count <= 3'b0;
      done <= 1'b0;
    end else if (load) begin
      // Load logic
      count <= count_to;
      done <= 1'b0;
    end else if (count_en) begin
      // Count down logic
      if (count == 3'b0) begin
        done <= 1'b1;   
      end else begin
        count <= count - 1;  // Decrement
        done <= 1'b0;        // Not done
      end
    end
  end

endmodule
