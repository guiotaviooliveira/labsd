LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity fulladder_4bit is
	port ( 
		Cin_4  : in  std_logic;
		
		a_0      : in  std_logic;
		a_1      : in  std_logic;
		a_2		: in  std_logic;
		a_3      : in  std_logic;
		
		b_0      : in  std_logic;
		b_1      : in  std_logic;
		b_2		: in  std_logic;
		b_3      : in  std_logic;
		
		s_0      : out std_logic;
		s_1      : out std_logic;
		s_2      : out std_logic;
		s_3      : out std_logic;
		
		Cout_4 : out std_logic
	);
end fulladder_4bit;

architecture RTL OF fulladder_4bit is
	component fulladder is 
		port ( 
			Cin  : in  std_logic;
			x    : in  std_logic;
			y    : in  std_logic;
			s    : out std_logic;
			Cout : out std_logic
		);
	end component fulladder;
	
	signal c0 : std_logic;
	signal c1	  : std_logic;
	signal c2	  : std_logic;
	signal S_Cin_4	  : std_logic;
	signal S_Cout_4 : std_logic;
begin
	FA0 : fulladder port map(x=>a_0, y=>b_0, Cin=>'0', Cout=>c0);
	FA1 : fulladder port map(x=>a_1, y=>b_1, Cin=>c0, Cout=>c1);
	FA2 : fulladder port map(x=>a_2, y=>b_2, Cin=>c1, Cout=>c2);
	FA3 : fulladder port map(x=>a_3, y=>b_3, Cin=>c2, Cout=>Cout_4);
end RTL ;