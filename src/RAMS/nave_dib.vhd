-- Esta ser� la RAM donde almacenaremos la pantalla principal
-- La pantalla principal es una imagen de dimensiones 256x128 (ancho x alto), almacenada en un archivo .data
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use std.textio.all;
use work.tipos.all;

entity nave_dib is
    port (clk 		:	in std_logic;
          addr1 	:	in std_logic_vector(7 downto 0);
			 
          do1 : out std_logic
	);
end nave_dib;

architecture circuito  of nave_dib is
	-- El tipo ram es un array con capacidad para todos los valores que conforman la imagen .data
   --	Tipos de la RAM
	-- 16x16
	type RamType is array(0 to 255) of bit_vector(0 downto 0);
	
	-- Funcion que rellena de datos la RAM
	impure function InitRamFromFile (RamFileName : in string) return RamType is	
		FILE RamFile : text is in RamFileName;
		variable RamFileLine : line;
		variable RAM : RamType;
	
		begin
		for I in RamType'range loop
			readline (RamFile, RamFileLine);
			read (RamFileLine, RAM(I));
		end loop;
		return RAM;														-- Devuelve una RAM llena con los datos del archivo que le 
	end function;
	signal RAM : RamType := InitRamFromFile("nave.data");
	-- Se supone que aqu� ya est�n los datos dentro de la RAM
	
begin

   puerto1: process (clk)
	begin
        if rising_edge(clk) then
            do1 <= to_stdlogicvector(RAM(conv_integer(addr1)))(0);
        end if;
    end process puerto1;
end circuito;
