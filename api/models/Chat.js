/**
* Chat.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {

		chatters: {
			collection: 'user',
			via: 'chats'
		},

		messages: {
			collection: 'message',
			via: 'chat'
		}

  }

};

