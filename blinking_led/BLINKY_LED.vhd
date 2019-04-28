----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2019 11:36:51 AM
-- Design Name: 
-- Module Name: BLINKY_LED - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: uses a counter that will blink all the LED on/off at a regular
--              
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BLINKY_LED is

    Generic (
        NUM_LEDS    : integer :=4;
        CLK_RATE    :integer  :=100000000;
        BLINK_RATE  :integer  :=2);
        
    Port (
        Led_out     : out std_logic_vector(NUM_LEDS -1 downto 0);
        CLK         : in  std_logic;
        Reset       : in  std_logic);
        
--  Port ( );
end BLINKY_LED;

architecture Behavioral of BLINKY_LED is

constant MAX_VAL    : integer := CLK_RATE/BLINK_RATE;

--calculate the number of bits required to count 'MAX_VAL'
constant BIT_DEPTH  : integer :=integer(ceil(log2(real(MAX_VAL))));

signal count_reg : unsigned (BIT_DEPTH -1 downto 0) := (others => '0');

signal Led_reg    : std_logic_vector( NUM_LEDS -1 downto 0) := "0000";

begin 

----- Assign output LED values
Led_out <=led_reg;

count_proc :process (CLK)

begin

if rising_edge(CLK) then

    if((Reset = '0') or (count_reg)=MAX_VAL) then 
    
        count_reg <= (others => '0');
      
     else 
     
        count_reg <= count_reg +1;
       
      end if;
     
 end if;
  
end process count_proc;



output_process : process (CLK)

begin

    if rising_edge(CLK) then
    
        if (count_reg= MAX_VAL) then
        
        led_reg <= NOT led_reg;
        
        end if;
     end if;
end process output_process ;

end Behavioral;
