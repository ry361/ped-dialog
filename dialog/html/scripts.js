$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            $('.dialog-container').css('display', 'none');
            $.post('https://diyalog/closeMenu', JSON.stringify({}));
        break;
    }
});

$(document).on('click', '#accept', function(e){
    $.post('https://diyalog/accept', JSON.stringify({}));
});

$(document).on('click', '#reject', function(e){
    $.post('https://diyalog/reject', JSON.stringify({}));
});

window.addEventListener('message', function (event) {
    NobleUI(event.data);
});

window.addEventListener('message', function (event) {
	let data = event.data
	if(data.action == 'menu') {
        if (data.display == true) {
            $('.dialog-container').css('display', 'block');
        } else {
            $('.dialog-container').css('display', 'none');
        }
    }
}); 

function NobleUI(data) {
    $('#question').html(data.question);
    $('#accept p').html(data.accept);
    $('#reject p').html(data.reject);
    $('#man').html(data.man);
}