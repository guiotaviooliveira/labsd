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

entity brentkung is
	port (
		a	  	: in  std_logic_vector(7 downto 0);
		b	  	: in  std_logic_vector(7 downto 0);
		cin	: in  std_logic;
		sum 	: out std_logic_vector(7 downto 0);
		cout	: out std_logic
	);
end brentkung;

architecture arch_brentkung of brentkung is
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
 	
	signal G1,P1 : std_logic_vector(3  downto 0);
	signal G2,P2 : std_logic_vector(3  downto 0);
	signal G3,P3 : std_logic;
	signal G4,P4 : std_logic;
	signal G5,P5 : std_logic_vector(2  downto 0);
	
	signal g0,p0: std_logic_vector(7 downto 0);
	signal c,pf	 : std_logic_vector(7 downto 0);
	signal gf: std_logic;
	
	begin
		k0:  pgblock port map (a, b, g0, p0);
				
		s11: innerpgblock port map (g0(0), p0(0), g0(1), p0(1), G1(0),P1(0));
		s12: innerpgblock port map (g0(2), p0(2), g0(3), p0(3), G1(1),P1(1));
		s13: innerpgblock port map (g0(4), p0(4), g0(5), p0(5), G1(2),P1(2));
		s14: innerpgblock port map (g0(6), p0(6), g0(7), p0(7), G1(3),P1(3));

		s21:  innerpgblock port map (G1(0), P1(0), G1(1), P1(1), G2(0),P2(0));
		s22:  innerpgblock port map (G1(2), P1(2), G1(3), P1(3), G2(1),P2(1));

		s31:  innerpgblock port map (G2(0), P2(0), G2(1), P2(1), G3, P3);

		s41:  innerpgblock port map (G2(0), P2(0), G1(2),P1(2), G4, P4);
		
		s51:  innerpgblock port map (G1(0), P1(0), g0(2), p0(2), G5(0), P5(0));
		s52:  innerpgblock port map (G2(0), P2(0), g0(4), p0(4), G5(1), P5(1));
		s53:  innerpgblock port map (G4, P4, g0(6), p0(6), G5(2), P5(2));
		
	    t1:   buf port map (g0(0), c(0));
		t2:   buf port map (G1(0), c(1));
		t3:   buf port map (G5(0), c(2));
		t4:   buf port map (G2(0), c(3));
		t5:   buf port map (G5(1), c(4));
		t6:   buf port map (G4   , c(5));
		t7:   buf port map (G5(2), c(6));
		t8:   buf port map (G3   , gf  );

		t9:   buf port map (p0(0), pf(0));
		t10:  buf port map (P1(0), pf(1));
		t11:  buf port map (P5(0), pf(2));
		t12:  buf port map (P2(0), pf(3));
		t13:  buf port map (P5(1), pf(4));
		t14:  buf port map (P4   , pf(5));
		t15:  buf port map (P5(2), pf(6));
		t16:  buf port map (P3   , pf(7));	
		
		m1:  sumblock port map (pf(0),  cin,  sum(0));
		m2:  sumblock port map (pf(1),  c(0),  sum(1));
		m3:  sumblock port map (pf(2),  c(1),  sum(2));
		m4:  sumblock port map (pf(3),  c(2),  sum(3));
		m5:  sumblock port map (pf(4),  c(3),  sum(4));
		m6:  sumblock port map (pf(5),  c(4),  sum(5));
		m7:  sumblock port map (pf(6),  c(5),  sum(6));
		m8:  sumblock port map (pf(7),  c(6)  , sum(7));
		
		t17: buf port map (gf, cout);

end arch_brentkung;
