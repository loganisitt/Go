var EventType = require('../models/eventType');

module.exports.all = function(req, res) {
    EventType.find(function(err, eventTypes) {
        if (err)
            res.send(err);

        res.json(eventTypes);
    });
};