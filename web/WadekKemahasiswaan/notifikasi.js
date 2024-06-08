/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/** 
 * Untuk mereload notifikasi
 * @param {type} id
 * @param {type} view
 * @returns {undefined}
 */
function load_unseen_notification(id='', view=''){
    
    $.ajax({
        url:"../CountNotifikasiWadek",
        method:"POST",
        data:{id:id, view:view},
        dataType:"json",
        success:function(data){
            if(data.unseen_notification > 0){
                $('.count').text(data.unseen_notification);
            }
        }
    });
}

$(document).ready(function() {
    load_unseen_notification(ID_USER, '');
    
    setInterval(function(){
        load_unseen_notification(ID_USER, '');
    }, 5000);
    
    $(document).on('click', '.dropdown-toggle', function(){
        $('.count').text('');
        window.location = 'Notifikasi.jsp';
        load_unseen_notification(ID_USER,'yes');
    });
});

/** Menentukan menu-page yang aktif*/
$(function(){
    $('a').each(function(){
        if($(this).prop('href') === window.location.href){
            $(this).addClass('current');
        }
    });
})();