/**
 * ChatController
 *
 * @description :: Server-side logic for managing chats
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {

	start: function(req, res) {
		res.contentType('application/json; charset=utf-8');
		var username = req.param('username');
		var friend = req.param('friend');

		User
		.find({
			or : [
		    { username: username },
		    { username: friend }
		  ]
		})
		.populateAll()
		.exec(function callback(err, users) {
			if (err) return res.negotiate(err);
			if (!users || users.length != 2) return res.notFound();

			if (users[0].friends.indexOf(users[1].id) == -1) {
				users[0].friends.push(users[1].id);
				users[0].save();
			}

			if (users[1].friends.indexOf(users[0].id) == -1) {
				users[1].friends.push(users[0].id);
				users[1].save();
			}

			Chat
			.create()
			.exec(function callback(err, chat) {
				if (err || !chat)
					return res.serverError();

				Chat
				.findOneById(chat.id)
				.populateAll()
				.exec(function callback(err, chat) {
					if (err) return res.negotiate(err);
					if (!chat) return res.notFound();

					chat.chatters.add(users[0].id);
					chat.chatters.add(users[1].id);
					chat.save(function callback(err) {
						if (err) return res.negotiate();

						Chat
						.findOneById(chat.id)
						.populateAll()
						.exec(function callback(err, chat) {
							if (err) return res.negotiate(err);
							if (!chat) return res.notFound();

					    sails.sockets.broadcast('Chat#' + chat.id, 'chat', chat.toWholeJSON());
							return res.send(chat.toWholeJSON());
						});
					});
				});
			});
		});
	},

	join: function(req, res) {
		res.contentType('application/json; charset=utf-8');
		var username = req.param('username');
		var chat_id = req.param('chat_id');

		User
		.findOneByUsername(username)
		.populateAll()
		.exec(function callback(err, user) {
			if (err) return res.negotiate(err);
			if (!user) return res.notFound();

			Chat
			.findOneById(chat_id)
			.populateAll()
			.exec(function callback(err, chat) {
				if (err) return res.negotiate(err);
				if (!chat) return res.notFound();

				if (getIDs(chat.chatters).indexOf(Number(user.id)) >= 0)
					return res.send(chat.toWholeJSON());

				// add friends
				for (var i = 0; i < chat.chatters.length; i++) {
					if (user.friends.indexOf(Number(chat.chatters[i].id)) == -1) {
						user.friends.push(chat.chatters[i].id);

						if (chat.chatters[i].friends.indexOf(user.id) == -1) {
							chat.chatters[i].friends.push(user.id);
							chat.chatters[i].save();	
						}
					}
				}
				user.save();

				// update chat
				chat.chatters.add(user.id);
				chat.save(function callback(err) {
					if (err) return res.negotiate(err);

					Chat
					.findOneById(chat_id)
					.populateAll()
					.exec(function callback(err, chat) {
						if (err) return res.negotiate(err);
						if (!chat) return res.notFound();

				    sails.sockets.broadcast('Chat#' + chat.id, 'chat', chat.toWholeJSON());
						return res.send(chat.toWholeJSON());
					});
				});
			});
		});
	},

	list: function(req, res) {
		Chat
		.find()
		.sort('id DESC')
		.populateAll()
		.exec(function callback(err, chats) {
			if (err) return res.negotiate(err);
			if (!chats) return res.send(JSON.stringify(new Array()));

    	for (var i = 0; i < chats.length; i++)
    		chats[i] = chats[i].toWholeJSON();
	  	return res.send(chats);
		});
	},

	messages: function(req, res) {
		res.contentType('application/json; charset=utf-8');
		var chat_id = req.param('chat_id');

		Chat
		.findOneById(chat_id)
		.populateAll()
		.exec(function callback(err, chat) {
			if (err) return res.negotiate(err);
			if (!chat) return res.notFound();

  		Message
  		.findById(getIDs(chat.messages))
			.populateAll()
  		.sort('id ASC')
  		.exec(function callback(err, messages) {
				if (err) return res.negotiate(err);
  			if (!messages) return res.send(JSON.stringify(new Array()));

	    	for (var i = 0; i < messages.length; i++)
	    		messages[i] = messages[i].toWholeJSON();
		  	return res.send(messages);
	    });
		});
	}

};

var getIDs = function(jsonArray) {
	if (!jsonArray)
		return new Array();

  var ids = new Array();
  for (var i = 0; i < jsonArray.length; i++)
  	ids.push(jsonArray[i].id);
	return ids;
}