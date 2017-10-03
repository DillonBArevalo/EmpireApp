// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$( document ).on('turbolinks:load', function(){
  hideDetailListener();
  upgradeFormListener();
  characterNavListener();
})

var hideDetailListener = function(){
  $('#hide-desc').on('click', function(e){
    e.preventDefault();
    $('.skill-description').toggle();
  });
}

var upgradeFormListener = function(){
  upgradeSingle('#pool_amount', '#budget_amount')
  upgradeSingle('#budget_amount', '#pool_amount')
}

var upgradeSingle = function(primary, other) {
  $(primary).on('change', function(e){
    var max = parseInt($('#unspent_points').html())
    var secondaryValue = max - parseInt($(this).val())
    $(other).val(secondaryValue)
  })
}

var characterNavListener = function(){
  $('.navigate_to_character').on('click', function(e){
    window.location.href = '/characters/' + $(this).closest('ul').find('.select_character').val()
  })
}
