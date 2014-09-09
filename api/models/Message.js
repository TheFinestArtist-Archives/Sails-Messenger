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
      if (this.chat)
        obj.chat = this.chat.id;
      if (this.author)
        obj.author = this.author.id;
      return obj;
    },

    toWholeJSON: function() {
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
        sails.sockets.broadcast('Chat#' + message.chat.id, 'message', message.toWholeJSON());
    });

  	next();
  }

};

