LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity fulladder is
	port ( 
		Cin  : in  std_logic;
		x    : in  std_logic;
		y    : in  std_logic;
		s    : out std_logic;
		Cout : out std_logic
	);
end fulladder;

architecture RTL OF fulladder is
begin
	process(Cin,x,y)
		begin
			if(Cin='0' and x='0' and y='0')then
				s<='0';
				Cout<='0';
			elsif(Cin='0' and x='0' and y='1')then
				s<='1';
				Cout<='0';
			elsif(Cin='0' and x='1' and y='0')then
				s<='1';
				Cout<='0';
			elsif(Cin='0' and x='1' and y='1')then
				s<='0';
			  Cout<='1';
			elsif(Cin='1' and x='0' and y='0')then
				s<='1';
				Cout<='0';
			elsif(Cin='1' and x='0' and y='1')then
				s<='0';
				Cout<='1';
			elsif(Cin='1' and x='1' and y='0')then
				s<='0';
				Cout<='1';
			 else
				s<='1';
				Cout<='1';
			end if;
	end process;
	
end RTL ;