jQuery ($) ->
  oTable = $('#entries').dataTable
  	sPaginationType: "full_numbers"
  	bJQueryUI:true
  	iDisplayLength:50
  	fnFooterCallback:(nFoot, aData, iStart, iEnd, aiDisplay) ->
      cells = nFoot.getElementsByTagName('th')
      for cell, i in cells
        if cell.className.indexOf("number") >= 0
          total = 0
          for index in aiDisplay
            row = aData[index]
            total = parseFloat total + parseFloat row[i]
          cells[i].innerHTML = parseFloat total
    "aoColumnDefs":[
      { "sType": "date", "aTargets": [0]}
    ]