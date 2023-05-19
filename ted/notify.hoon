/-  spider, *gato
/+  *strandio, twit-api
=,  strand=strand:spider
=/  m  (strand ,vase)
!:
|^  ted
::
++  to-iso
|=  now=@da
=/  date  (yore (sub now ~m30)) 
=/  y  `tape`(skip (scow %ud y.date) |=(a=@t =('.' a))) 
=/  m=tape    (to-double m.date)
=/  d=tape    (to-double d.t.date)
=/  h=tape    (to-double h.t.date)
=/  min=tape  (to-double m.t.date)
|-  ^-  tape
"{y}-{m}-{d}T{h}:{min}:00Z"
::
++  to-double
|=  n=@ud
=/  =tape  (scow %ud n)
?:  =((lent tape) 1)  "0{tape}"
tape
::
++  from-json
|=  [=json mark=@tas]
=/  action  (?(%rep %count) mark)
?-  action
  %rep
    =/  user-map   (users-to-map:twit-api json)
    =/  mentions=(list [twit=@t user-id=@t sub-l=(list [ref=@t twit-id=@t])])  ((ot ~[data+(ar (ot :~([id+so] ['author_id' so] [`@tas`'referenced_tweets' (ar (ot :~([type+so] [id+so])))])))]):dejs:format json)
    (to-reply [mentions user-map])
  ::
  %count
    ((ot ~[meta+(ot :~(['result_count' ni]))]):dejs:format json)
==
::
++  to-reply
|=  [l-men=(list [tweet-id=@t user-id=@t sub-l=(list [ref=@t twit-id=@t])]) user-map=(map @t @t)]
%+  turn  l-men
|=  [twit=@t user-id=@t sub-l=(list [ref=@t twit-id=@t])]
=/  user-name  u.+:(~(get by user-map) user-id)
=/  url   (crip "https://twitter.com/{(trip user-name)}/status/{(trip twit)}")
=/  face  (crip "{(trip user-name)} {(trip ref.i.-.sub-l)} your tweet")
=/  mentions  :~([%link url face] [%break ~])
mentions
::
++  ted
^-  thread:spider
|=  arg=vase
^-  form:m
=/  m  (strand ,vase)
;<  =bowl:spider  bind:m  get-bowl
;<  date=@da      bind:m  get-time
;<  eny=@uvJ      bind:m  get-entropy
=/  =bird  !<(bird arg)
;<  ~        bind:m  (poke [our.bowl %botwit] :-(%noun !>(bird)))
=/  token  !<([tkn=@t sec=tape id=@t key=@t] vase.bird)
=/  get-req  [date eny :~(:-('oauth_token' tkn.token) :-('oauth_consumer_key' key.token)) sec.token %'GET' %.y]
=/  tim=tape  (to-iso date) 
=/  url  "https://api.twitter.com/2/users/{(trip id.token)}/mentions?expansions=referenced_tweets.id,author_id&tweet.fields=text,created_at,author_id&user.fields=name&start_time={tim}"
=/  req-men=request:http  (get-req:twit-api (crip url) get-req) 
;<  rep-men=cord  bind:m  (send-req:twit-api req-men) 
;<  men=cord      bind:m  (sleep:twit-api rep-men req-men)
=/  json-men   (find-emoji:twit-api `@t`men)
|-  ^-  form:m
?:  =((from-json json-men %count) 0)
(pure:m !>(*reply))
  =/  data  (zing (from-json json-men %rep))
  =/  =reply  [%story p=[p=~ q=data]]
  |-  ^-  form:m
  ?.  =((find "next_token" (en-json:html json-men)) ~)
    =/  next-tkn  (trip ((ot ~[meta+(ot :~(['next_token' so]))]):dejs:format json-men))
    =/  req=request:http  (get-req:twit-api (crip (weld url "&pagination_token={next-tkn}")) get-req)
    ;<  rep=cord  bind:m  (send-req:twit-api req) 
    ;<  check-data=cord  bind:m  (sleep:twit-api rep req)
    =/  json-next   (find-emoji:twit-api check-data)
    |-  ^-  form:m
    ?:  =((from-json json-men %count) 0)  (pure:m !>(rep))
      =/  data-new  (welp data (zing (from-json json-next %rep)))
    $(reply [%story p=[p=~ q=data-new]], json-men json-next)
  (pure:m !>(reply))
--