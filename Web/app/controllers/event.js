var Event = require('../models/event');

// GET api/event/
module.exports.all = function(req, res) {

    Event.find().populate('event_type').populate('admin').exec(function(error, events) {
        if (error) {
            res.send(error);       
        }
        else {
            res.status(200);
            res.json(events); 
        }
    });
};

module.exports.allOfType = function (req, res) {
    Event.find({ type: event_type }, function (err, events) {
        if (err)
            res.send(err);

        res.json(events);
    });
};

module.exports.create = function (req, res) {
    // Create the event with the information coming from the AJAX request from Angular
    Event.create({
        admin: req.body.admin,
        name: req.body.name,
        privacy: req.body.privacy,
        event_type: req.body.type,
        location_name: req.body.location,
        location: [req.body.longitude, req.body.latitude],
        date: req.body.date,
        max_attendees: req.body.maxAttendees,
        age_restriction: req.body.restrictions,
        min_age: req.body.minAge,
        max_age: req.body.maxAge
    }, function (err, event) {
            if (err) {
                res.send(err);
            }
            else {
                res.sendStatus(200);
            }
        });
};

module.exports.remove = function (req, res) {
    // Delete the event.
    Event.remove({
        _id: req.params.event_id
    }, function (err, event) {
            if (err)
                res.send(err);

            // After removing one, we return all the remaining events.
            Event.find(function (err, events) {
                if (err)
                    res.send(err);

                res.json(events);
            });
        });
};

module.exports.join = function (req, res) {
    Event.findByIdAndUpdate(req.body.eId, { $addToSet: { attendees: req.body.uId } },
        function (err, event) {
            if (err)
                res.send(err);

            res.json(event);
        });
};