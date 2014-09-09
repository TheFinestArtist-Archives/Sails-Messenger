Sails-Messenger
===============

Web/iOS/Android Messenger Application using sockets/api in Sails.js


##APIs
###Socket
####put : sockets/join => res.ok();
    username

=================
###User
####get : /user => SimpleUserJSON LIST

###User
####get : /user/signin => WholeUserJSON
    username
    password

###User
####post : /user/signup => WholeUserJSON
    username
    password

###Auth
####get : /auth/verify => WholeUserJSON 
    username
    password (hashedg)

###Chat
####get : /chat => SimpleChatJSON LIST

###Chat
####post : /chat/start => WholeChatJSON
	username
	friend

####put : /chat/join => WholeChatJSON
	username
	chat_id

####put : /chat/message => WholeMessageJSON
	username
	chat_id

###Message
####post : /message/post => WholeMessageJSON
	content
	author
	chat
