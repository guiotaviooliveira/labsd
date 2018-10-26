library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fulladder_4bit is
end tb_fulladder_4bit;

architecture test of tb_fulladder_4bit is
	component fulladder_4bit is 
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
	end component fulladder_4bit;
	
	signal sa0  : std_logic;
	signal sa1  : std_logic;
	signal sa2  : std_logic;
	signal sa3  : std_logic;
	
	signal sb0  : std_logic;
	signal sb1  : std_logic;
	signal sb2  : std_logic;
	signal sb3  : std_logic;
	
	signal ss0  : std_logic;
	signal ss1  : std_logic;
	signal ss2  : std_logic;
	signal ss3  : std_logic;
	
	signal scin  : std_logic := '0';
	signal scout : std_logic;
	
begin
	instancia_fulladder_4bit: fulladder port map(
				a_0 =>sa0,
				a_1 =>sa1,
				a_2 =>sa2,
				a_3 =>sa3,

				b_0 =>sb0,
				b_1 =>sb1,
				b_2 =>sb2,
				b_3 =>sb3,

				s_0 =>ss0,
				s_1 =>ss1,
				s_2 =>ss2,
				s_3 =>ss3,
				
				Cin_4 =>scin,
				Cout_4 =>scout
		);
		sa0<='1';
		sa1<='1';
		sa2<='1';
		sa3<='0';
		
		sb0<='1';
		sb1<='1';
		sb2<='1';
		sb3<='0';
end test;