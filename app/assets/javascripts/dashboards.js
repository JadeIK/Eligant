$(document).ready(function(){
//    alert('hello');
//    $('#login-form').hide();
})
function toggle(id) {
    var e = document.getElementById(id);
    if (e.style.display == 'none'){
        $(e).slideDown();
//        e.style.display = '';
    }else{
//        e.style.display = 'none';
        $(e).slideUp();
    }
}