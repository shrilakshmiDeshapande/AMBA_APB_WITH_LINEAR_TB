//`include "apb_master.v"

//`include "apb_slave.v"

module apb_top(

  input pclk,presetn,transfer,write,

  output  [31:0]paddr,

  output pwrite,

  output [2:0]penable,

  output [2:0]psel,

  output [31:0]pwdata,

  input  [31:0] indata,inaddress,

  output [31:0] prdata,

  output pready);

 

  apb_master inst1(.pclk(pclk),.presetn(presetn),.transfer(transfer),.write(write),.paddr(paddr),.pwrite(pwrite),.penable(penable),.psel(psel),.pwdata(pwdata),.indata(indata),.inaddress(inaddress),.prdata(prdata),.pready(pready));

  

  apb_slave inst(.pclk(pclk),.presetn(presetn),.penable(penable[0]),.pready(pready[0]),.psel(psel[0]),.pwdata(pwdata),.prdata(prdata),.pwrite(pwrite),.paddr(paddr));

  

endmodule
