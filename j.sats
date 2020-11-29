
%{
typedef long long I;
extern I *jshp (I addr,I rank) {
  I *sh = malloc(sizeof(I)*rank), *jptr = (I*) addr;
  for(int i=0;i<rank;i++) sh[i] = jptr[i];
  return sh;
}
%}

fn jshp (p:llint, r:llint) : [l:addr][r:nat] arrayptr(llint,l,r) = "ext#"