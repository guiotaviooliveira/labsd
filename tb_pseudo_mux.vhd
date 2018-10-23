library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pseudo_mux is
end tb_pseudo_mux;

-- Implement the testbench and find the errors in this model.
-- Consider the following expected behavior:
--      Every rising edge of CLK input, the content of INPUT
--      is added to a register chain and used to calculate the
--      mean value over 4 clock periods

architecture test of tb_pseudo_mux is
	component pseudo_mux is 
		 port (
			  RESET   : in    std_logic; -- reset input
			  CLOCK   : in    std_logic; -- clock input
			  s       : in    std_logic; -- control input
			  A,B,C,D : in    std_logic; -- data inputs
			  q       : out   std_logic  -- data output
		 );
	end component pseudo_mux;
	
	signal S_CLK	 				 : std_logic := '0';
	signal S_RESET	 				 : std_logic := '0';
	signal S_s	 					 : std_logic := '0';
	signal S_A, S_B, S_C, S_D	 : std_logic;
	signal S_q 						 : std_logic;
	
begin
	instancia_mux : pseudo_mux port map(
				CLOCK	=> S_CLK,
				RESET => S_RESET,
				A 		=> S_A,
				B 		=> S_B,
				C 		=> S_C,
				D 		=> S_D,
				s 		=> S_s,
				q 		=> S_q
		);
	S_A <= '1';
	S_B <= '0';
	S_C <= '1';
	S_D <= '0';
	S_CLK <= not S_CLK after 5 ns;
	S_RESET <= '1' after 1 ns;
	S_s <= not S_s after 10 ns;
	
end test;