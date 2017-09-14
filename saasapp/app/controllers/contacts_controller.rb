class ContactsController < ApplicationController
  
  # GET request to /contact-us
  # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # POST request to /contacts after form submission 
  # Return to /contact-us get page
  def create
    #Mass assignement of form field in Contact object
    @contact = Contact.new(contact_params)
    #Save the contact image to the database 
    if @contact.save
      # Store form field via parameters into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into mailer and send email
      ContactMailer.contact_email(name,email,body).deliver
      # Display store success message
      flash[:success] = "Message sent."
      # Redirect to the new action
      redirect_to new_contact_path
    else
      # If contact doesn't save
      # Store errors in flash hash 
      flash[:danger] = @contact.errors.full_messages.join(", ")
      #Redirect to new action
      redirect_to new_contact_path
    end
  end
  
  private 
    # If you collect data from form then 
    # we need to use strong parameters 
    # and whitelist form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end