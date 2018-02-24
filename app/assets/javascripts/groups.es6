$( document ).ready(function() {
   // console.log( "ready!" );
//    hiding browse groups div
    $('#browse_groups').hide();
    $('.groups_back').hide();

    $('#click_browse_groups').on('click', function () {
     // console.log('inside groups browse event');
        $('.hide_groups_interface').hide();
        $('#browse_groups').show();
        $('#browse_my_groups').toggle();
        $('.groups_back').toggle();
    });

    $('#click_browse_my_groups').on('click', function () {
//      console.log('inside my groups event')
//         $('.hide_groups_interface').hide();
//         $('.groups_back').toggle();
    });

    $('#back').on('click', function () {
//      console.log('inside of back event')
        $('.groups_back').toggle();
        $('#browse_groups').hide();
        $('#browse_my_groups').toggle();
        $('.hide_groups_interface').show();
    });

});