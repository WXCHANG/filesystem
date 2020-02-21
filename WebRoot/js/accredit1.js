
$(function() {
    $('.browse').on("click", function() {
        var name = $('#file1').html()
        console.log(name);
        $('#showname').val(name);
    })

})