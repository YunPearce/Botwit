/-  spider, chat, *gato
/+  *strandio, twit-api
=,  strand=strand:spider
=/  m  (strand ,vase)
!:
|^  ted 
::
++  pop-ship
|=  [all=(list ship) out=(list ship)]
^-  (list ship)
?:  =((lent out) 0)  all
=/  i  (find :~((rear out)) all)
?:  =(~ i)  
  $(out (snip (homo out)))
$(out (snip (homo out)), all (oust [u.+:i 1] (homo all)))
::
++  ship-to-inline
|=  l=(list ship)
=/  res  *(list inline:chat)
|-  ^-  (list inline:chat)
?:  =(0 (lent l))  res
  $(l `(list ship)`(snip l), res (welp res :~([%ship p=(rear l)] ' ')))
::
++  gato-pokes
|=  [keys=[tkn=@t sec=tape key=@t] auth=(list ship) chat=@tas admin=@p out=(list ship)]
=/  m  (strand ,tuna)
^-  form:m
;<  our=@p   bind:m  get-our
=/  =vase       !>([keys auth chat admin])
=/  tweet-vase  !>([keys auth chat])
;<  ~        bind:m  (poke [our %gato] :-(%add !>(['tweet' :-(:-(%botwit %tweet) tweet-vase)])))
;<  ~        bind:m  (poke [our %gato] :-(%add !>(['in' :-(:-(%botwit %in) vase)])))
=/  ship-inline  (flop (ship-to-inline out))
=/  =reply  [%story p=[p=~ q='Access to /tweet has been revoked for ' ship-inline]]
(pure:m [reply vase])
::
++  ted
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
=/  =bird     !<(bird arg)
?~  text.bird  !!
=/  req   !<([keys=[tkn=@t sec=tape key=@t] auth=(list ship) chat=@tas admin=@p] vase.bird) 
?.  =(admin.req author.memo.bird)  !!
?.  =(chat.req q.flag.bird)        !!
?:  =('all' text.bird)  
    ;<  =tuna  bind:m  (gato-pokes [keys.req :~(admin.req) chat.req admin.req +:auth.req])
    (pure:m !>(tuna))
=/  ships=(list ship)  (text-to-ships:twit-api text.bird)
=/  new-auth  (pop-ship auth.req ships)
    ;<  =tuna  bind:m  (gato-pokes [keys.req new-auth chat.req admin.req ships])
    (pure:m !>(tuna))
--