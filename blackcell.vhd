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

entity blackcell is
	port (
			g0	: in  std_logic;
			p0	: in  std_logic;
			g1	: in  std_logic;
			p1	: in  std_logic;
			G	: out std_logic;
			P	: out std_logic
		);
end blackcell;

architecture behavioral of blackcell is
begin
	G <= (g1 or(g0 and p1));
	P <= (p0 and p1);
end behavioral;