module.exports = function(app, passport, io) {
	require('./auth')(app, passport); 
	require('./event')(app); 
	require('./eventType')(app); 
	require('./socket')(app, io);
}; 