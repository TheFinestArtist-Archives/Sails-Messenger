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
			if (err || !user) {
				var error = {};
				error.message = 'User ' + username + ' doesn\'t exist';
				return res.send(404, error);
			}

			if (password != user.password) {
				var error = {};
				error.message = 'Wrong Password';
				return res.send(400, error);
			}

			return res.send(user.toJSON());
		});
	},

	forbidden: function(req, res) {
		return res.forbidden();
	}
	
};

