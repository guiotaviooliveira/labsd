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
use ieee.NUMERIC_STD.all;

entity aula10 is 
	generic(
		r     : natural :=  2;
		size  : natural :=  4
	);

	port(
		x  : in  std_logic_vector(size-1 downto 0);
		y  : out std_logic_vector(size-1 downto 0)	
	);
end aula10;

architecture behavior of aula10 is
	SIGNAL aux : std_logic_vector (size-1 downto 0);
begin
	aux <= (not x);
	y <= STD_LOGIC_VECTOR(resize(((r*(UNSIGNED(x)))*(UNSIGNED(aux))),size));
	-- y <= resize(((r*x)*(aux)),size);
	-- y <= ((r*x)*(aux));
end behavior;