let parallax5 = document.getElementById("parallax5");

window.addEventListerner('scroll', function(){
    var value = window.scrollY;

    parallax5.style.top = value * 0.5 + 'px'; 

})