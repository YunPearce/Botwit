/-  spider, chat, *gato
/+  *strandio, twit-api
=,  strand=strand:spider
=/  m  (strand ,vase)
!:
|^  ted 
::
++  ship-to-inline
|=  l=(list @p)
=/  res  *(list inline:chat)
|-  ^-  (list inline:chat)
?:  =(0 (lent l))  res
  $(l `(list @p)`(snip l), res (welp res :~([%ship p=(rear l)] ' ')))
::
++  check-doub
|=  [new=(list ship) auth=(list ship)]
^-  (list ship)
?:  =((lent new) 0)  auth
=/  i  (find :~((rear new)) auth)
?:  =(~ i)  
  $(new (snip (homo new)), auth (weld auth :~((rear new))))
$(new (snip (homo new)))
++  ted
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
;<  our=@p   bind:m  get-our
=/  =bird     !<(bird arg)
?~  text.bird  !!
=/  req   !<([keys=[tkn=@t sec=tape key=@t] auth=(list ship) chat=@tas admin=@p] vase.bird) 
?.  =(admin.req author.memo.bird)  !!
?.  =(chat.req q.flag.bird)        !!
=/  ships  (text-to-ships:twit-api text.bird)
=/  new-admin=(list @p)  (check-doub ships auth.req)
=/  tweet-vase  !>([keys.req new-admin chat.req])
=/  new-vase  !>([keys.req new-admin chat.req admin.req])
;<  ~        bind:m  (poke [our %gato] :-(%set !>(['tweet' :-(:-(%botwit %tweet) tweet-vase)])))
;<  ~        bind:m  (poke [our %gato] :-(%set !>(['out' :-(:-(%botwit %out) new-vase)])))
=/  ship-inline=(list inline:chat)  (flop (ship-to-inline ships))
=/  =reply  [%story p=[p=~ q='Access to /tweet has been granted to: ' ship-inline]]
(pure:m !>([reply new-vase]))
--