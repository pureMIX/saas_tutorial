/* global $ Stripe */
//Document ready
$(document).on('turbolinks:load',function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-signup-btn');
  //Set Stripe public key
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  submitBtn.click(function(event){
    //When user clicks prevent default submission behavior
    event.preventDefault();
    submitBtn.val("Processing").prop("disabled", true);
    
    //Collect card fields
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
        
    //Use Stripe JS Library to check for card errors
    var error =false;
    //Validate card number
    if(!Stripe.card.validateCardNumber(ccNum) || !Stripe.card.validateCVC(cvcNum) || !Stripe.card.validateExpiry(expMonth,expYear)){
      error =true;
      alert('The credit card fields appears to be invalid');
    }
    
    
    //Send card info to Stripe
    if(error){
      //If there are any card errors then don't send it to stripe and reactivate button
      submitBtn.val("Sign Up").prop("disabled",false);
    }
    else{
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_Year: expYear
      },stripeResponseHandler); 
    }
    return false;
    
  });
 
  //Stripe will send a card token
  function stripeResponseHandler(status,response){
    //Get the token from the response
    var token =  response.id;
    
    //Inject the card token with a hidden field
    theForm.append($('<input type ="hidden" name="user[stripe_card_token]">').val(token));
    
    //Submit form to the rails app.
    theForm.get(0).submit();
    
  }
  
});
