/-  spider
/+  strandio
/+  twit-api
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
!:
;<  date=@da  bind:m  get-time:strandio
;<  eny=@uvJ  bind:m  get-entropy:strandio
=/  input  !<([~ req=request:http] arg)
    ;<  =cord  bind:m  (send-req:twit-api req.input)
    (pure:m !>(cord))