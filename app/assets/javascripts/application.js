//= require jquery
//= require rails-ujs
//= require turbolinks
//= require popper
//= require bootstrap
//= require_tree .

$(function() {
  $('.slides').slick({
    dots: true,
    autoplay: true,
    autoplaySpeed: 2000,
  });
});