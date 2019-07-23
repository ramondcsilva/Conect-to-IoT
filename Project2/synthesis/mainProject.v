module mainProject(
	input  clock,
	input rx_ESP,
	output tx_ESP,
	input [11:0]buttons,
	output lcd_bl,
	output lcd_en,
	output lcd_rs,
	output lcd_rw,
	output [7:0]lcd_db
);

Project2 processor(
  .clk_clk       (clock),       	//clk.clk
  .uart_RXD      (rx_ESP),      	//rxd
  .uart_TXD      (tx_ESP),       	//txd
  .btn_export (buttons), 			//  btn.export
  .lcd_bl     (lcd_bl),     		//  lcd.bl
  .lcd_rs     (lcd_rs),     		//     .rs
  .lcd_rw     (lcd_rw),     		//     .rw
  .lcd_en     (lcd_en),     		//     .en
  .lcd_db     (lcd_db[7:0])      		//     .db  
 );
endmodule	 