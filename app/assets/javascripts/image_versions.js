
$(document).ready(function() {
    $('aside .compare-button').toggle(
        function() {
            $('div.iphone.previous-version').transition({ left: '100px' }, 800, 'in-out');
            $('div.iphone.current-version') .transition({ left: '500px' }, 800, 'in-out');
            $('div.iphone .version-number') .transition({opacity: '1' }, 800, 'in-out');
        },
        function() {
            $('div.iphone.previous-version').transition({ left: '300px' }, 800, 'in-out');
            $('div.iphone.current-version') .transition({ left: '300px' }, 800, 'in-out');
            $('div.iphone .version-number') .transition({opacity: '0' }, 800, 'in-out');
        }
    );

    $('div.iphone.current-version .screenshot-portrait').scroll(function () { 
        $('div.iphone.previous-version .screenshot-portrait').scrollTop($('div.iphone.current-version .screenshot-portrait').scrollTop());
    });
    $('div.iphone.previous-version .screenshot-portrait').scroll(function () { 
        $('div.iphone.current-version .screenshot-portrait').scrollTop($('div.iphone.previous-version .screenshot-portrait').scrollTop());
    });


});