var controller = require('../controllers/eventType');

module.exports = function (app) {
	
    // Returns all of the event types
    app.get('/api/eventType', controller.all);
};