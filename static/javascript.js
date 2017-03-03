$( document ).ready(function() {
            // $.getJSON($SCRIPT_ROOT + '/get_users_list',{},function(data){
            //     console.log(data) ;
            //     users_list = data;
            // });
    var tr;
    tr = true;

    $('.delete-account').on('click', function() {
        if (tr) {
	    $('#'+$(this).attr('id')+'tr').show();
            tr = false;
        } else {
            $('#'+$(this).attr('id')+'tr').hide();
            tr = true;
        }
    });

    $('.nobutton').on('click', function() {
        $('#'+$(this).data("id")+'tr').hide();
        tr = true;
    });

    $('.del_home_dir').on('click', function() {
        var uid = $(this).data("id")
        var c = $('#'+uid+'del_dir').is(':checked');
        console.log(c);
        $.getJSON($SCRIPT_ROOT + '/delete_user', {
            del_dir: c,
            uname: $(this).data("id")
        }, function(data) {
            console.log("logging data");
            console.log(data.result);
            $('#'+uid+'tr').hide();
            $('#'+uid+'ulist').hide();
        });
        return false;
    });

    // $('#cancel').on('click', function() {
    //     $('#'+$(this).attr('id')+'modal').close();
    //     $('#'+$(this).attr('id')+'modal').removeClass('dialog-scale');
    //     clearTimeout(transition);
    // });
});
