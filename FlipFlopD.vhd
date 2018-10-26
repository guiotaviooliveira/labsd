LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity FlipFlopD is
	port( 
			CLK : in std_logic;
			D		: in std_logic;
			Q		: out std_logic
			-- NOT_Q	: out std_logic
	    );
end FlipFlopD;

architecture RTL of FlipFlopD is
begin
	Q <= D when rising_edge(CLK);
end RTL;