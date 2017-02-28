(function() {
    var tabs = $('.tab');
    
    tabs.on('click', function(e) {
        var checkbox = $(this).parents('label').prev();
        
        // Fix for all tabs collapsing when click is within the area taken up by a button
        if (e.target.tagName === 'BUTTON') {
            $(checkbox).prop('checked', true);
        }
        
        // Don't collapse the currently open tab when clicked on
        if (checkbox.is(':checked')) {
            e.preventDefault();
        }
        
        // Allow only one tab to be open at a time
        checkbox.siblings('input:checkbox').prop('checked', false);
    });
})();

