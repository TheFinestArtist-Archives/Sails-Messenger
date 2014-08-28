/**
 * User
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 *
 */

module.exports = {

  attributes: {
	
		username: 'string',

		chats: {
			collection: 'chat',
			via: 'chatters',
			dominant: true
		},

		online: 'boolean'
	
  }

};
