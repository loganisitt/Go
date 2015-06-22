var Event = require('../models/event');

// GET api/event/
module.exports.all = function(req, res) {
    Event.find().populate('event_type').populate('admin').populate('attendees').exec(function(error, events) {
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
    Event.create({
        admin: req.body.admin,
        name: req.body.name,
        privacy: req.body.privacy,
        event_type: req.body.event_type,
        location_name: req.body.location_name,
        location: req.body.location,
        date: req.body.date,
        max_attendees: req.body.max_attendees,
        age_restriction: req.body.age_restriction,
        min_age: req.body.min_age,
        max_age: req.body.max_age
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
    Event.remove({ _id: req.params.event_id }, function (err, event) {
            if (err) {
                res.send(err);
            }
            else {
                // After removing one, we return all the remaining events.
                Event.find(function (err, events) {
                    if (err) {
                        res.send(err);
                    }
                    else { 
                        res.json(events);
                    }
                });
            }
        }
    );
};

module.exports.join = function (req, res) {
    Event.findByIdAndUpdate(req.body.event, { $addToSet: { attendees: req.body.user } },
        function (err, event) {
            if (err) {
                res.send(err);
            }
            else {
                Event.findById(req.body.event).populate('event_type').populate('admin').populate('attendees').exec(function(error, event) {
                    if (error) {
                        res.send(error);       
                    }
                    else {
                        res.status(200);
                        res.json(event); 
                    }
                });
            }
        }
    );
};

module.exports.leave = function (req, res) {
    Event.findByIdAndUpdate(req.body.event, { $pull: { attendees: req.body.user } },
        function (err, event) {
            if (err) {
                res.send(err);
            }
            else {
                Event.findById(req.body.event).populate('event_type').populate('admin').populate('attendees').exec(function(error, event) {
                    if (error) {
                        res.send(error);       
                    }
                    else {
                        res.status(200);
                        res.json(event); 
                    }
                });
            }
        }
    );
};