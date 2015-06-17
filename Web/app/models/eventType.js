var mongoosastic = require('mongoosastic');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ObjectId = mongoose.Schema.Types.ObjectId;

var EventType = new Schema({
  name: {
    type: String,
    required: true,
  },
  image_path: {
    type: String,
    required: true
  },
  num_of_players: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  }
});

EventType.plugin(mongoosastic);

var EventTypeModel = mongoose.model('EventType', EventType);

module.exports = EventTypeModel;