$( document ).ready(function() {
//    console.log( "ready!" );
//    hiding groups
    $('#browse_groups').hide();
    $('.groups_back').hide();

    $('#click_browse_groups').on('click', function () {
//      console.log('inside groups browse event');
        $('#browse_groups').show();
        $('.hide_groups_interface').hide();
        $('.groups_back').toggle();
    });

    $('#click_browse_my_groups').on('click', function () {
//      console.log('inside my groups event')
        $('#my_groups').show();
        $('.hide_groups_interface').hide();
        $('.groups_back').toggle();
    });

    $('#back').on('click', function () {
//      console.log('inside of back event')
        $('.groups_back').toggle();
        $('#browse_groups').hide();
        $('#my_groups').hide();
        $('.hide_groups_interface').show();
    });

});