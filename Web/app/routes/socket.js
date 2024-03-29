var controller = require('../controllers/message');
var Message = require('../models/message');
module.exports = function (app, io) {

	app.get('/create', function (req, res) {
		
		// Generate unique id for the room
		
		var id = Math.round((Math.random() * 1000000));
		// Redirect to the random room
		res.redirect('/chat/' + id);
	});

	app.get('/chat/:id', function (req, res) {
		
		// Render the chant.html view
		res.render('chat');
	});

	// Initialize a new socket.io application, named 'chat'
	var chat = io.on('connection', function (socket) {

		console.log("a user connected");
		// When the client emits the 'load' event, reply with the 
		// number of people in this chat room

		socket.on('load', function (data) {

			console.log('load:' + data);

			var room = findClientsSocket(io, data);
			if (room.length === 0) {

				socket.emit('peopleinchat', { number: 0 });
			}
			else if (room.length === 1) {

				socket.emit('peopleinchat', {
					number: 1,
					user: room[0].username,
					avatar: room[0].avatar,
					id: data
				});
			}
			else if (room.length >= 2) {

				chat.emit('tooMany', { boolean: true });
			}
		});

		// When the client emits 'login', save his name and avatar,
		// and add them to the room
		socket.on('login', function (data) {

			console.log('login:' + data);

			var room = findClientsSocket(io, data.id);
			// Only two people per room are allowed
			if (room.length < 2) {

				// Use the socket object to store data. Each client gets
				// their own unique socket object

				socket.username = data.user;
				socket.room = data.id;
				//				socket.avatar = gravatar.url(data.avatar, {s: '140', r: 'x', d: 'mm'});

				// Tell the person what he should use for an avatar
				socket.emit('img', socket.avatar);


				// Add the client to the room
				socket.join(data.id);

				if (room.length == 1) {

					var usernames = [],
						avatars = [];

					usernames.push(room[0].username);
					usernames.push(socket.username);

					avatars.push(room[0].avatar);
					avatars.push(socket.avatar);

					// Send the startChat event to all the people in the
					// room, along with a list of people that are in it.

					chat.in(data.id).emit('startChat', {
						boolean: true,
						id: data.id,
						users: usernames,
						avatars: avatars
					});
				}
			}
			else {
				socket.emit('tooMany', { boolean: true });
			}
		});

		// Somebody left the chat
		socket.on('disconnect', function () {

			console.log("a user disconnected");

			// Notify the other person in the chat room
			// that his partner has left

			socket.broadcast.to(this.room).emit('leave', {
				boolean: true,
				room: this.room,
				user: this.username,
				avatar: this.avatar
			});

			// leave the room
			socket.leave(socket.room);
		});


		// Handle the sending of messages
		socket.on('msg', function (data) {

			console.log('msg:' + data.text);

			Message.create({
				text: data.text
			}, function (err, message) {
					if (err) {
						// err
					}
					else {
						// When the server receives a message, it sends it to the other person in the room.
						socket.broadcast.to(socket.room).emit('receive', message);
					}
				});
		});
	});
};

function findClientsSocket(io, roomId, namespace) {
	var res = [],
		ns = io.of(namespace || "/");    // the default namespace is "/"

	if (ns) {
		for (var id in ns.connected) {
			if (roomId) {
				var index = ns.connected[id].rooms.indexOf(roomId);
				if (index !== -1) {
					res.push(ns.connected[id]);
				}
			}
			else {
				res.push(ns.connected[id]);
			}
		}
	}
	return res;
}