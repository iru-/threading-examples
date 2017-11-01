define stk
  x/gx $rbp
  x/gx $rbp+8
  x/gx $rbp+16
  x/gx $rbp+24
end

# REG    FUNCTION
# r8     IP
# r9     W
# r10    X
# rsp    R

define state
  print/z $r8
  print/z $r9
  print/z $r10
  print/z $rsp
end

define go
  step
  state
end

break _start
run
