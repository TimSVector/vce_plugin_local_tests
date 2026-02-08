package body unit is

   function IsPositive (X : Integer) return Boolean is
   begin
      if X < 0 then
         return False;
      elsif X > 0 and X < 100 then
         return True;
      elsif X > 100 and X < 1000 then
         return True;
      else
         return False;
      end if;
   end IsPositive;

end unit;
