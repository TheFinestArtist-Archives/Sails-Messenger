/**
 * User
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 *
 */

var PasswordHash = require('password-hash');

module.exports = {

  attributes: {
	
		username: {
			type: 'string',
			required: true,
			unique: true
		},

		password: {
			type: 'string',
			required: true
		},

    // Many to Many
		chats: {
			collection: 'chat',
			via: 'chatters',
			dominant: true
		},

    // Array
		friends: {
      type: 'array',
      defaultsTo: new Array()
		},

    toSimpleJSON: function() {
      var json = JSON.stringify(this);
      var obj = JSON.parse(json);
      delete obj.chats;
      delete obj.friends;
      return obj;
    },

    toWholeJSON: function() {
      var json = JSON.stringify(this);
      var obj = JSON.parse(json);
      obj.chats = new Array();
      for (var i = 0; i < this.chats.length; i++)
        obj.chats.push(this.chats[i].toSimpleJSON());
      obj.friends = this.friends;
      return obj;
    }
	
  },

  beforeCreate: function(values, next) {
    values.password = PasswordHash.generate(values.password);
    next();
  },

  afterCreate: function(values, next) {

		// User Create
    User
    .findOneById(values.id)
    .populateAll()
    .exec(function callback(err, user) {
    	if (!err && user)
		    sails.sockets.broadcast('Users', 'user', user.toWholeJSON());
	  });

  	next();
  }

};
