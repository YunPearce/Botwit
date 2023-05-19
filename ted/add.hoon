/-  spider
/+  *strandio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
;<  our=@p   bind:m  get-our
=/  arg  !<([~ keys=(map @t @t) sec=@t key=@t] arg)
=/  tkn         (~(got by keys.arg) 'oauth_token') 
=/  tkn-secret  (~(got by keys.arg) 'oauth_token_secret')
=/  id          (~(got by keys.arg) 'user_id')
=/  secret      (weld (trip sec.arg) (weld "&" (trip tkn-secret)))
=/  =vase    !>([tkn secret key.arg])
=/  id-vase  !>([tkn secret id key.arg])
;<  ~        bind:m  (poke [our %gato] :-(%add !>(['tweet' :-(:-(%botwit %tweet) vase)])))
;<  ~        bind:m  (poke [our %gato] :-(%add !>(['profile' :-(:-(%botwit %profile) vase)])))
;<  ~        bind:m  (poke [our %gato] :-(%add !>(['notify' :-(:-(%botwit %notify-timer) id-vase)])))
(pure:m !>(~))