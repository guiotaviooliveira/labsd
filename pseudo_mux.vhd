-- pseudo_mux - A Finite State Machine that mimics the behavior of mux
-- Copyright (C) 2018  Digital Systems Group - UFMG
-- 
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, see <https://www.gnu.org/licenses/>.
--

library ieee;
use ieee.std_logic_1164.all;

entity pseudo_mux is
    port (
        RESET   : in    std_logic; -- reset input
        CLOCK   : in    std_logic; -- clock input
        s       : in    std_logic; -- control input
        A,B,C,D : in    std_logic; -- data inputs
        q       : out   std_logic  -- data output
    );
end pseudo_mux;

architecture arch of pseudo_mux is
	type State_type is (S0, S1, S2, S3);
	signal y : State_type;
	
	begin
		process(RESET, CLOCK )
			begin
				if RESET = '0' then 
					y <= S0;
				elsif (Clock'event and Clock = '1') then
					case y is
						when S0 =>
							if s = '0' 
								then y <= S0;
								else y <= S1;
							end if;
						when S1 =>
							if s = '0' 
								then y <= S1;
								else y <= S2;
							end if;
						when S2 =>
							if s = '0' 
								then y <= S2;
								else y <= S3;
							end if;
						when S3 =>
							if s = '0' 
								then y <= S3;
								else y <= S0;
							end if;
					end case;
				end if;
		end process;
		
		process (y, A, B, C, D)
			begin
				if y = S0 then
					q <= A;
				elsif y = S1 then
					q <= B;
				elsif y = S2 then
					q <= C;
				elsif y = S3 then
					q <= D;
				end if;
		end process;

end arch;
