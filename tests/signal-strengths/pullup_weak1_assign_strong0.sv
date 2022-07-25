/* *** Issue description

   Verilator does not support signal strength specifiers.
   This test tests if stronger signal replaces weaker.
   *** End of description
*/
module top (
    input logic clk,
    output logic o
);

    // Example:
   pullup (weak1) (o);
   assign (strong0, weak1) o = 0;
   always begin
      if (!o)
        $finish;
   end
endmodule