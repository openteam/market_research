@init_circle_visualization = () ->
  data = {
    source: {
      name: 'root',
      children: [
        {
          name: 'Новосибирск',
          children: [
            {
              name: 'ССУЗ',
              children: [
                {
                  name: 'ССУЗ1',
                  size: 10
                },
                {
                  name: 'ССУЗ2',
                  size: 20
                }
              ]
            }
          ]
        },
        {
          name: 'Томск',
          children: [
            {
              name: 'ССУЗ',
              children: [
                {
                  name: 'ССУЗ1',
                  size: 5
                },
                {
                  name: 'ССУЗ2',
                  size: 15
                }
              ]
            },
            {
              name: 'ВУЗ',
              children: [
                {
                  name: 'ВУЗ1',
                  size: 50
                },
                {
                  name: 'ВУЗ2',
                  size: 80
                }
              ]
            }
          ]
        }
      ]
    },

    size: (key, obj) ->
      obj ?= this.source
      s = 0

      if typeof(obj[key]) == 'object'
        for i of obj[key]
          s += this.size(i, obj[key])
      else if typeof(obj[key]) == 'number'
        s += obj[key]
      s
  }

  cloud = $('.cloud')
  return unless cloud.hasClass('circle')

  width =  800
  height = 600

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

  node = svg.datum(data.source).selectAll('.node').data(pack.nodes).enter().append('g').attr(
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
    d.name + (if d.children then '' else ': ' + d.size)
  ).attr(
    color: '#000000',
    'font-family': 'sans-serif',
    'font-size': '10px'
  ).attr('y', (d) ->
    -d.r+10
  ).style('text-anchor', 'middle')
