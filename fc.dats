#include "share/atspre_staload.hats"

#define STEP 20.0
#define LOW %(~100.0)
#define HIGH 100.0

fn farenheit_of_celcius (t : double) : double = t*1.8 + 32
fn celcius_of_farenheit (t : double) : double = (t - 32) / 1.8

implement main0 () = 
let var t:double
 in for (t := ~100.0; t <= 100.0; t := t + 20.0) begin
      $extfcall(void,"printf","%.1f\t%.3f\n",t,farenheit_of_celcius(t))
   end
end
 