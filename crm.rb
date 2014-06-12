require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new

# temporary fake data to test 'find contact' with id = 1000
@@rolodex.add_contact(Contact.new("Gene", "Simmons", "gene@kiss.com", "Rockstar"))


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

# test view a contact

contact = @@rolodex.find(1000)

get "/contacts/1000" do
	@contact = @@rolodex.find(1000)
	erb :show_contact
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