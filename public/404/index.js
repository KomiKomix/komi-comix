$(function() {
    var writeText = function(tag, input, iterator, timer) {
        setTimeout(function() {
            $(tag).append(input);
        }, timer * iterator);
    };

    var leadingZero = function(n) {
        return (n < 10) ? ("0" + n) : n;
    };

    var text_1 = $('.demo-text span').html(),
        text_2 = $('.demo-text p').html(),
        time = 125;

    $('.demo-text span').html("");
    $('.demo-text p').html("");

    (function() {
        for (var i = 1; i <= text_1.length; i++) {
            var char = text_1[i - 1];
            writeText(".demo-text span", char, i, time);
        }
    })();

    (function() {
        setTimeout(function() {
            for (var i = 1; i <= text_2.length; i++) {
                var char = text_2[i - 1];
                writeText(".demo-text p", char, i, time);
            }
        }, (text_1.length + 2) * 150);
    })();

    (function() {
        $('.demo-coins').html("");

        setInterval(function() {
            var date = new Date(),
                hours = date.getHours().toString(),
                minutes = leadingZero(date.getMinutes()),
                seconds = leadingZero(date.getSeconds());

            $('.demo-time').html(hours + minutes);
            $('.demo-coins').html(seconds);
        }, 1);
    })();
});