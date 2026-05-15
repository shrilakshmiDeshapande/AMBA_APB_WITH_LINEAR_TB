module apb_tb;

  reg pclk,presetn,transfer,write;

  reg [31:0] indata,inaddress;

  

  wire [2:0] psel;

  wire pwrite;

  wire [2:0]penable;

  wire pready;

  wire [31:0]paddr,prdata,pwdata;

  

  apb_top dut(pclk,presetn,transfer,write,paddr,pwrite,penable,psel,pwdata,indata,inaddress,prdata,pready);

  

  initial begin

    pclk=0;

  end

  always #5 pclk=~pclk;

  

  initial begin

    presetn=0;

    transfer=0;

    write=1;

    indata=32'h0100;

    inaddress=32'h0011;

    

    #30;

    presetn=1;

    transfer=1;

    

    #60;

    write=0;

    

    

    #200;

$finish;

  end

  

   initial begin

     $dumpfile("apb_top.vcd");

     $dumpvars(0,apb_tb);

  end

endmodule
