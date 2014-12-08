// Note -- we need a UserController so that blueprints will be activated for User,
// but we don't need any custom User controller code for this app!

var PasswordHash = require('password-hash');

module.exports = {

	signup: function(req, res) {
		res.contentType('application/json; charset=utf-8');
		var username = req.param('username');
		var password = req.param('password');

		User
		.create({
			username: username,
			password: password
		})
		.exec(function callback(err, user) {
			if (err) return res.negotiate(err);
			if (!user) return res.serverError();

			User
			.findOneById(user.id)
			.populateAll()
			.exec(function callback(err, user) {
				if (err) return res.negotiate(err);
				if (!user) return res.notFound();

				return res.send(user.toWholeJSON());
			});
		});
	},

	signin: function(req, res) {
		res.contentType('application/json; charset=utf-8');
		var username = req.param('username');
		var password = req.param('password');

		User
		.findOneByUsername(username)
		.populateAll()
		.exec(function callback(err, user) {
			if (err) return res.negotiate(err);
			if (!user) return res.notFound();
			if (!PasswordHash.verify(password, user.password)) return res.badRequest();
			
			return res.send(user.toWholeJSON());
		});
	},

	list: function(req, res) {
		User
		.find()
		.sort('username ASC')
		.populateAll()
		.exec(function callback(err, users) {
			if (err) return res.negotiate(err);
			if (!users) return res.send(JSON.stringify(new Array()));

    	for (var i = 0; i < users.length; i++)
    		users[i] = users[i].toWholeJSON();
	  	return res.send(users);
		});
	}

};