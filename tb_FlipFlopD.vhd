LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity tb_FlipFlopD is
end tb_FlipFlopD;

architecture teste of tb_FlipFlopD is
	component FlipFlopD is
		port( 
			CLK 	: in  std_logic;
			D		: in  std_logic;
			Q		: out std_logic
			-- NOT_Q	: out std_logic
	    );
	end component FlipFlopD;
	
	signal S_CLK 	: std_logic := '0';
	signal S_D	 	: std_logic := '1';
	signal S_Q	 	: std_logic;
	-- signal S_NOT_Q : std_logic;
	
begin
	instancia_FlipFlopD : FlipFlopD port map(
				CLK   => S_CLK,
				D	   => S_D,
				Q	   => S_Q
				-- NOT_Q => S_NOT_Q
		);
	S_CLK <= not S_CLK after 5 ns;
	S_D <=  not S_D after 10 ns;
end teste;