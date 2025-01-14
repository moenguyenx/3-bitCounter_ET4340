module Counter (
    input clk,
    input reset_n,
    input [2:0] count_to,
    input load,
    input count_en,
    output reg done,
    output reg [2:0] count
);

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            // Reset logic
            count <= 3'b0;
            done <= 1'b0;
        end else begin
            if (load) begin
                // Load new value
                count <= count_to;
                done <= 1'b0; // Reset done
            end else if (count_en) begin
                if (count == 3'b0) begin
                    count <= 3'b0; // giữ nguyên 0
                    done <= 1'b1; // Đặt done = 1
                end else begin
                    count <= count - 1; // giảm giá trị
                    done <= 1'b0; // Reset done
                end
            end
        end
    end

endmodule

