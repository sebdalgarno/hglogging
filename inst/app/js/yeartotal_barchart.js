// !preview r2d3 data = data.frame(Year = c(1901, 1950, 1989, 2010), Colour = c("#E35E00", "#E36200", "#E56E00", "#E56E00"), Total = c(84.6, 96.2, 203, 20))

var barPadding = 0.05;
var scaleFactor = 10;
var padding = 40;
var smallpad = 0;

var parseTime = d3.timeParse("%Y");

var color = d3.scale.category20c();

var x = d3.scaleBand()
.domain(data.map(function (d) {
  return parseTime(d.Year);
}))
.rangeRound([padding, width])
.padding(barPadding);

var y = d3.scaleLinear()
.domain([0, d3.max(data, function(d){
  return Number(d.Total);
})])
.rangeRound([height - padding, padding]);

var rect = svg.selectAll("rect")
.data(data);

rect.enter().append("rect")
.attr("x", function(d) {
  return x(parseTime(d.Year));
})
.attr("width", x.bandwidth)
.attr("y", function(d){
  return y(d.Total);
})
.attr("height", function(d){
  return (height - y(d.Total)) - padding;
})
.attr("fill", function(d){
  return d.Colour;
});

rect.transition();

var xAxis = d3.axisBottom()
.scale(x)
.tickFormat(d3.timeFormat("%Y"));

var yAxis = d3.axisLeft()
.scale(y);

svg.append("g")
.attr("class", "axis")
.attr("transform", "translate(0," + (height - padding + smallpad) + ")")
.call(xAxis);

svg.append("g")
.attr("class", "axis")
.attr("transform", "translate(" + (padding - smallpad) + ",0)")
.call(yAxis);