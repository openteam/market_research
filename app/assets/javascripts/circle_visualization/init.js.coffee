@init_circle_visualization = () ->
  cloud = $('.cloud')
  return unless cloud.hasClass('circle')

  width =  2048
  height = 1600

  cloud.css(
    border: '1px solid #000',
    height: height,
    margin: '20px auto',
    width: width
  )

  svg = d3.select('.cloud.circle').append('svg').attr(
    height: height,
    width: width
  )

  pack = d3.layout.pack().size([width, height]).value((d) ->
    d.size
  )

  d3.json(window.location+'/data', (error, data) ->
    node = svg.datum(data).selectAll('.node').data(pack.nodes).enter().append('g').attr(
      class: (d) ->
        if d.children
          'node'
        else
          'leaf node'
      ,
      transform: (d) ->
        'translate('+ d.x + ', '+ d.y + ')'

    )


    node.append('circle').attr(
      r: (d) ->
        d.r
      ,
      fill: 'rgba(31, 119, 180, 0.25)'
      stroke: 'rgb(31, 119, 180)'
    )

    node.append('text').text((d) ->
      d.name + ': ' + d.size
    ).attr(
      color: '#000000',
      'font-family': 'sans-serif',
      'font-size': '10px'
    ).attr('y', (d) ->
      -d.r+10
    ).style('text-anchor', 'middle')
  )
