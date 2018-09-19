`timescale 1ns / 1ps

module tb_Zynq7000;

  import "DPI-C" function int cFuncStart() ;

  // socket sample
  import "DPI-C" function chandle socket_open(input string uri);                     // socket open(hostname:port)
  import "DPI-C" function void socket_close(input chandle handle);                   // socket close
  import "DPI-C" function int socket_write(input chandle handle, input string data); // socket write
  import "DPI-C" function string socket_read(input chandle handle);                  // socket read

  reg tb_ACLK;
  reg tb_ARESETn;

  wire temp_clk;
  wire temp_rstn;

  reg [31:0] read_data;
  wire [31:0] LED;
  reg resp;


  initial begin
    tb_ACLK = 1'b0;
  end

  //------------------------------------------------------------------------
  // Simple Clock Generator
  //------------------------------------------------------------------------
  always #10 tb_ACLK = !tb_ACLK;


  //------------------------------------------------------------------------
  // Example socket
  //------------------------------------------------------------------------
  initial begin
    chandle h;
	
    // Connect
    h = socket_open("localhost:1234");
    if(h == null) begin
      $display("[ERROR] can't open socket.");
      $stop();
    end 

    // Send / receive
    if(!socket_write(h, "Hello World !\n")) begin
      $display("[ERROR] can't socket_write.");
      $stop();
    end
    $display(socket_read(h));

    // Done
    socket_close(h);
  end

	initial begin
`ifndef XILINX_SIMULATOR
           tb_Zynq7000.zynq_sys.base_zynq_i.processing_system7_0.inst.M_AXI_GP0.master.IF.PC.fatal_to_warnings=1;
           #40;
           tb_Zynq7000.zynq_sys.base_zynq_i.processing_system7_0.inst.M_AXI_GP0.master.IF.PC.fatal_to_warnings=0;
`endif
  end

  reg [31:0] mem_data;

  initial begin
    $display ("running the tb");

    tb_ARESETn = 1'b0;
    repeat(2)@(posedge tb_ACLK);
    tb_ARESETn = 1'b1;
    @(posedge tb_ACLK);

    repeat(5) @(posedge tb_ACLK);

    //Reset the PL
    tb_Zynq7000.zynq_sys.Zynq7000_i.processing_system7_0.inst.fpga_soft_reset(32'h1);
    tb_Zynq7000.zynq_sys.Zynq7000_i.processing_system7_0.inst.fpga_soft_reset(32'h0);

    //This drives the LEDs on the GPIO output
    tb_Zynq7000.zynq_sys.Zynq7000_i.processing_system7_0.inst.write_data(32'h40000000,4, 32'hDEADA5A5, resp);
    tb_Zynq7000.zynq_sys.Zynq7000_i.processing_system7_0.inst.read_data(32'h40000008,4,read_data,resp);
    $display ("%t, running the testbench, data read from GPIO was 32'h%x",$time, read_data);
    if(read_data[3:0] == 4'h5) begin
      $display ("AXI VIP Test PASSED");
    end else begin
      $display ("AXI VIP Test FAILED");
    end
    $display ("Simulation completed");

    tb_Zynq7000.zynq_sys.Zynq7000_i.processing_system7_0.inst.write_mem(32'hDEADBEEF, 32'h10000000, 4);
    tb_Zynq7000.zynq_sys.Zynq7000_i.processing_system7_0.inst.read_mem(32'h10000000, 4, mem_data);
    $display ("%t, running the testbench, data read from MEM was 32'h%x",$time, mem_data);

    cFuncStart();
//    $stop;
  end

  assign temp_clk = tb_ACLK;
  assign temp_rstn = tb_ARESETn;

  Zynq7000_wrapper zynq_sys(
    .DDR_addr(),
    .DDR_ba(),
    .DDR_cas_n(),
    .DDR_ck_n(),
    .DDR_ck_p(),
    .DDR_cke(),
    .DDR_cs_n(),
    .DDR_dm(),
    .DDR_dq(),
    .DDR_dqs_n(),
    .DDR_dqs_p(),
    .DDR_odt(),
    .DDR_ras_n(),
    .DDR_reset_n(),
    .DDR_we_n(),
    .FIXED_IO_ddr_vrn(),
    .FIXED_IO_ddr_vrp(),
    .FIXED_IO_mio(),
    .FIXED_IO_ps_clk(temp_clk),
    .FIXED_IO_ps_porb(temp_rstn),
    .FIXED_IO_ps_srstb(temp_rstn),
    .LED_tri_o(LED),
    .GPI_tri_i(LED)
  );

  //
  initial begin
    $monitor($stime, " : [LED] 0x%01x", LED);
  end

  // svPlWrite
  export "DPI-C" function svPlWrite ;

  reg GP0WriteTaskEnable = 0;
  reg [31:0] GP0Address;
  reg [31:0] GP0WriteData;
  reg GP0Resp;
  function int svPlWrite(input int address, input int data) ;
    GP0Address   = address;
    GP0WriteData = data;
    GP0WriteTaskEnable = 1;
    return  0;
  endfunction

  always begin
    wait(GP0WriteTaskEnable == 1);
    GP0WriteTaskEnable = 0;
    $display("svPlWrite(%x,%x)", GP0Address, GP0WriteData);
    tb_Zynq7000.zynq_sys.Zynq7000_i.processing_system7_0.inst.write_data(GP0Address, 4, GP0WriteData, GP0Resp);
  end

  // svStopSim
  export "DPI-C" function svStopSim ;

  reg StopSimTaskEnable = 0;
  function int svStopSim() ;
    StopSimTaskEnable = 1;
    return  0;
  endfunction

  always begin
    wait(StopSimTaskEnable == 1);
    StopSimTaskEnable = 0;
    #1000;
    $display("svStopSim()");
    $stop;
  end

/*
// ERROR: [VRFC 10-75] taskTest is not a task [/home/hidemi/nfs/workspace/SystemVerilog/tb_Zynq7000.sv:151]
  export "DPI-C" function taskTest ;

  task taskTest;
    input [31:0] din;
    output [31:0] dout;
    reg [31:0] data;
    begin
      $display("testTask");
      data <= din;
      dout <= din;
    end
  endtask
*/

endmodule
