/* *** Issue description

   Coverpoints with auto-sized bin arrays are rejected by Verilator's parser.

   *** End of description
*/

module top (input logic clk);
    logic[15:0] bar = 0;

    // Example:
    covergroup cg @(posedge clk);
        coverpoint bar {
            bins b[] = {0, 4, 32, 64};
        }
    endgroup
    // Example end

    cg cg_i;

    initial cg_i = new;
    final $display("Coverage: %0.0f%%", cg_i.get_inst_coverage());

    int cyc = 1;
    always @(posedge clk) begin
        cyc <= cyc + 1;
        bar <<= 1;
        if (bar == '0) bar = 1;
        $display("[%0t] bar=%b, %0.0f%%", $time, bar, cg_i.get_inst_coverage());
        if (cyc == 16) begin
            if (cg_i.get_inst_coverage() != 100) $stop;
            $finish;
        end
    end
endmodule

