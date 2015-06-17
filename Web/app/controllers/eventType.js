var EventType = require('../models/eventType');

module.exports.all = function(req, res) {
    EventType.find(function(err, eventTypes) {
        if (err)
            res.send(err);

        res.json(eventTypes);
    });

    EventType.find({
            
        }, ['type', 'date_added'], // Columns to Return
        {
            skip: 0, // Starting Row
            limit: 10, // Ending Row
            sort: {
                date_added: -1 //Sort by Date Added DESC
            }
        },
        function(err, allNews) {
            socket.emit('news-load', allNews); // Do something with the array of 10 objects
        })
};