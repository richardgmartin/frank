require 'sinatra'
#require_relative 'contact'


get '/' do 
	puts params
	@crm_app_name = "the rgm crm"
	erb :index
end
	

# create a new route for contacts

# add contacts

# get "/contacts" do
#   @contacts = []
#   @contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
#   @contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
#   @contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")

#   erb :contacts
# end

# post "/contacts" do
# 	contact = Contact.new(params[:first_name])
# 	@@rolodex.add_contact(contact)
# 	redirect("/contacts")
# end

# view all contacts
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




