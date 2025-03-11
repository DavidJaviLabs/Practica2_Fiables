library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_3 is
    port(
        clk         : in  std_logic;
        ena         : in  std_logic;  -- reset asíncrono (activo en '0')
        f_div_25   : out std_logic;  -- salida de 25MHz (100MHz/4)
        f_div_12_5  : out std_logic;  -- salida de 12.5MHz (100MHz/8)
        f_div_5   : out std_logic   -- salida de 5MHz (100MHz/20)
    );
end entity divisor_3;

architecture Behavioral of divisor_3 is
     -- Contador de módulo 4
     signal count4 : unsigned(1 downto 0) := (others => '0');
     -- Contador de módulo 8 (para dividir la señal de 25MHz a 12.5MHz)
     signal count2 : unsigned(2 downto 0) := (others => '0');
     -- Contador de módulo 20 (para dividir la señal de 25MHz a 5MHz)
     signal count5 : unsigned(4 downto 0) := (others => '0');
begin
    -- División por 4 (100MHz -> 25MHz)
    process(clk, ena)
        begin
            if ena = '0' then
                count4 <= (others => '0');
                f_div_25 <= '1';
            elsif rising_edge(clk) then
                if count4 = 3 then
                    count4 <= (others => '0');
                    f_div_25 <= '1';
                else
                    count4 <= count4 + 1;
                    f_div_25 <= '0';
                end if;
            end if;
    end process;

     -- División por 8 (100MHz -> 12.5MHz)
     process(clk, ena)
        begin
            if ena = '0' then
                count2 <= (others => '0');
                f_div_12_5 <= '1';
            elsif rising_edge(clk) then
                if count2 = 7 then
                    count2 <= (others => '0');
                    f_div_12_5 <= '1';
                else
                    count2 <= count2 + 1;
                    f_div_12_5 <= '0';
                end if;
            end if;
    end process;
    
    -- División por 20 (100MHz -> 5MHz)
    process(clk, ena)
        begin
            if ena = '0' then
                count5 <= (others => '0');
                f_div_5 <= '1';
            elsif rising_edge(clk) then
                if count5 = 19 then
                    count5 <= (others => '0');
                    f_div_5 <= '1';
                else
                    count5 <= count5 + 1;
                    f_div_5 <= '0';
                end if;
            end if;
    end process;
end Behavioral;
