/**
 * MessageController
 *
 * @description :: Server-side logic for managing messages
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {

	post: function(req, res) {
		res.contentType('application/json; charset=utf-8');
		var content = req.param('content');
		var author = req.param('author');
		var chat = req.param('chat');

		Message
		.create({
			content: content,
			author: author,
			chat: chat
		})
		.exec(function callback(err, message) {
			if (err || !message)
				res.badRequest();

			Message
			.findOneById(message.id)
			.populateAll()
			.exec(function callback(err, message) {
				if (err || !message)
					res.notFound();

				return res.send(message.toWholeJSON());
			});
		});
	}
	
};

