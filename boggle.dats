#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/DATS/linmap_avltree.dats"
staload "libats/SATS/SHARE/linmap.hats"
(* word count post/article/tutorial maybe useful *)

datavtype trie = node of (bool, map(char,trie))

// val empty : trie = node (false, linmap_nil())

fn add (word : charlst_vt, D : !trie) : void = let
  fun lp (word : charlst_vt, D : !trie) : void = case word of
  | ~nil_vt () => let 
  val _ = case D of
  | node (t,_) => !t := true
  in end
  | ~cons_vt(x,ws) => let
  val _ = free(ws)
  in end
  val () = lp (word, D)
in end

fn lc (f : FILEref) : [m:nat] int(m) =
let fun lp{n:nat} (f : FILEref, n : int(n)) : [m:nat|n <= m] int (m) = 
    if fileref_is_eof(f) then n
    else begin free(fileref_get_line_string(f)); lp(f,n+1) end
in lp (f,0) end

implement main0 () = 
let val dict_path = "/home/jrn/code/gobble/cobble/share/collins.txt"
    val dref = fileref_open_exn(dict_path,file_mode_r)
in println!(lc(dref)) end