package body unit is

   function isPositive( X : Integer ) return Boolean is
   begin
      if X < 0 then
         return False;
      else
         return True;
      end if;
   end isPositive;

end unit;

