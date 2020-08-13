#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"

#define EOF %(~1)

fn cmon_man{n:pos} (n : int(n)) : size_t(n) = $UN.cast(n)

(* "parse" the command line args *)
fn tabstop{n,d:pos}
(argc :int(n), argv : !argv(n), default : int(d))
: [m:pos] int(m) 
= if argc < 2 then default else case g1ofg0(g0string2int(argv[1])) of
| a => if a <= 0 then default else a

fn detab{n:pos} (tabstop : int(n)) : void =
let implement string_tabulate$fopr<> (i) = ' '
    val fill = string_tabulate(cmon_man(tabstop))
    fun lp (fill : string(n)) : void = case fileref_getc(stdin_ref) of
    | EOF => ()
    | 9 => begin print(fill); lp (fill) end
    | x => begin fileref_putc(stdout_ref,x); lp (fill) end
in lp (strnptr2string(fill)) end

implement main0 (argc, argv) = detab(tabstop(argc,argv,4))
