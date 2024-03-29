angular.module('app.routes', ['ngRoute']).config(function ($routeProvider, $locationProvider) {

	$routeProvider.when('/', {
		templateUrl: 'app/views/home.html',
		controller: 'mainController',
		controllerAs: 'main'
	});

	$routeProvider.when('/chat', {
		templateUrl: 'app/views/chat.html',
		controller: 'mainController',
		controllerAs: 'main'
	});

	$locationProvider.html5Mode(true);
});