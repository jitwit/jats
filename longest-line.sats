(* keeping to be reminder of difference between prval and val. 
   thence a terrible error. *)
praxi
lsp
  {l:addr}{n:int}
(
  x: !strnptr (l, n)
) : [(l>null&&n>=0) || (l==null&&n==(~1))] void
// end of [lemma_strnptr_param]
