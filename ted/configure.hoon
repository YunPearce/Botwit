/-  spider, *gato
/+  strandio, *twit-api
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
!:
;<  =bowl:spider  bind:m  get-bowl:strandio
;<  date=@da  bind:m  get-time:strandio
;<  eny=@uvJ  bind:m  get-entropy:strandio
=/  =bird  !<(bird arg)
=/  err  'Failed to authenticate'
|-  ^-  form:m
?:  (lth (lent (trip text.bird)) 1)
::
:: 1st step
::
=/  keys  !<([key=@t sec=@t tkn=*] vase.bird)  
=/  req=request:http  (req-auth 'https://api.twitter.com/oauth/request_token?oauth_callback=oob' date eny :~(:-('oauth_consumer_key' key.keys)) (weld (trip sec.keys) "&") %'POST' '' %.n)
;<  rep=cord  bind:m  (send-req req)
|-  ^-  form:m
?.  =((find "errors" (trip rep)) ~)  
  (pure:m !>([err vase.bird]))
=/  tokens=tape  (parse-html-resp rep)
=/  url=@t  (crip "https://api.twitter.com/oauth/authenticate?oauth_token={tokens}")
=/  token=@t  (crip tokens)
=/  reply  [%story p=[p=~ q=:~([%link p=url q=url])]]
(pure:m !>([reply !>([key.keys sec.keys token])]))
::
:: 2nd step
::
=/  token  !<([key=@t sec=@t tkn=@t] vase.bird) 
=/  pin  text.bird
=/  req=request:http  (get-req (crip "https://api.twitter.com/oauth/access_token?oauth_verifier={(trip pin)}&oauth_token={(trip tkn.token)}") date eny :~(:-('oauth_consumer_key' key.token)) (weld (trip sec.token) "&") %'GET' %.n)
;<  ~  bind:m  (send-request:strandio req)
;<  rep=client-response:iris  bind:m  take-client-response:strandio
~&  rep
?>  ?=(%finished -.rep)
?.  =(status-code.response-header.rep 200)
  (pure:m !>([err vase.bird]))
=/  keys=(map @t @t)  (keys-to-map `@t`q.data.u.+3.full-file.rep) 
~&  keys
;<  tid=tid:spider   bind:m  (start-thread-with-args:strandio byk.bowl %add !>([~ keys sec.token key.token]))
=/  msg   :~  [%bold p=:~('Authentication complete!')]
            ==
=/  reply  [%story p=[p=~ q=msg]]
(pure:m !>([reply vase.bird]))