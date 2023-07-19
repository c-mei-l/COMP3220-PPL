with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body Assgn is

-- initialize My)Array with random binary values
procedure Init_Array (Arr: in out BINARY_ARRAY) is
begin
Arr(16) := BINARY_NUMBER(1);

--loop and populate
for Index in 1..15 loop
Arr(Index)  := BINARY_NUMBER(0);
end loop;

end Init_Array;



-- takes a BINARY_ARRAY and prints
procedure Print_Bin_Arr (Arr : in BINARY_ARRAY) is
begin

-- loop through array index and print
for Index in 1..16 loop
Put_Line(BINARY_NUMBER'Image (Arr(Index)));
end loop;

end Print_Bin_Arr;



-- accepts a BINARY_ARRAY and reverses it
procedure Reverse_Bin_Arr (Arr : in out BINARY_ARRAY) is
Reversed_Array : BINARY_ARRAY;
begin

-- loop through and reverse array in new array
for Index in 1..16 loop
Reversed_Array(Index) := Arr(abs(Index - 17));
end loop;

-- loop and initialize new Array
for Index in 1..16 loop
Arr(Index) := Reversed_Array(Index);
end loop;

end Reverse_Bin_Arr;



-- takes integer and converts to BINARY_ARRAY.
function Int_To_Bin(Num : in INTEGER) return BINARY_ARRAY is
   Arr_Output : BINARY_ARRAY;
   Int_Value : INTEGER;
begin
   Int_Value := Num;
   for Index in reverse 1..16 loop
      Arr_Output(Index) := Int_Value mod 2;
      Int_Value := Int_Value / 2;
   end loop;
   return Arr_Output;
end Int_To_Bin;



-- takes a BINARY_ARRAY and converts to Integer
function Bin_To_Int (Arr : in BINARY_ARRAY) return INTEGER is
Int_Output : INTEGER := 0;
Conversion : INTEGER := 0;
Reversed_Array : BINARY_ARRAY := Arr;
begin
Reverse_Bin_Arr(Reversed_Array);
for Index in 0..15 loop
Conversion := 2 ** Index * Reversed_Array(Index + 1);
Int_Output := Int_Output + Conversion;
end loop;
return Int_Output;
end Bin_To_Int;


-- overloaded + operator to accept INTEGER and BINARY_ARRAY, adds and returns BINARY_ARRAY
function "+" (Left : in INTEGER; Right : in BINARY_ARRAY) return BINARY_ARRAY is
begin
   return Int_To_Bin(Left) + Right;
end "+";



-- overloaded + to accept two BINARY_ARRAY, adds and returns BINARY_ARRAY
function "+" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY is
   Sum : INTEGER := 0;
   Carry : BINARY_NUMBER := 0;
   Arr_Output : BINARY_ARRAY;
begin
   for Index in reverse 1..16 loop
      Sum := Left(Index) + Right(Index) + Carry;
      Arr_Output(Index) := Sum mod 2;

      if Sum > 1 then
         Carry := 1;
      else
         Carry := 0;
      end if;
   end loop;
   return Arr_Output;
end "+";



-- overloaded - to subtract BINARY_ARRAY from INTEGER
function "-" (Left : in Integer; Right : in BINARY_ARRAY) return BINARY_ARRAY is
   begin
      return Int_To_Bin(Left) - Right;
   end "-";



-- overloaded - to subtract two BINARY_ARRAY
function "-" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY is
      Twos_Comp : BINARY_ARRAY;
      Arr_Output : BINARY_ARRAY;
   begin
      for Index in 1..16 loop
         Twos_Comp(Index) := (Right(Index) + 1) mod 2;
      end loop;
      Twos_Comp := INTEGER(1) + Twos_Comp;

      Arr_Output := Twos_Comp + Left;
      return Arr_Output;
   end "-";



end Assgn;
