library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity koggestone is
	port (
		-- Valores a serem somados
		a	  	: in  std_logic_vector(7 downto 0);
		b	  	: in  std_logic_vector(7 downto 0);
		-- Carry In
		cin	: in  std_logic;
		-- Soma
		som 	: out std_logic_vector(7 downto 0);
		-- Carry Out
		cout	: out std_logic
	);
end koggestone;

architecture arch_koggestone of koggestone is
	-- Descrição dos componentes usados
	component buf is
		port (
			g	: in  std_logic;
			c	: out std_logic
		);
	end component;
	
	component innerpgblock is
		port (
			g0	: in  std_logic;
			p0	: in  std_logic;
			g1	: in  std_logic;
			p1	: in  std_logic;
			G	: out std_logic;
			P	: out std_logic
		);
	end component;
	
	component pgblock is
		port (
			a	: in  std_logic_vector(7 downto 0);
			b	: in  std_logic_vector(7 downto 0);
			g0	: out std_logic_vector(7 downto 0);
			p0	: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component sumblock is 
		port (
			P	 : in  std_logic;
			c	 : in  std_logic;
			sum : out std_logic
		);
	
	end component;
 	
	-- Sinais dos 'innerpgblock' de cada nivel
	signal G1,P1 : std_logic_vector(6  downto 0);
	signal G2,P2 : std_logic_vector(5  downto 0);
	signal G3,P3 : std_logic_vector(3 downto 0);
	-- Sinais do 'pgblock'
	signal g0,p0: std_logic_vector(7 downto 0);
	-- Sinais finais de 'g' e 'p'
	signal c,pf	 : std_logic_vector(7 downto 0);
	-- Ultimo sinal de 'g', nosso carry out.
	signal gf: std_logic;
	
	begin
	   -- k0 é a instância que gera os valores g0 e p0 pelo 'pgblock'
		k0:  pgblock port map (a, b, g0, p0);
		-- syx é a instância que gera os valores GY(X) e PY(X) pelo 'innerpgblock'.
		-- Y = Nivel dos blocos, sendo 1 o primeiro e 5 o último
		-- X = Ordem do bit no sinal do nivel, sendo contado da direita pra esquerda
		-- com relação ao design do somador em anexo.
		
		-- Nivel 1
		s11: innerpgblock port map (g0(0), p0(0), g0(1), p0(1), G1(0),P1(0));
		s12: innerpgblock port map (g0(1), p0(1), g0(2), p0(2), G1(1),P1(1));
		s13: innerpgblock port map (g0(2), p0(2), g0(3), p0(3), G1(2),P1(2));
		s14: innerpgblock port map (g0(3), p0(3), g0(4), p0(4), G1(3),P1(3));
		s15: innerpgblock port map (g0(4), p0(4), g0(5), p0(5), G1(4),P1(4));
		s16: innerpgblock port map (g0(5), p0(5), g0(6), p0(6), G1(5),P1(5));
		s17: innerpgblock port map (g0(6), p0(6), g0(7), p0(7), G1(6),P1(6));
		-- Nivel 2
		s21: innerpgblock port map (g0(0), p0(0), G1(1), P1(1), G2(0),P2(0));
		s22: innerpgblock port map (G1(0), P1(0), G1(2), P1(2), G2(1),P2(1));
		s23: innerpgblock port map (G1(1), P1(1), G1(3), P1(3), G2(2),P2(2));
		s24: innerpgblock port map (G1(2), P1(2), G1(4), P1(4), G2(3),P2(3));
		s25: innerpgblock port map (G1(3), P1(3), G1(5), P1(5), G2(4),P2(4));
		s26: innerpgblock port map (G1(4), P1(4), G1(6), P1(6), G2(5),P2(5));
		-- Nivel 3
		s31:  innerpgblock port map (g0(0), p0(0), G2(2), P2(2), G3(0),P3(0));
		s32:  innerpgblock port map (G1(0), P1(0), G2(3), P2(3), G3(1),P3(1));
		s33:  innerpgblock port map (G2(0), P2(0), G2(4), P2(4), G3(2),P3(2));
		s34:  innerpgblock port map (G2(1), P2(1), G2(5), P2(5), G3(3),P3(3));
		-- Aqui transferimos o valor final de 'g' (generate) de cada fio para um 
		-- sinal de 8 bits que irá ser usado para a nossa soma.
	   t1:   buf port map (g0(0), c(0));
		t2:   buf port map (G1(0), c(1));
		t3:   buf port map (G2(0), c(2));
		t4:   buf port map (G2(1), c(3));
		t5:   buf port map (G3(0), c(4));
		t6:   buf port map (G3(1), c(5));
		t7:   buf port map (G3(2), c(6));
		-- O sinal final 'g' do ultimo fio Ã© nosso carry out
		t8:   buf port map (G3(3)   , gf  );
		-- Aqui transferimos o valor final de 'p' (propagate) de cada fio para um 
		-- sinal de 8 bits que irá ser usado para a nossa soma.
		t9:   buf port map (p0(0), pf(0));
		t10:  buf port map (P1(0), pf(1));
		t11:  buf port map (P2(0), pf(2));
		t12:  buf port map (P2(1), pf(3));
		t13:  buf port map (P3(0), pf(4));
		t14:  buf port map (P3(1), pf(5));
		t15:  buf port map (P3(2), pf(6));
		t16:  buf port map (P3(3), pf(7));	
		-- Aqui fazemos nossa soma bit a bit. O bloco soma atua com valores de pf(i)
		-- com c(i-1), sendo c(-1) = cin. O valor Ã© jogado bit a bit no sinal de soma.
		m1:  sumblock port map (pf(0),  cin,   som(0));
		m2:  sumblock port map (pf(1),  c(0),  som(1));
		m3:  sumblock port map (pf(2),  c(1),  som(2));
		m4:  sumblock port map (pf(3),  c(2),  som(3));
		m5:  sumblock port map (pf(4),  c(3),  som(4));
		m6:  sumblock port map (pf(5),  c(4),  som(5));
		m7:  sumblock port map (pf(6),  c(5),  som(6));
		m8:  sumblock port map (pf(7),  c(6),  som(7));
		-- Aqui transferimos o nosso carry out para a saÃ­da cout
		t17: buf port map (gf, cout);

end arch_koggestone;