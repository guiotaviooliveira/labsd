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

entity tb_aula10 is
end tb_aula10;

architecture test of tb_aula10 is
	constant size : natural := 4;
	component aula10 
		port(
			x  : in  std_logic_vector(size-1 downto 0);
			y  : out std_logic_vector(size-1 downto 0)	
		);
	end component;
	signal a, b: std_logic_vector(size-1 downto 0) := (others=>'0');
begin
	t1: aula10 port map(a,b);
	a <= std_logic_vector( unsigned(a) + 1 ) after 2 ns;
end test;