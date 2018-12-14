library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_atm is
end tb_atm;

architecture teste of tb_atm is
	
	component atm is	
		port( 
			CLK, RESET, CARD, ENTER	: in std_logic;					
			NUMKEY 						: in std_logic_vector(15 downto 0)
			
		);
	end component;
	
	signal SCLK, SRESET, SCARD, SENTER : std_logic := '0';
	signal SNUMKEY, SN100, SN50, SN20, SN10, SN5, SN2, SN1 : std_logic_vector(15 downto 0);
	
begin

	instancia_atm	:	atm port map (SCLK, SRESET, SCARD, SENTER,SNUMKEY, SN100, SN50, SN20, SN10, SN5, SN2, SN1);
	SNUMKEY <= "0000000000000000";
	SCLK  <= not SCLK after 5 ns;
	SRESET <= '1', '0' after 5 ns;
	SCARD 	<= '1' after 10 ns;
	SNUMKEY <= "0000000000000010" after 12 ns;
	SENTER <= '1' after 12 ns, '0' after 16 ns; 
	SNUMKEY <= "0000000000000000" after 18 ns;
	SENTER <= '1' after 18 ns, '0' after 21 ns;
	SNUMKEY <= "0000000000000100" after 23 ns;
	SENTER <= '1' after 23 ns, '0' after 26 ns;

end teste;