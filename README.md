Sails-Messenger
===============

Web/iOS/Android Messenger Application using sockets/api in Sails.js

=================
###Socket
####put : sockets/join => res.ok();
    username

=================
###User
####post : /user => UserJSON
    username
    password

###Auth
####get : /auth/verify => UsersJSON 
    username
    password

###Chat
####post : /chat/start => ChatJSON
		username
		friend

####put : /chat/join => ChatJSON
		username
		chat_id

###Message
####post : /message => MessageJSON
		content
		author
		chat