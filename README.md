# Botwit
Twitter chatbot

## Installing 

```
|install ~botter-midsum-salrux %gato
|install ~mastyr-dozzod-marlur %botwit
:gato &add ['configure' [%botwit %configure] !>(['API-key' 'API-secret' ~])]
```

## Commands 

To authenticate run:

````
/configure
> https://api.twitter.com/oauth/authenticate?....
/configure my_pin
> Authentication complete!
````

To post tweet at scheduled time 
`/tweet my_tweet --time ~2000.1.1`

To get information about user
`/profile username`

To turn on notifications
`/notify`
