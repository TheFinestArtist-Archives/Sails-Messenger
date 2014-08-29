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
		},

    toJSON: function() {
      var obj = this.toObject();
      obj.chatters = this.chatters;
      obj.messages = this.messages;
      return obj;
    }

  },

  afterCreate: function(values, next) {

    Chat
    .findOneById(values.id)
    .populateAll()
    .exec(function callback(err, chat) {
    	if (!err && chat)
		    sails.sockets.broadcast('Chat#' + chat.id, 'chat', chat.toJSON());
	  });

  	next();
  },

  afterUpdate: function(values, next) {

    Chat
    .findOneById(values.id)
    .populateAll()
    .exec(function callback(err, chat) {
    	if (!err && chat)
		    sails.sockets.broadcast('Chat#' + chat.id, 'chat', chat.toJSON());
	  });
	  
    next();
  }

};

