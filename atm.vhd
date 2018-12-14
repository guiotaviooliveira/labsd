	library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity atm is
	port( 
		CLK, RESET, CARD, ENTER	: in std_logic;					
		NUMKEY : in std_logic_vector(15 downto 0);
		notas_100, notas_50, notas_20, notas_10, notas_5, notas_2, notas_1 : out std_logic_vector(15 downto 0)
	);
end atm;

architecture atm_arch of atm is
	
	component controle is
		port( 
			CLK, RESET, CARD, ENTER, senhacheck: in std_logic;					
			NUMKEY: in std_logic_vector(15 downto 0);
			valor, senha: out std_logic_vector(15 downto 0);
			op, clr: out std_logic;
		);
	end component;

	
	component operacional is
		port(
			CLK,CLR, op : in std_logic;
			valor, senha, valor_disponivel: in std_logic_vector(15 downto 0);
			n100, n50, n20, n10, n5, n2, n1, vdisponivel, checksenha: out std_logic_vector(15 downto 0)
		);	
	end component;
	
	signal 
begin
	instacia_controle: controle port map()
end atm_arch;