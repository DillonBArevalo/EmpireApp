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
  navButtonListener();
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
  $('body').on('change', '.select_character', function(e){
    window.location.href = '/characters/' + $(this).val()
  })
}

var navButtonListener = function(){
  $('#nav-button').on('click', function(){
    navButtonFlipper($(this))
    closeNavListener()

    if($('#dropdown-panel').length > 0){
      $('#dropdown-panel').remove()
    }else{
      $.ajax({
        url: '/navigation'
      })
    }
  })
}

var closeNavListener = function(){
  $('#content').on('click', removeDropdown)
}

var removeDropdown = function(){
  if($('#dropdown-panel').length > 0){
      navButtonFlipper($('#nav-button'))
      $('#dropdown-panel').remove()
      $('#content').unbind('click', removeDropdown)
    }
}

var navButtonFlipper = function(nav){
  if(nav.attr('style')){
      nav.removeAttr('style')
    }else{
      nav.css('flex-direction', 'column')
    }
}
