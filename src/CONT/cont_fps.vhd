library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL;

entity cont_fps is
    port (
        reset: in STD_LOGIC;
        clk_entrada: in STD_LOGIC; -- reloj de entrada de la entity superior
        clk_salida: out STD_LOGIC; -- reloj que se utiliza en los process del programa principal
		  seed: out std_logic_vector(11 downto 0)
    );
end cont_fps;

architecture divisor_arch of cont_fps is
 SIGNAL cuenta: std_logic_vector(19 downto 0);
 SIGNAL clk_aux, clk: std_logic;
  
  begin

clk<=clk_entrada; 
clk_salida<=clk_aux;
seed <= cuenta(11 downto 0);
  contador:
  PROCESS(reset, clk)
  BEGIN
    IF (reset='1') THEN
      cuenta<= (OTHERS=>'0');
    ELSIF(clk'EVENT AND clk='1') THEN
      IF (cuenta="11001011011100110101") THEN -- 30 fps para la pantalla
      	clk_aux <= not clk_aux;
        cuenta<= (OTHERS=>'0');
      ELSE
        cuenta <= cuenta+'1';
      END IF;
    END IF;
  END PROCESS contador;

end divisor_arch;
