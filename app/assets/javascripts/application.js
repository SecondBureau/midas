// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

drawtables = function() {
    alert('go');
    return $("[data-table]").each(function() {
      var div;
      div = $(this);
      return $.getJSON(div.data("table"), function(datasource) {
        var data, table;
        table = new google.visualization.Table(div.get(0));
        data = new google.visualization.DataTable();
        $.each(datasource.cols, function() {
          return data.addColumn.apply(data, this);
        });
        data.addRows(datasource.rows);
        if (datasource.formatters != null) {
          $.each(datasource.formatters, function(key, val) {
            var formatter;
            formatter = new google.visualization.NumberFormat(val);
            return formatter.format(data, parseInt(key));
          });
        }
        return table.draw(data, datasource.options);
      });
    });
  };