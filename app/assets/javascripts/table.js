
    
$(function() {

  var $table = $('table').tablesorter({
    theme: 'bootstrap',
    headerTemplate : '{content} {icon}',
    sortList: [[0,0], [1,0]],
    widgets : [ "uitheme", "zebra", "filter" ],
    widgetOptions : {
          // filter_anyMatch replaced! Instead use the filter_external option
          // Set to use a jQuery selector (or jQuery object) pointing to the
          // external filter (column specific or any match)
          filter_external : '.search',
          filter_columnFilters : false,
          filter_reset: '.reset'
        }
  });

});

