/-  spider, *gato
/+  *strandio, twit-api
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
!:
;<  =bowl:spider  bind:m  get-bowl
;<  date=@da  bind:m  get-time
;<  eny=@uvJ  bind:m  get-entropy
=/  =bird  !<(bird arg)
=/  token  !<([tkn=@t sec=tape key=@t] vase.bird)
=/  get-req  [date eny :~(:-('oauth_token' tkn.token) :-('oauth_consumer_key' key.token)) sec.token %'GET' %.n]
=/  tid  `@ta`(cat 3 'profile' (scot %uv (sham %filter-child eny)))
=/  req-info=request:http  (get-req:twit-api (crip "https://api.twitter.com/2/users/by/username/{(trip text.bird)}?user.fields=profile_image_url,public_metrics,url,description") get-req)
;<  rep=cord  bind:m  (send-req:twit-api req-info)
=/  =json  (find-emoji:twit-api `@t`rep)
?:  |(=(`@t`-.-.+.json 'title') =(`@t`-.-.+.json 'errors'))
  (pure:m !>([(crip "Could not find user with username:{(trip text.bird)}") vase.bird]))
=/  user-id=tape  (trip ((ot ~[data+(ot :~([id+so]))]):dejs:format json))
::
=/  num-round  10  ::num of times running child thread(or checking mentions of users STEP 3
::
::STEP 1 - 100 recent likes
:: input
=/  req-likes=request:http  (get-req:twit-api (crip "https://api.twitter.com/2/users/{user-id}/liked_tweets?expansions=author_id&max_results=100") get-req)
;<  rep-lik=cord  bind:m  (send-req:twit-api req-likes)
=/  data=(map @t @ud)  (filter-likes:twit-api rep-lik)
::
::STEP 2 Count recent retweets (in last 50 tweets)
::
=/  req-retwit=request:http  (get-req:twit-api (crip "https://api.twitter.com/2/users/{user-id}/tweets?tweet.fields=referenced_tweets&user.fields=name&max_results=50") get-req)
;<  rep-retwit=cord  bind:m  (send-req:twit-api req-retwit)
=/  list-name=(list @t)  (filter-retwit:twit-api rep-retwit)
|-  ^-  form:m
?.  =((lent list-name) 0)
  =/  req-id=request:http  (get-req:twit-api (crip "https://api.twitter.com/2/users/by/username/{(trip (rear list-name))}") get-req)
  ;<  ~             bind:m  (watch-our /awaiting/[tid] %spider /thread-result/[tid])
  ;<  ~             bind:m  %-  poke-our
                            :*  %spider
                                %spider-start
                                !>([`tid.bowl `tid byk.bowl(r da+now.bowl) %filter-child !>([~ req-id])])
                            == 
  ;<  =cage         bind:m  (take-fact /awaiting/[tid])
  ;<  ~             bind:m  (take-kick /awaiting/[tid])
  ?+  p.cage  ~|([%strange-thread-result p.cage %filter-child tid] !!)
    %thread-done
      =/  rep-id  ;;(@t +:q.cage)
      =/  r-id  ((ot ~[data+(ot :~(['id' so]))]):dejs:format (find-emoji:twit-api rep-id))
      =/  l-new  `(list @t)`(snip list-name)
      $(list-name `(list @t)`(snip list-name), data (retweet-match:twit-api r-id data))
    %thread-fail  !!
  ==
::
::STEP 3 - retrive mentions(num) by most interacted user
::
=/  id=[@t (map @t @ud)]  (find-id:twit-api data)
|-  ^-  form:m
?.  =((sub (lent ~(val by data)) (lent ~(val by +.id))) num-round)
=/  req-mentions=request:http  (get-req:twit-api (crip "https://api.twitter.com/2/users/{(trip -.id)}/mentions?expansions=author_id") get-req)
;<  ~             bind:m  (watch-our /awaiting/[tid] %spider /thread-result/[tid])
;<  ~             bind:m  %-  poke-our
                          :*  %spider
                              %spider-start
                              !>([`tid.bowl `tid byk.bowl(r da+now.bowl) %filter-child !>([~ req-mentions])])
                          == 
;<  =cage         bind:m  (take-fact /awaiting/[tid])
;<  ~             bind:m  (take-kick /awaiting/[tid])
?+  p.cage  ~|([%strange-thread-result p.cage %filter-child tid] !!)
  %thread-done
    =/  rep-mentions  ;;(@t +:q.cage)
    $(id (find-id:twit-api +.id), data (id-match:twit-api rep-mentions (crip user-id) data -.id))
  %thread-fail  !!
==
:: Final step ID to username
::
=/  m-interact  (most-interacted:twit-api data)
=/  l-name  *(list @t)
|-  ^-  form:m
?:  =((lent m-interact) 0)  (pure:m !>([(content-format:twit-api json l-name) vase.bird]))
  =/  req-name=request:http  (get-req:twit-api (crip "https://api.twitter.com/2/users/{(trip (rear m-interact))}") get-req)
  ;<  ~             bind:m  (watch-our /awaiting/[tid] %spider /thread-result/[tid])
  ;<  ~             bind:m  %-  poke-our
                            :*  %spider
                                %spider-start
                                !>([`tid.bowl `tid byk.bowl(r da+now.bowl) %filter-child !>([~ req-name])])
                            == 
  ;<  =cage         bind:m  (take-fact /awaiting/[tid])
  ;<  ~             bind:m  (take-kick /awaiting/[tid])
  ?+  p.cage  ~|([%strange-thread-result p.cage %filter-child tid] !!)
    %thread-done
      =/  rep-name  ;;(@t +:q.cage)
      =/  name  ((ot ~[data+(ot :~(['username' so]))]):dejs:format (find-emoji:twit-api rep-name))
      $(m-interact (snip m-interact), l-name (weld :~(name) l-name))
    %thread-fail  !!
==

