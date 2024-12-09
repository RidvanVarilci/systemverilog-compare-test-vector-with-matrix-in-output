module testbench;

    parameter  row = 4;
    parameter  column = 4; // also update lines 50th and 56th
  
    // To instantiate the output matrix
   logic [7:0] test_mat [0:row-1][0:column-1];
  
   // instantiate the matrix module
    matrix_module #(
        .row(row),
        .column(column)
    ) dut (
        .output_mat(test_mat)
    );

  logic [7:0] test_vectors [0:row-1][0:column-1];
    int file;
    string line;
    string input_hex;
    int read_count;

    initial begin
      
      $display("Output Matrix:");
        foreach (test_mat[i, j]) begin
            if (j == 0) $write("Row %0d: ", i);
            $write("%h ", test_mat[i][j]);
            if (j == column-1) $write("\n");
        end
       
      
        // open the file
        file = $fopen("test_vectors.txt", "r");
        if (file == 0) begin
            $error("Dosya açýlamadý!");
            $finish;
        end

        // Read test_vectors.txt
      $display("Test Vektors:");
        $display("----------------");
        
      for (int i = 0; i < row; i++) begin
            line = "";
            void'($fgets(line, file));
           

            // Read the Hexadecimal data
            read_count = $sscanf(line, "%2h_%2h_%2h_%2h", test_vectors[i][0], test_vectors[i][1], test_vectors[i][2],test_vectors[i][3],test_vectors[i][4],test_vectors[i][5]); 
           // You can add columns to the matrix from here (dont forget _%2h)
       
        if (read_count != row) begin
                $display("Invalid line: %s", line);
                continue;
            end
        $display("%h_%h_%h_%h", test_vectors[i][0], test_vectors[i][1], test_vectors[i][2],test_vectors[i][3],test_vectors[i][4],test_vectors[i][5]);
          //You can add columns to the matrix from here (dont forget _%h)
        end

        $display("----------------");

        // close the file
        $fclose(file);

        // Comparing test vectors with output matrix
        foreach (test_mat[i, j]) begin
            // Comparison using assertion
            if (test_mat[i][j] != test_vectors[i][j]) begin
              $display("\nFAIL: Matrix element not matched!\n test_mat[%0d][%0d] = %h, test_vectors[%0d][%0d] = %h", i, j, test_mat[i][j], i, j, test_vectors[i][j]);
                $fatal;
            end
        end

      $display("\nAll matrix elements were matched successfully.\n");
        $finish;
    end

endmodule
