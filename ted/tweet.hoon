/-  spider, *gato
/+  strandio, *twit-api
=,  strand=strand:spider
=/  m  (strand ,vase)
!:
|^  ted
::
++  parse-txt
|=  [txt=@t now=@da]
=/  t=tape  (trip txt)
=/  flag-l  (fand "--" t)
=/  res  [t *@dr *tape]
|-  ^-  [tape @dr tape]
?:  =(flag-l ~)  res
=/  twit  `tape`(swag [0 (sub i.-:flag-l 1)] t)
=/  flag  (?(%time %medi) `@tas`(crip (swag [(add 2 (rear flag-l)) 4] t)))
?-  flag
  %time 
  =/  c-date  `@ud`now
  =/  date  (slav %da (crip (swag [(add (rear flag-l) 7) (lent t)] t)))
  ?:  (lth date c-date)  $(res [twit ~s0 +.+:res], flag-l (snip flag-l))
  =/  time  `@dr`(sub date c-date)
  $(res [twit time +.+:res], flag-l (snip flag-l))
::
  %medi
  =/  medi  `tape`(swag [(add (rear flag-l) 8) (lent t)] t)
  $(res [twit -.+.res medi], flag-l (snip flag-l), t (oust [(rear flag-l) (add 8 (lent medi))] t))
==
::
++  ted
^-  thread:spider
|=  arg=vase
^-  form:m
=/  m  (strand ,vase)
;<  date=@da  bind:m  get-time:strandio
;<  eny=@uvJ  bind:m  get-entropy:strandio
=/  =bird     !<(bird arg) 
=/  data      !<([keys=[tkn=@t sec=tape key=@t] auth=(list ship) chat=@tas] vase.bird)
=/  token  keys.data
|-  ^-  form:m
?.  =(chat.data q.flag.bird)                      !!
?~  (find :~(author.memo.bird) (homo auth.data))  !!
=/  flag=[txt=tape time=@dr media=tape]  (parse-txt text.bird date)
=/  twit=@t  (crip "\{\"text\": \"{txt.flag}\"}")
::  checking if time.flag present
|-  ^-  form:m
?.  =(time.flag ~s0) 
  ;<  ~  bind:m  (sleep:strandio time.flag)
  $(flag [txt.flag ~s0 media.flag])
::  checking if media url present
::|-  ^-  form:m
::?.  =(media.flag  "")
::  ::  here will be url to base 64
::  =/  url-64  "here will be incoded base-64 img"
::  =/  media  (crip "\{\"media_data": \"{url-64}\"}")
::  =/  req-media=request:http  (req-auth 'https://upload.twitter.com/1.1/media/upload.json?media_category=tweet_image' date eny :~(:-('oauth_token' tkn.token)) (trip sec.token) %'POST' media)
::  ;<  rep-media=client-response:iris  bind:m  take-client-response:strandio
::  ?>  ?=(%finished -.rep-media)
::  =/  id=@ud  ((ot ~['media_id' ni]):dejs:format (need (de-json:html `@t`q.data.u.+3.full-file.rep-media))) ::check if id correct as num 
::  ::get media id here
::  =/  media-twit  ", \"media\": \{\"media_ids\": [\"{(scow %ud id)}\"]}}"
::  $(flag  [txt.flag time.flag ""], twit (crip (weld (snip (trip twit)) media-twit)))
=/  req=request:http  (req-auth 'https://api.twitter.com/2/tweets' date eny :~(:-('oauth_token' tkn.token) :-('oauth_consumer_key' key.token)) sec.token %'POST' twit %.n)
;<  ~  bind:m  (send-request:strandio req)
;<  rep=client-response:iris  bind:m  take-client-response:strandio
?>  ?=(%finished -.rep)
=/  status-code=@ud  status-code.response-header.rep
?.  =(201 status-code)
    ?:  =(401 status-code)  (pure:m !>(['Unathorized, try /configure again' vase.bird]))
    (pure:m !>([(crip "Error {(scow %ud status-code)}") vase.bird]))
=/  id=@t   ((ot ~[data+(ot :~(['id' so]))]):dejs:format (need (de-json:html `@t`q.data.u.+3.full-file.rep)))
=/  inline    :~  (crip "'{txt.flag}'")
                ' has been posted'
              ==
=/  =reply  [%story p=[p=~ q=inline]]
(pure:m !>([reply vase.bird]))
--