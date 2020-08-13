#include "share/atspre_staload.hats"

fn farenheit_of_celcius (t : double) : double = t*1.8 + 32

implement main0 () = 
let var t:double
    val _ = println!("CELCIUS\tFARENHEIT")
 in for (t := ~100.0; t <= 100.0; t := t + 20.0) begin
      $extfcall(void,"printf","%.1f\t%.1f\n",t,farenheit_of_celcius(t))
   end
end
 