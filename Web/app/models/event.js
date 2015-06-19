var mongoosastic = require('mongoosastic');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ObjectId = mongoose.Schema.Types.ObjectId;

var Event = new Schema({
  name: String,
  privacy: Boolean,
  event_type: {
    type: ObjectId,
    ref: 'EventType',
    required: true
  },
  location_name: String,
  location: {
    type: [Number],
    index: '2d' 
  },
  admin: {
    type: ObjectId,
    ref: 'User',
    required: true
  },
  date: Date,
  max_attendess: Number,
  attendees: [String],
  age_restriction: Boolean,
  min_age: Number,
  max_age: Number,
  created_at: Date,
  updated_at: Date
});

// On every save, add the date
Event.pre('save', function (next) {
  // Get the current date
  var currentDate = new Date();
  
  // Change the updated_at field to current date
  this.updated_at = currentDate;

  // If created_at doesn't exist, add to that field
  if (!this.created_at)
    this.created_at = currentDate;

  next();
});

Event.plugin(mongoosastic);

var EventModel = mongoose.model('Event', Event);

/* For Indexing everything */

//var stream = EventModel.synchronize();
//var count = 0;
//
//stream.on('data', function(err, doc) {
//  count++;
//});
//stream.on('close', function() {
//  console.log('indexed ' + count + ' documents!');
//});
//stream.on('error', function(err) {
//  console.log(err);
//});

module.exports = EventModel;