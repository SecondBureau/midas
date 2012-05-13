jQuery ($) ->
  if $("[data-table]").length > 0
    $.getScript "https://www.google.com/jsapi", (data, textStatus) ->
      google.load "visualization", "1.0",
        packages: [ "corechart", "table" ]
        callback: ->
          $("[data-table]").each ->
            div = $(this)
            
            $.getJSON div.data("table"), (datasource) ->
              
              table = new google.visualization.Table(div.get(0))
              
              data = new google.visualization.DataTable()
              
              $.each datasource.cols, ->
                data.addColumn.apply data, this
              
              data.addRows datasource.rows
              
              if datasource.formatters? 
                $.each datasource.formatters, (key, val) ->
                  formatter = new google.visualization.NumberFormat(val)
                  formatter.format(data, parseInt(key))
              
              table.draw data, datasource.options
              
              
              
              