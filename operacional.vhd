zlibrary ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operacional is
	port(
		CLK,CLR, op : in std_logic;
		valor, senha, valor_disponivel: in std_logic_vector(15 downto 0);
		n100, n50, n20, n10, n5, n2, n1, vdisponivel, checksenha: out std_logic_vector(15 downto 0)
	);
	
end operacional;

architecture arch_operacional of operacional is
	
	component reg is
		PORT(
			 d   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			 ld  : IN STD_LOGIC; -- load/enable.
			 clr : IN STD_LOGIC; -- async. clear.
			 clk : IN STD_LOGIC; -- clock.
			 q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) -- output
		);
	end component;
	
	signal senha : std_logic_vector(15 downto 0) := "1000000000000000";
	signal load : std_logic := '0';

begin
	instance_valor_disponivel: reg port map (vdisponivel, load, clr, CLK, valor_disponivel);
	process(op, vsaque, vdeposito, clr) is
		variable TMP : unsigned(15 downto 0);
	begin
		if(clr = '1') then
			load = '0';
		else 
			case op is
					when '0' =>
						vdisponivel <= valor_disponivel + valor;
						load = '1';
					when '1' =>
						if(valor <= valor_disponivel and clr = '0') then
							vdisponivel <= valor_disponivel - valor;
							n100 <= std_logic_vector(UNSIGNED(valor)/100);
							TMP := UNSIGNED(valor) rem 100;
							n50 <= std_logic_vector(TMP/50);
							TMP := TMP rem 50;
							n20 <= std_logic_vector(TMP/20);
							TMP := TMP rem 20;
							n10 <= std_logic_vector(TMP/10);
							TMP := TMP rem 10;
							n5 <= std_logic_vector(TMP/5);
							TMP := TMP rem 5;
							n2 <= std_logic_vector(TMP/2);
							TMP := TMP rem 2;
							n1 <= std_logic_vector(TMP);
						elsif (clr = '1');
							notas_100 <= "0000000000000000";
							notas_50  <= "0000000000000000";
							notas_20  <= "0000000000000000";
							notas_10  <= "0000000000000000";
							notas_5   <= "0000000000000000";
							notas_2   <= "0000000000000000";
							notas_1   <= "0000000000000000";
						end if;
			end case;
		end if;
	end process;
	
	process(senha)
	begin
		if(senha = const_senha) then
			checksenha <= '1';
		else
			checksenha <= '0'
		end if;
	end process;
end arch_operacional;