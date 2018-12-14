	library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controle is
	port( 
		CLK, RESET, CARD, ENTER, senhacheck: in std_logic;					
		NUMKEY: in std_logic_vector(15 downto 0);
		valor, senha: out std_logic_vector(15 downto 0);
		op, clr: out std_logic;
	);
end controle;

architecture controle_arch of controle is

	type estado is (st_inicio, st_senha, st_acesso, st_saque, st_deposito, st_espera);
	signal estado_atual, proximo_estado: estado := st_inicio;

begin
	process(CLK, RESET) is
	begin
		if (RESET = '1') then
			estado_atual <= st_inicio;
		elsif(RESET = '0' and rising_edge(CLK)) then
			estado_atual <= proximo_estado;
		end if;
	end process;
	
	process(CLK, ENTER, estado_atual, CARD, NUMKEY) is
	begin
		case estado_atual is
			when st_inicio =>
				if(CARD = '1') then
					proximo_estado <= st_senha;
				else 
					proximo_estado <= st_inicio;
				end if;
				
			when st_senha =>
				senha <= NUMKEY;
				if(senhacheck = '1' and ENTER = '1') then
					proximo_estado <= st_acesso;
				elsif(senhacheck = '0' and ENTER = '1') then
					proximo_estado <= st_inicio;
				else 
					proximo_estado <= st_senha;
				end if;
			
			when st_acesso =>		
				if(NUMKEY = "0000000000000001" and ENTER = '1') then
					proximo_estado <= st_deposito;
					op <= '0';
				elsif(NUMKEY = "0000000000000010" and ENTER = '1') then
					proximo_estado <= st_saque;
					op <= '1';
				else 
					proximo_estado <= st_acesso;
				end if;
			
			when st_deposito =>
				if(ENTER = '1') then
					valor <= NUMKEY;
					proximo_estado <= st_espera;
				else
					proximo_estado <= st_deposito;
				end if;
			
			when st_saque =>
				if(ENTER = '1') then
					valor <= NUMKEY;
					proximo_estado <= st_espera;
				else
					proximo_estado <= st_saque;
				end if;
			
			when st_espera =>
				if(ENTER = '1') then
					clr <= '1'
					proximo_estado <= st_inicio;
				else 
					proximo_estado <= st_espera;
				end if;
			when others =>
				proximo_estado <= st_espera;
		end case;
		
	end process;
end controle_arch;