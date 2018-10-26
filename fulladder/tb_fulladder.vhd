library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fulladder is
end tb_fulladder;

architecture test of tb_fulladder is
	component fulladder is 
		port ( 
			Cin  : in  std_logic;
			x    : in  std_logic;
			y    : in  std_logic;
			s    : out std_logic;
			Cout : out std_logic
		);
	end component fulladder;
	
	signal S_Cin  : std_logic;
	signal S_x	  : std_logic;
	signal S_y	  : std_logic;
	signal S_s	  : std_logic;
	signal S_Cout : std_logic;
	
begin
	instancia_fulladder : fulladder port map(
				Cin  => S_Cin,
				x    => S_x,
				y    => S_y,
				s 	  => S_s,
				Cout => S_Cout
		);
	
end test;