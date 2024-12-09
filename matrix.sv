module matrix_module #(
    parameter int row = 4,
    parameter int column = 4
) (
    output logic [7:0] output_mat [0:row-1][0:column-1]
);
    // Kombinasyonel bloða geçici bir matris tanýmlayýn
    initial begin
        output_mat = '{
          '{8'h0, 8'h0, 8'h1, 8'h1},
          '{8'h1, 8'h2, 8'h3, 8'h1},
          '{8'h2, 8'h1, 8'h2, 8'h1},
          '{8'h1, 8'h2, 8'h3, 8'h1}
        };
    end
endmodule
