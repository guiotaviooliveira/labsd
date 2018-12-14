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

	type estado is (st_inicio, st_senha, st_acesso, st_saque, st_retirar, st_deposito, st_espera, st_valordeposito);
	signal estado_atual, proximo_estado: estado := st_inicio;
	signal valor_disponivel, valor_saque, aux: unsigned(15 downto 0);
	signal senha : unsigned(15 downto 0):= "0000000000000010"; 
begin
	process(CLK, RESET) is
	begin
		if (RESET = '1') then
			estado_atual <= st_inicio;
		elsif(RESET = '0' and rising_edge(CLK)) then
			estado_atual <= proximo_estado;
		end if;
	end process;
	
	process(CLK, ENTER) is
	begin
		case estado_atual is
			when st_inicio =>
				if(CARD = '1') then
					proximo_estado <= st_senha;
				else 
					proximo_estado <= st_inicio;
				end if;
				
			when st_senha =>
				if(NUMKEY = senha and ENTER = '1') then
					proximo_estado <= st_acesso;
				elsif(not(NUMKEY = senha) and ENTER = '1') then
					proximo_estado <= st_inicio;
				else 
					proximo_estado <= st_senha;
				end if;
			
			when st_acesso =>		
				if(NUMKEY = "0000000000000000" and ENTER = '1') then
					proximo_estado <= st_deposito;
				elsif(NUMKEY = "0000000000000001" and ENTER = '1') then
					proximo_estado <= st_saque;
				else 
					proximo_estado <= st_acesso;
				end if;
			
			when st_deposito =>
				if(NUMKEY >= "0000000000000000" and ENTER = '1') then
					valor_disponivel <= valor_disponivel + NUMKEY;
					proximo_estado <= st_valordeposito;
				else
					proximo_estado <= st_deposito;
				end if;
				
			when st_valordeposito =>
				if(NUMKEY > "0000000000000000" and ENTER = '1') then
					valor_disponivel <= valor_disponivel + NUMKEY;
					proximo_estado <= st_espera;
				else
					proximo_estado <= st_valordeposito;
				end if;
			when st_saque =>
				if(NUMKEY <= valor_disponivel and ENTER = '1') then
					valor_disponivel <= valor_disponivel - NUMKEY;
					proximo_estado <= st_retirar;
				else
					proximo_estado <= st_saque;
				end if;
			
			when st_retirar =>
				if(ENTER = '1') then
					proximo_estado <= st_espera;
				else 
					proximo_estado <= st_retirar;
				end if;
				
			when st_espera =>
				if(ENTER = '1') then
					proximo_estado <= st_inicio;
				else 
					proximo_estado <= st_espera;
				end if;
		end case;
		
	end process;
	
	process(estado_atual) is
	begin
		if(estado_atual = st_retirar) then
			notas_100 <= valor_saque/100;
			aux <= valor_saque rem 100;
			notas_50 <= aux/50;
			aux <= aux rem 50;
			notas_20 <= aux/20;
			aux <= aux rem 20;
			notas_10 <= aux/10;
			aux <= aux rem 10;
			notas_5 <= aux/5;
			aux <= aux rem 5;
			notas_2 <= aux/2;
			aux <= aux rem 2;
			notas_1 <= aux/1;
		end if;
	end process;
	
	--proces(CLK, op, 
end atm_arch;