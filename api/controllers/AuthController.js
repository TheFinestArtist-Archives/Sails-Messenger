/**
 * AuthController
 *
 * @description :: Server-side logic for managing auths
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {

	verify: function(req, res) {
		res.contentType('application/json; charset=utf-8');
		var username = req.param('username');
		var password = req.param('password');

		User
		.findOneByUsername(username)
		.populateAll()
		.exec(function callback(err, user) {
			if (err) return res.negotiate(err);
			if (!user) return res.notFound();
			if (password != user.password) return res.badRequest();

			return res.send(user.toWholeJSON());
		});
	},

	forbidden: function(req, res) {
		return res.forbidden();
	}
	
};

