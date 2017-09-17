/* global $ Stripe */
//Document ready
$(document).on('turbolinks:load',function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-submit-btn');
  //Set Stripe public key
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  submitBtn.click(function(event){
    //When user clicks prevent default submission behavior
    event.preventDefault();
    //Collect card fields
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    //Send card info to Stripe
    Stripe.createToken({
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_Year: expYear
    },stripeResponseHandler); 
    
  });
 
  //Stripe will send a card token
  //INject card token to form
  //Submit form to the rails app.
});
