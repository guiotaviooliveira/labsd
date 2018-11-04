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
use ieee.numeric_std.all;

entity pgblock is
	port (
			a	: in  std_logic_vector(7 downto 0);
			b	: in  std_logic_vector(7 downto 0);
			g0	: out std_logic_vector(7 downto 0);
			p0	: out std_logic_vector(7 downto 0)
		);
end pgblock;

architecture arch_pgblock of pgblock is
begin
	g0 <= (a and b);
	p0 <= (a xor b);
end arch_pgblock;