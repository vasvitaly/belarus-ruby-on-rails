$(document).ready(function(){
    $('.edit_meetup .datepicker').datetimepicker({
        minDate: 0,
        dateFormat: 'yy-mm-dd',
        timeFormat: 'hh:mm'
    });
    $('.datepicker').datepicker({
        dateFormat: 'yy-mm-dd'
    });
});
