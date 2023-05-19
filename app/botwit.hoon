/-  chat, *gato
/+  default-agent, dbug
|%
+$  versioned-state 
  $%  state-0
  ==
+$  state-0  [%0 arg=(map @t bird)]
+$  card  card:agent:gall
++  message-card
  |=  [our=ship =action:chat]
  ^-  card
  [%pass /chat/poke %agent [our %chat] %poke %chat-action !>(action)]
++  message
  |=  [=id:chat =flag:chat =content:chat]
  ^-  action:chat
  :-  flag
  :-  q.id   
  :-  %writs 
  :-  id     
  :-  %add   
  :-  replying=~
  :-  author=p.id
  :-  sent=q.id
  content
++  reply-to-content
  |=  =reply
  ^-  content:chat
  ?^  reply  reply
  [%story [~ ~[reply]]]
--
!:
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this      .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init  
  ^-  (quip card _this)
  `this
++  on-save  
  ^-  vase
  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
++  on-poke  
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  !!
      %noun
    =/  data  !<(bird vase)
    :_  this(arg (~(put by arg) q.flag.data data))
    [%pass /timers/(scot %p p.flag.data)/[q.flag.data] %arvo %b %wait (add now.bowl ~m30)]~
  ==
++  on-watch  on-watch:def
++  on-agent  on-agent:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-fail   on-fail:def
++  on-arvo   
  |=  [=wire =sign-arvo]
  ~&  [wire sign-arvo]
  ^-  (quip card _this)
  ?+    wire  (on-arvo:def wire sign-arvo)
      [%timers cord cord *]
    =/  [%timers ship-cord=cord chat=cord *]  wire
    ?+    sign-arvo  (on-arvo:def wire sign-arvo)
        [%behn %wake *]
      ?~  error.sign-arvo
      ~&  chat
      =/  new-bird  (~(get by arg) chat)
      ~&  u.+.new-bird
         :_  this
         [%pass /result/[ship-cord]/[chat] %arvo %k %fard q.byk.bowl %notify %noun !>(u.+.new-bird)]~
      (on-arvo:def wire sign-arvo)
    ==
    ::
    [%result cord cord *] 
    =/  [%result ship-cord=cord chat=cord *]  wire 
      ?+  sign-arvo  (on-arvo:def wire sign-arvo)
      [%khan %arow %.y %noun *]
      ~&  sign-arvo
      =/  [%khan %arow %.y %noun result=vase]  sign-arvo
      =/  =ship  (slav %p ship-cord)
      =/  reply  !<(reply result)
      ~&  reply
      :_  this
      :~  %+  message-card  our.bowl
        (message [our.bowl now.bowl] [ship chat] (reply-to-content reply))
      ==
    ==
  ==
--