$('.review-rating').remove()
$("body").append("<div class='reveal-modal review-rating blue-theme' data-reveal=''><%=escape_javascript(render partial: 'new') %></div>>");

$(".review-rating").foundation().foundation('reveal', 'open', {"dismissmodalclass": 'close-link'})

$('.review-rating').center()
