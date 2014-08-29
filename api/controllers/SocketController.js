/**
 * SocketController
 *
 * @description :: Server-side logic for managing sockets
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {

	join: function(req, res) {
		var username = req.param('username');
		if (!username)
			return res.badRequest();

		User
		.findOneByUsername(username)
		.populateAll()
		.exec(function callback(err, user) {
			if (err || !user)
				return res.notFound();

			// User Create
	    sails.sockets.join(req.socket, 'Users');

	    // Self Update
	    sails.sockets.join(req.socket, 'User#' + user.id);

	    // My Chat Room
			for (var i = 0; i < user.chats.length; i++)
		    sails.sockets.join(req.socket, 'Chats#' + user.chats[i].id);
		  
	  	return res.ok();
		});
	}
	
};

