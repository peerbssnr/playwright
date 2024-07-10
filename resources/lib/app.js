(function () {
	var app = angular.module("myApp", ['chart.js']);
	app.controller("myCtrl", function ($scope, $templateCache) {
		// Data Initialization
		var a = pageData.currentMachineData.map(function (build) {
			build.fomattedTime = timeConversion(build.time);
			build.sqlTimeStamp = new Date(build.sqlTimeStamp).toLocaleString();
			return build;
		});

		var b = pageData.anyMachineData.map(function (build) {
			build.fomattedTime = timeConversion(build.time);
			build.sqlTimeStamp = new Date(build.sqlTimeStamp).toLocaleString();
			return build;
		});

		var color = {
			SUCCESS   : 'rgba(189,225,51,1)',
			SUCCESS_B : 'rgba(189,225,51,0.29)',
			FAILURE   : 'rgba(242,84,84,1)',
			FAILURE_B : 'rgba(242,84,84,0.19)',
			SKIPPED   : 'rgba(128,128,128,1)',
			SKIPPED_B : 'rgba(128,128,128,0.19)',
			DISABLED  : 'rgba(128,128,128,1)',
			DISABLED_B: 'rgba(128,128,128,0.19)'
		};

		// Scope Assignments
		$scope.machine = a.length ? a[0].machineExecuted : '';
		$scope.failureReasons = pageData.reasons.failureReasons;
		$scope.analyses = pageData.reasons.analyses;
		$scope.consoleLogs = pageData.consoleLogs;
		$scope.a = getAData();
		$scope.b = getBData();
		$scope.series = ['time'];
		$scope.options = getOptions();
		$scope.testData = pageData.testData;
		$scope.urls = pageData.urls;
		$scope.testData.isAvail = Object.keys($scope.testData).length > 0;
		if ($templateCache.get('comparison')) {
			$scope.comparison = true
		}

		// Functions
		function getAData() {
			return {
				data           : [
					a.map(function (build) {
						return build.Time;
					}),
					Array(10).fill((a.map(function (build) {
						return build.Time;
					}).reduce(function (a, b) {
						return parseInt(a) + parseInt(b);
					}, 0) / 10))
				],
				datasetOverride: [{
					yAxisID        : 'y-axis-1',
					backgroundColor: a.map(function (build) {
						return build.Status.toUpperCase();
					}).map(function (status) {
						return color[status + '_B'];
					}),
					borderColor    : a.map(function (build) {
						return build.Status.toUpperCase();
					}).map(function (status) {
						return color[status];
					}),
					type           : 'bar'
				}, {
					xAxisID        : 'x-axis',
					type           : 'line',
					fill           : false,
					backgroundColor: '#4bc0c0',
					borderColor    : '#4bc0c0'
				}],
				labels         : a.map(function (build) {
					return build.sqlTimeStamp;
				})
			};
		}

		function getBData() {
			return {
				data           : [
					b.map(function (build) {
						return build.Time;
					}),
					Array(10).fill((b.map(function (build) {
						return build.Time;
					}).reduce(function (a, b) {
						return parseInt(a) + parseInt(b);
					}, 0) / 10))
				],
				datasetOverride: [{
					yAxisID        : 'y-axis-1',
					backgroundColor: b.map(function (build) {
						return build.Status.toUpperCase();
					}).map(function (status) {
						return color[status + '_B'];
					}),
					borderColor    : b.map(function (build) {
						return build.Status.toUpperCase();
					}).map(function (status) {
						return color[status];
					})
				}, {
					xAxisID        : 'x-axis',
					type           : 'line',
					fill           : false,
					backgroundColor: '#4bc0c0',
					borderColor    : '#4bc0c0'
				}],
				labels         : b.map(function (build) {
					return build.sqlTimeStamp;
				})
			};
		}

		function getOptions() {
			return {
				scales   : {
					xAxes: [{
						id        : 'x-axis',
						scaleLabel: {
							display    : true,
							labelString: 'Date'
						},
						gridLines : {
							display: true
						}
					}],
					yAxes: [
						{
							id        : 'y-axis-1',
							type      : 'linear',
							display   : true,
							position  : 'left',
							ticks     : {
								callback: function (value) {
									return timeConversion(value);
								}
							},
							scaleLabel: {
								display    : true,
								labelString: 'Time'
							},
							gridLines : {
								display: true
							}
						}
					]
				},
				legend   : {
					display : true,
					position: 'top',
					labels  : {
						generateLabels: function () {
							var status = {
								SUCCESS           : {
									stroke: 'rgba(189,225,51,1)',
									fill  : 'rgba(189,225,51,1)'
								},
								FAILURE           : {
									stroke: 'rgba(242,84,84,1)',
									fill  : 'rgba(242,84,84,1)'
								},
								'SKIPPED/DISABLED': {
									stroke: 'rgba(128,128,128,1)',
									fill  : 'rgba(128,128,128,1)'
								},
								'AVERAGE TIME'    : {
									stroke: 'rgba(75,192,192,1)',
									fill  : 'rgba(75,192,192,1)'
								}
							};
							return Object.keys(status).map(function (stat, i) {
								return {
									text       : stat,
									fillStyle  : status[stat].fill,
									strokeStyle: status[stat].stroke,
									lineWidth  : 2,
									hidden     : false,
									index      : i
								};
							});
						}
					}
				},
				tooltips : {
					callbacks: {
						label: function (ti) {
							return (ti.datasetIndex ? 'Average Time: ' : 'Time: ') + timeConversion(ti.yLabel);
						}
					}
				},
				animation: {
					onComplete: function () {
						var chartInstance = this.chart;
						var ctx = chartInstance.ctx;
						if (chartInstance.canvas.id === 'bar2') {
							var height = chartInstance.controller.boxes[0].bottom;
							ctx.textAlign = "center";
							Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
								var meta = chartInstance.controller.getDatasetMeta(i);
								if (meta.type === 'bar')
									Chart.helpers.each(meta.data.forEach(function (bar, index) {
										ctx.fillStyle = meta.data[index]._model.borderColor;
										ctx.fillText(b[index].machineExecuted, bar._model.x, height - ((height - bar._model.y) / 2));
									}), this)
							}), this);
						}
					}
				}
			};
		}

		function timeConversion(milliSec) {

			var seconds = (milliSec / 1000).toFixed();

			var minutes = (milliSec / (1000 * 60)).toFixed(1);

			var hours = (milliSec / (1000 * 60 * 60)).toFixed(2);

			var days = (milliSec / (1000 * 60 * 60 * 24)).toFixed(2);

			if (seconds < 60) {
				return seconds + " Sec";
			} else if (minutes < 60) {
				return minutes + " Min";
			} else if (hours < 24) {
				return hours + " Hrs";
			} else {
				return days + " Days"
			}
		}
	});
})(angular);
