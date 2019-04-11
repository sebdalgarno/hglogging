// !preview r2d3 data= data.frame(Color = c("#E35E00", "green", "orange"), Total = c(0.1, 0.2, 0.3))
//
// r2d3: https://rstudio.github.io/r2d3
//

var barHeight = Math.ceil(height / data.length);

svg.selectAll('rect')
  .data(data)
  .enter().append('rect')
    .attr('width', function(d) { return d.Total * width; })
    .attr('height', barHeight)
    .attr('y', function(d, i) { return i * barHeight; })
    .attr('fill', function(d){ return d.Color});
