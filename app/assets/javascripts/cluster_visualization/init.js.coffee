@init_cluster_visualization = () ->
  cloud = $('.cloud')
  return unless cloud.hasClass('.cluster')
  centers = {}

  width  = 1024
  height = 768

  data = eval cloud.data('json')
  segments = eval cloud.data('segments')
  svg = d3.select('.cloud').append('svg')
  svg.attr('width', width).attr('height', height)

  cloud.css('border', '1px solid #000').css('width', width).css('height', height)

  for i in [1..segments]
    shift = width/(segments+1)
    center_x = shift*i
    center_y = height/2
    centers[i] = svg.append('circle')
    centers[i].attr('cx', center_x).attr('cy', center_y).attr('r', 5).attr('fill', 'green')

  items = svg.selectAll('circle').data(data).enter().append('circle')
  items.attr('cx', (d, i) ->
    eval(centers[d.segment_id].attr('cx')) + d.distance * Math.cos(i)
  ).attr('cy', (d ,i) ->
    eval(centers[d.segment_id].attr('cy')) + d.distance * Math.sin(i)
  ).attr('r', 2).attr('fill', 'brown')
