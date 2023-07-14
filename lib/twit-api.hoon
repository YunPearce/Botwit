/-  spider, *chat
/+  jose 
/+  strandio
=,  strand=strand:spider
!:
|%
::
++  unix-time
|=  now=@da
^-  tape
(en-json:html (sect:enjs:format now))
::
++  nonce-gen
|=  eny=@uvJ
^-  tape
`tape`(scag 24 (trip (en:base64:mimes:html (as-octt:mimes:html (scow %ud (shax eny))))))
::
++  hmac-sign
|=  [sign-key=tape sign=tape]
^-  tape
=/  sha  (hmac-sha1t:hmac:crypto [(crip sign-key) (crip sign)])
  (trip (en:base64:mimes:html (en:octn:jose sha)))
::
++  url-parser
|=  url=tape
?:  =((find "?" url) ~)  [url ~]
  =/  url-p  `tape`(scag +:(find "?" url) url)
  =/  url-q  (weld `tape`(slag (add 1 +:(find "?" url)) url) "&")
  =/  headers  *(list [@t @t])
  |-  ^-  [tape (list [@t @t])]
  ?:  =((lent url-q) 0)  [url-p headers]
    $(url-q `tape`(slag (add 1 +:(find "&" url-q)) url-q), headers (weld headers :~(:-((crip `tape`(scag +:(find "=" url-q) url-q)) (crip `tape`(swag [(add 1 +:(find "=" url-q)) (sub u.+:(find "&" url-q) (add 1 +:(find "=" url-q)))] url-q))))))
::
++  list-headers
|=  [now=@da eny=@uvJ]
=/  nonce  (nonce-gen eny)
=/  date  (unix-time now)  
^-  (list [@t @t])
:~  :-  'oauth_nonce'  (crip nonce)
    :-  'oauth_signature_method'  'HMAC-SHA1'
    :-  'oauth_timestamp'  (crip date)
    :-  'oauth_version'  '1.0'
==
::
++  header-auth
|=  [url=@t now=@da eny=@uvJ new-headers=(list [@t @t]) tkn-secret=tape type=@tas date=?]
=/  headers  (weld (list-headers now eny) new-headers)
=/  sign  :~(:-('oauth_signature' (crip (en-urlt:html (signature url headers tkn-secret type date)))))
=/  header-type  (?(%'POST' %'GET') type)
?-  header-type
  %'POST' 
  =/  parsed-url  (url-parser (trip url))
  =/  all-headers=(list [@t @t])  (sort (weld (weld headers sign) +:parsed-url) aor)
  (header-tape all-headers)
  %'GET'
  =/  all-headers=(list [@t @t])  (sort (weld headers sign) aor)
  (header-tape all-headers)
==
::
++  header-tape 
|=  all-headers=(list [@t @t])
=/  res  *tape
|-  ^-  tape
?:  =((lent all-headers) 1)  (weld "OAuth " (weld res "{(trip -:(snag 0 all-headers))}={<(trip +:(snag 0 all-headers))>}"))
$(all-headers `(list [@t @t])`(slag 1 all-headers), res (weld res "{(trip -:(snag 0 all-headers))}={<(trip +:(snag 0 all-headers))>}, "))
::
++  signature 
|=  [url=@t headers=(list [@t @t]) key=tape type=@tas date=?]
=/  parsed-url  (url-parser (trip url))
=/  url-p  -.parsed-url
::to alph order here
=/  all-h  (sort (weld headers +.parsed-url) aor)
=/  sign  *tape
|-  ^-  tape
?:  =((lent all-h) 1)  (hmac-sign key (weld "{(trip type)}&{(en-urlt:html url-p)}&" (en-urlt:html (weld sign "{(en-urlt:html (trip -:(snag 0 all-h)))}={(en-urlt:html (trip +:(snag 0 all-h)))}"))))
?:  |(=(date %.n) !=((find "," (trip +:(snag 0 all-h))) ~))
$(all-h (slag 1 all-h), sign (weld sign "{(en-urlt:html (trip -:(snag 0 all-h)))}={(en-urlt:html (trip +:(snag 0 all-h)))}&")) 
::good only for ISO date 
$(all-h (slag 1 all-h), sign (weld sign "{(en-urlt:html (trip -:(snag 0 all-h)))}={(trip +:(snag 0 all-h))}&"))
::
++  req-auth
|=  [url=@t now=@da eny=@uvJ new-headers=(list [@t @t]) tkn-secret=tape type=@tas data=@t date=?]
=/  header  (header-auth url now eny new-headers tkn-secret type date)
?:  =(data ~)
  =/  =request:http
  :*  %'POST'
    url
    ['content-type'^'application/json' 'Authorization'^(crip header) ~]
    ~
  ==
  request
  ::
=/  body=(unit octs)  (some (as-octt:mimes:html (trip data)))
=/  =request:http
  :*  %'POST'
    url
    ['content-type'^'application/json' 'Authorization'^(crip header) ~]
    body
  ==
request
::
++  get-req
|=  [url=@t now=@da eny=@uvJ new-headers=(list [@t @t]) tkn-secret=tape type=@tas date=?]
=/  header  (header-auth url now eny new-headers tkn-secret type date)
=/  =request:http
  :*  %'GET'
    url
    ['content-type'^'application/json' 'Authorization'^(crip header) ~]
    ~
  ==
request
::
++  parse-html-resp
|=  data=@t
^-  tape
=/  resp=tape  (trip data)
=/  oauth-token=tape  `tape`(scag 27 (slag 12 resp))
oauth-token
::
++  keys-to-list
|=  t=@t
=/  tp=tape  (trip t)
=/  res  *(list @t)
=/  index  0
|-  ^-  (list @t)
?:  =((find "=" tp) ~)  (weld res ~[(crip tp)])
  ?:  ?|(=((snag index tp) '=') =((snag index tp) '&'))
    $(tp `tape`(slag (add 1 index) tp), res (weld res ~[(crip `tape`(scag index tp))]), index 0)
  $(index +(index))
::
++  keys-to-map 
|=  t=@t
=/  lst=(list @t)  (keys-to-list t)
=/  ps=(list [@t @t])  ~[[(snag 0 lst) (snag 1 lst)]]
|-  ^-  (map @t @t)
?:  =((lent lst) 2)  `(map @t @t)`(malt ps)
  $(lst `(list @t)`(slag 2 lst), ps (weld ps ~[[(snag 2 lst) (snag 3 lst)]]))
::
++  send-req 
|=  =request:http
=/  m  (strand ,cord)
^-  form:m
;<  ~  bind:m  (send-request:strandio request)
;<  rep=client-response:iris  bind:m  take-client-response:strandio
?>  ?=(%finished -.rep)
%-  pure:m
q.data.u.+3.full-file.rep
::
++  sleep
|=  [data=@t req=request:http]
=/  m  (strand ,cord)
^-  form:m
?.  =((find "Too Many Requests" (trip data)) ~) 
  ;<  ~  bind:m  (sleep:strandio ~m15.s10)
  (send-req req)
(pure:m data)
::
++  emoji-to-map
^-  (map @t @t)
%-  malt
^-  (list [@t @t])
:~  :-  '\\uD83D\\uDE2D'  '😍'
    :-  '\\uD83D\\uDE00'  '😀'
    :-  '\\uD83D\\uDE03'  '😃'
    :-  '\\uD83D\\uDE04'  '😄'
    :-  '\\uD83D\\uDE01'  '😁'
    :-  '\\uD83D\\uDE06'  '😆'
    :-  '\\uD83D\\uDE05'  '😅'
    :-  '\\uD83D\\uDD23'  '🤣'
    :-  '\\uD83D\\uDE02'  '😂'
    :-  '\\uD83D\\uDE42'  '🙂'
    :-  '\\uD83D\\uDE43'  '🙃'
    :-  '\\uD83D\\uDE09'  '😉'
    :-  '\\uD83D\\uDE0A'  '😊'
    :-  '\\uD83D\\uDE07'  '😇'
    :-  '\\uD83D\\uDD70'  '🥰'
  ==
::
++  find-emoji
|=  data=@t
=/  text=tape  (trip data)
|-  ^-  json
?:  =((find "\\u" text) ~)  (need (de-json:html (crip text)))
  =/  emoji  (crip `tape`(swag [+:(find "\\u" text) 12] text))
  ?:  =((~(gut by emoji-to-map) emoji ~) ~)  
    $(text (oust [+:(find "\\u" text) 12] text))
  $(text (snap (oust [+:(find "\\u" text) 11] text) +:(find "\\u" text) (~(got by emoji-to-map) emoji)))
::
++  users-to-map
|=  =json
=/  users   ((ot ~[includes+(ot ~[users+(ar (ot :~(['id' so] ['username' so])))])]):dejs:format json)
`(map @t @t)`(malt users)
::
::ted/notify.hoon
::
++  mentions
|=  rep=@t
=/  =json  (find-emoji rep)
=/  info=(list [id=@t twit=@t date=@t ref=(list [@t @t])])  ((ot ~[data+(ar (ot :~(['author_id' so] ['text' so] ['created_at' so] ['referenced_tweets' (ar (ot ~[type+so id+so]))])))]):dejs:format json)
=/  users  (users-to-map json)
=/  id-to-user  (turn info |=(a=[id=@t twit=@t date=@t ref=(list [@t @t])] [(~(got by users) id.a) twit.a date.a ref.a]))
|-  ^-  (list @t)
=/  l  *(list @t)
=/  spin  (spin id-to-user l mentions-sort)
`(list @t)`q.spin
::
++  mentions-sort
|=  [a=[id=@t twit=@t date=@t ref=(list [@t @t])] n=(list @t)]
=/  reference=@t  -.i.-.ref.a
?:  =(reference 'replied_to')  :-(n (snoc (snoc n (crip "@{(trip id.a)} replied to you")) (crip "  '{(trip twit.a)}'")))
:-(n (snoc (snoc n (crip "@{(trip id.a)} quoted your twit")) (crip "  '{(trip twit.a)}'")))
::
++  compare-l
|=  [old=(list @t) new=(list @t)]
^-  [(list @t) (list @t)]
=/  unfol  *(list @t)
|-  ^-  [(list @t) (list @t)]
?:  =(old new)  [unfol unfol]
  ?:  =(old ~)  [new unfol]
    ?:  =((find `(list @t)`~[(rear old)] new) ~)  $(old `(list @t)`(snip old), unfol (weld unfol `(list @t)`~[(rear old)])) 
    $(old `(list @t)`(snip old), new (oust [i.-:(fand `(list @t)`~[(rear old)] new) 1] new))
::
++  first
|=  a=(list @)
=/  l=(list @)  (oust [1 (sub (lent a) 1)] a)
`@t`-.l
::
++  filter-likes
|=  rep=@t
=/  =json  (find-emoji rep)
=/  ids  ((ot ~[data+(ar (ot :~(['author_id' so])))]):dejs:format json)
=/  id-map  *(map @t @ud)
|-  ^-  (map @t @ud)
?:  =((lent ids) 0)  id-map
$(id-map `(map @t @ud)`(~(put by id-map) (first ids) (lent (fand ~[`@t`(first ids)] ids))), ids `(list @t)`(skip ids |=(a=@t =(a (first ids)))))
::
++  filter-retwit
|=  rep=@t
=/  =json  (find-emoji rep)
=/  twits=(list @t)  ((ot ~[data+(ar (ot :~(['text' so])))]):dejs:format json)
=/  retw-only=(list @t)  `(list @t)`(skim twits |=(t=@t =((oust [2 (lent (trip t))] (trip t)) "RT"))) 
(turn retw-only |=(t=@t (crip (oust [0 4] (oust [(sub (snag 1 (fand " " (trip t))) 1) (lent (trip t))] (trip t))))))
::
++  find-id
|=  m=(map @t @ud)
=/  l-val=(list @ud)  (sort ~(val by m) lth)
=/  max-val=@ud  (rear l-val)
=/  l-key=(list @t)  (flop ~(tap in ~(key by m))) 
=/  i=@ud  1
=/  k=@t  (first l-key)
|-  ^-  [@t (map @t @ud)]
?:  =((~(got by m) k) max-val)  [k `(map @t @ud)`(~(del by m) k)]
  $(k (first (oust [0 i] l-key)), i +(i))
::
++  id-match 
|=  [res=@t id=@t m=(map @t @ud) sub-id=@t]
=/  m-new=(map @t @ud)  (filter-likes res)
=/  val  (~(get by m-new) id)
|-  ^-  (map @t @ud)
?:  =(val ~)  m
`(map @t @ud)`(~(put by m) sub-id (add (~(got by m) sub-id) +.val))
::
++  retweet-match
|=  [id=@t m=(map @t @ud)]
=/  val  (~(get by m) id)
|-  ^-  (map @t @ud)
?~  val  `(map @t @ud)`(~(put by m) id 1)
`(map @t @ud)`(~(put by m) id (add (~(got by m) id) 1))
::
++  most-interacted
|=  m=(map @t @ud)
=/  l  *(list @t)
=/  n  5  ::change n for ammount of users to get in res
|-  ^-  (list @t)
?:  =((lent l) n)  
l
$(l (weld l :~(-:(find-id m))), m +:(find-id m))
::
++  l-to-inline
|=  l=(list @t)
=/  res  *(list inline)
|-  ^-  (list inline)
?:  =(0 (lent l))  res
  $(l `(list @t)`(snip l), res (welp res :~([%italics :~((rear l))] [%break ~])))
::
++  content-format
|=  [=json acc=(list @t)]
=/  info=[name=@t img=@t bio=@t fol=@ud friend=@ud]  ((ot ~[data+(ot :~([username+so] ['profile_image_url' so] [description+so] [`@tas`'public_metrics' (ot :~(['followers_count' ni] ['following_count' ni]))]))]):dejs:format json)
=/  url  (crip "https://twitter.com/{(trip name.info)}")
=/  =block  [%image img.info 100 100 'profile_img']
=/  acc-lin=(list inline)  (l-to-inline acc) 
=/  end  (welp acc-lin :~([%link url name.info]))
=/  lin=(list inline)  %+  welp
                       :~  [%bold p=:~(name.info)]
                           [%break ~]
                           bio.info
                           [%break ~]
                           (crip (weld "Followers: " (scow %ud fol.info)))
                           [%break ~]
                           (crip (weld "Following: " (scow %ud friend.info)))
                           [%break ~]
                           [%bold :~('Most interacted with: ')]
                           [%break ~]
                           ==
                           end
[%story p=[p=:~(block) q=lin]]
::
::  For ted/in.hoon ted/out.hoon
::
++  text-to-ships 
|=  t=@t
^-  (list ship)
=/  text  (space-check t)
=/  list-t  `(list @t)`(scan (trip text) (star (ifix [sig ace] sym)))
=/  ships=(list ship)  
    %+  turn  list-t
    |=(a=@t `@p`(scan (trip a) fed:ag))
ships
::
++  space-check 
|=  t=@t
=/  =tape  (trip t)
?:  =((rear tape) ' ')  t
(crip (weld tape " "))
::
--