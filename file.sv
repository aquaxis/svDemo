
module TOP();

  export "DPI-C" function svFunc ;
  export "DPI-C" function svPrintTaskEnable ;

  int svValue ;

  function int svFunc(input int x) ;
    svValue = x + 1 ;
    return svValue + 3 ;
  endfunction

  task PrintTask;
  begin
    $display("[PrintTask] svValue: %x", svValue);
  end
  endtask

  reg TaskEnable = 0;
  function int svPrintTaskEnable() ;
    TaskEnable = 1;
    return  0;
  endfunction

  always begin
    wait(TaskEnable == 1);
    PrintTask();
    TaskEnable = 0;
  end

  import "DPI-C" function int cFunc(input int x) ;

  int result ;

  initial
  begin
    svValue = 15 ;
    result = cFunc(3) ;
    if (svValue != 4)
    begin
      $display("FAILED") ;
      $finish ;
    end
    if (result == 7)
      $display("PASSED") ;
    else
      $display("FAILED") ;
  end

endmodule
