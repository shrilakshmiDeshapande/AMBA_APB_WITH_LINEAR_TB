module apb_master(pclk,presetn,psel,penable,paddr,pwrite,pwdata,prdata,transfer, indata,inaddress,pready,write);

  input pclk,presetn,transfer,write;

  output reg [31:0]paddr;

  output reg pwrite;

  output reg [2:0]penable;

  output reg [2:0] psel;

  output  reg [31:0]pwdata;

  input [31:0] indata,inaddress;

  input [31:0] prdata;

  input pready;

 

  reg [31:0] rd_data;

 

  

  parameter IDLE = 2'b00;

  parameter SETUP = 2'b01;

  parameter ACCESS = 2'b10; 

  

  reg [1:0] state = IDLE;

 

  reg [2:0] sel;

  

  always@(posedge pclk)

    begin

      if(!presetn)

        begin

          psel <= 0;

          penable <= 0;

          paddr <= 0;

          pwrite <= 0;

          pwdata <= 0;

        end

      else 

        begin

          case(state)

            IDLE : begin 

              psel <= 0;

              penable <= 0;

              if(transfer) begin

				state <= SETUP;

                paddr <= inaddress;

              end

              else

                state <= IDLE;

            end

            

            SETUP : begin

              if(inaddress > 0 && inaddress < 32'h11111111)

                begin

                	psel[0] <= 1;

                    state <= ACCESS;

                  sel = 0;

                end

              else if(inaddress >32'h11111111 && inaddress < 32'h22222222)

                begin

                  psel[1] <= 1;

                    state <= ACCESS;

                  sel = 1;

                end

              else if(inaddress > 32'h22222222 && inaddress < 32'h33333333)

                begin

                  psel[2] <= 1;

                    state <= ACCESS;

                  sel <= 2;

                end

              else

                state <= IDLE;



              pwdata <= indata;

              pwrite <= write;

            end

            

            ACCESS : begin

              penable[sel] <= 1;

              if(penable[sel] && pready[sel])

                begin

                  if(pwrite)

                    begin

                    state <= IDLE;

                    psel <= 0;

                    end

                  else

                    begin

                      rd_data <= prdata;

                      state <= IDLE;

                      psel <= 0;

                    end

                end

              else

                state <= ACCESS;

            end

            default:

             state <= IDLE;

          endcase

        end

    end

endmodule


