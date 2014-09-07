Sails-Messenger
===============

Web/iOS/Android Messenger Application using sockets/api in Sails.js


##APIs
###Socket
####put : sockets/join => res.ok();
    username

=================
###User
####get : /user => UserJSON LIST

###User
####get : /user/signin => UserJSON
    username
    password

###User
####post : /user => UserJSON
    username
    password

###Auth
####get : /auth/verify => UsersJSON 
    username
    password (hashed)

###Chat
####get : /chat => ChatJSON LIST

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
