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

    // One to Many
  	chat: {
  		model: 'chat'
  	},

    // One Way
  	author: {
    	model: 'user'
  	},

    toSimpleJSON: function() {
      var json = JSON.stringify(this);
      var obj = JSON.parse(json);
      if (this.chat)
        obj.chat = this.chat.id;
      if (this.author)
        obj.author = this.author.id;
      return obj;
    },

    toWholeJSON: function() {
      var json = JSON.stringify(this);
      var obj = JSON.parse(json);
      if (this.chat)
        obj.chat = this.chat.id;
      if (this.author)
        obj.author = this.author.toSimpleJSON();
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

