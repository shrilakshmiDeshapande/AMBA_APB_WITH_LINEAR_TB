module apb_slave(pclk,presetn,psel,penable,paddr,pwdata,prdata,pready,pwrite);

  input pclk,presetn;

  input [2:0]penable;

  input pwrite;

  input [2:0] psel;

  output reg pready;

  output reg [31:0]prdata;

  input [31:0]paddr,pwdata;

  

  reg [31:0] write,address;

  

  

  parameter IDLE = 2'b00;

  parameter SETUP = 2'b01;

  parameter ACCESS = 2'b10;

  

  reg [1:0] state = IDLE;

  

  always@(posedge pclk)

    begin

      if(!presetn)

        begin

          pready = 0;

          prdata = 0;

        end

      else 

        begin

          case(state)

            IDLE : begin

              pready = 0;

              if(psel)

                state <= SETUP;

              else

                state <= IDLE;

            end

            

            SETUP : begin

               //prdata <= 32'h44444444;

              if(psel)

                state <= ACCESS;

              else

                state <= SETUP;

            end

            

            ACCESS : begin

              pready = 1;

            

              if(penable && pready)

                begin

                  if(pwrite)

                    begin

                      write <= pwdata;

                      address <= paddr;

                      state <= IDLE;

                    end

                  else

                    begin

                    prdata <= 32'h44444444;

                    state <= IDLE;

                    end

                end

            end

          endcase

        end

    end

endmodule
