Sails-Messenger
===============

Web/iOS/Android Messenger Application using sockets/api in Sails.js

This is skelecton code for messenger.


##JSON TYPE
=================
###User
####SIMPLE JSON
		username
		password

####WHOLE JSON
		username
		password
		chats (simple jsoned chat list)
		friends (simple jsoned user list)

###Chat
####SIMPLE JSON
		chatters (simple jsoned user list)

####WHOLE JSON
		chatters (simple jsoned user list)

###Message
####SIMPLE JSON
		content
		chat (chat id)
		author (user id)

####WHOLE JSON
		content
		chat (chat id)
		author (simple jsoned user)


##APIs
=================
###Socket
####put : sockets/join => res.ok();
    username

=================
###User
####get : /user/list => WholeUserJSON LIST

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
    password (hashed)

###Chat
####get : /chat/list => WholeChatJSON LIST

###Chat
####post : /chat/start => WholeChatJSON
	username
	friend

####put : /chat/join => WholeChatJSON
	username
	chat_id

####put : /chat/messages => WholeMessageJSON LIST
	username
	chat_id

###Message
####post : /message/post => WholeMessageJSON
	content
	author
	chat
