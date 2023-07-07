# Botwit
Twitter chatbot for group chat

## Installing 

```
|install ~botter-midsum-salrux %gato
|install ~mastyr-dozzod-marlur %botwit
:gato &add ['configure' [%botwit %configure] !>(['API-key' 'API-secret' ~])]
```

### API-key and API-secret are consumer keys, you can create them on twitter developer portal. Don't forget to grant in READ and WRITE permissions (in settings of your project).

## Commands 

To authenticate run commands below in grop chat:

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
