/**
* Chat.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {

    // Many to Many
		chatters: {
			collection: 'user',
			via: 'chats'
		},

    // Many to One
		messages: {
			collection: 'message',
			via: 'chat'
		},

    toSimpleJSON: function() {
      var json = JSON.stringify(this);
      var obj = JSON.parse(json);
      obj.chatters = new Array();
      for (var i = 0; i < this.chatters.length; i++)
        obj.chatters.push(this.chatters[i].toSimpleJSON());
      delete obj.messages;
      return obj;
    },

    toWholeJSON: function() {
      var json = JSON.stringify(this);
      var obj = JSON.parse(json);
      obj.chatters = new Array();
      for (var i = 0; i < this.chatters.length; i++)
        obj.chatters.push(this.chatters[i].toSimpleJSON());
      delete obj.messages;
      return obj;
    }

  }

};

