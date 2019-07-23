module mainProject(
	input  clock,
	input rx_ESP,
	output tx_ESP
);

Project2 processor(
  .clk_clk       (clock),       //clk.clk
  .uart_RXD      (rx_ESP),      //rxd
  .uart_TXD      (tx_ESP)       //txd
 );
endmodule	 