/-  spider
/+  *strandio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
;<  our=@p   bind:m  get-our
=/  data  !<([~ keys=(map @t @t) sec=@t key=@t flag=[=ship chat=@tas]] arg)
=/  tkn         (~(got by keys.data) 'oauth_token') 
=/  tkn-secret  (~(got by keys.data) 'oauth_token_secret')
=/  secret      (weld (trip sec.data) (weld "&" (trip tkn-secret)))
=/  admin       ship.flag.data
=/  chat        chat.flag.data
=/  =vase       !>([keys=[tkn secret key.data] :~(admin) chat])
=/  act-vase       !>([keys=[tkn secret key.data] :~(admin) chat admin])
;<  ~        bind:m  (poke [our %gato] :-(%add !>(['tweet' :-(:-(%botwit %tweet) vase)])))
;<  ~        bind:m  (poke [our %gato] :-(%add !>(['in' :-(:-(%botwit %in) act-vase)])))
;<  ~        bind:m  (poke [our %gato] :-(%add !>(['out' :-(:-(%botwit %out) act-vase)])))
:: =/  id          (~(got by keys.arg) 'user_id')
:: =/  id-vase  !>([tkn secret id key.arg])
:: ;<  ~        bind:m  (poke [our %gato] :-(%add !>(['profile' :-(:-(%botwit %profile) vase)])))
:: ;<  ~        bind:m  (poke [our %gato] :-(%add !>(['notify' :-(:-(%botwit %notify-timer) id-vase)])))
(pure:m !>(~))