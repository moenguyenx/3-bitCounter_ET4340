module dti_bincnt_ckprn
(
  input            clk,      // Clock
  input            reset_n,  // Asynchronous reset active low
  input      [2:0] count_to,       
  input            load,           
  input            count_en,
  output reg       done            
);

reg [2:0] count;
reg [2:0] count_next;

//--------------------------------------------------
//         D Flip Flop
//--------------------------------------------------
always @(posedge clk or negedge reset_n) begin
  if(~reset_n) begin
    count <= 0;
    done  <= 0;
  end else begin
    count <= count_next;
    done  <= ~|count_next;
  end
end

//--------------------------------------------------
//         Counter Value
//--------------------------------------------------
always @* begin
  if(load) begin
    count_next = count_to;
  end else begin
    case ({count_en, done})
    2'b00, 2'b01, 2'b11: count_next = count;
    2'b10:               count_next = count - 1;
    endcase
  end
end

endmodule