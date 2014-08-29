/**
* Message.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {

  	content: {
  		type: 'string',
  		required: true,
  		defaultsTo: ''
  	},

  	chat: {
  		model: 'chat'
  	},

  	author: {
    	model: 'user'
  	},

    toJSON: function() {
      var obj = this.toObject();
      obj.chat = this.chat;
      obj.author = this.author;
      return obj;
    }

  },

  afterCreate: function(values, next) {
    
    Message
    .findOneById(values.id)
    .populateAll()
    .exec(function callback(err, message) {
      if (!err && message && message.chat) 
        sails.sockets.broadcast('Chat#' + message.chat.id, 'message', message.toJSON());
    });

  	next();
  }

};

