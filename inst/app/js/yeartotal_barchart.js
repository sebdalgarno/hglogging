// !preview r2d3 data = data.frame(Year = as.Date(c("1901-01-01", "1952-01-01", "1989-01-01", "2010-01-01")), Colour = c("#E35E00", "#E36200", "#E56E00", "#E56E00"), Total = c(84.6, 96.2, 203, 20))

var barPadding = 0.05;
var scaleFactor = 10;
var padding = 40;
var smallpad = 0;

var palette = d3.quantize(d3.interpolateHcl("#fafa6e", "#2A4858"), data.length);

var parseTime = d3.timeParse("%Y-%m-%d");

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

var bars= r2d3.svg.selectAll("rect")
.data(r2d3.data);

bars.enter().append("rect")
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
.style("fill", function(d, i) { return palette[i]});

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

bars.exit().remove();

bars.transition()
  .duration(100)
  .attr("width", function(d) { return d * width; });