require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new

# routes
get '/' do 
	puts params
	@crm_app_name = "rgm crm"
	erb :index
end
	
# create new routes for contacts

#  view all contacts
get '/contacts' do
	erb :contacts
end	

# add a new contact
get '/contacts/new' do
	erb :new
end

# modify an existing contact
get '/contacts/:id/edit' do
	erb :edit
end

# view a contact
get '/contacts/:id' do
	erb :display
end

post "/contacts" do
	# puts params
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect("/contacts")
end


