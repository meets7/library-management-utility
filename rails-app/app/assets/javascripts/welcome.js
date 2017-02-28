var ready = function() {
    $(".search-box").click(function(){
        $(".tiles").hide("slow");
        $(".search").show("slow").focus();
    });
};

$(document).ready(ready);
$(document).on('page:change', ready);