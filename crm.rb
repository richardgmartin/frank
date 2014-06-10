require 'sinatra'
#require_relative 'contact'


get '/' do 
	puts params
	@crm_app_name = "the rgm crm"
	erb :index
end

# get ':name' do
# 	puts params
# 	name = params[:name]
# 	"Hi I'm #{name}"
# end	

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


# get '/contacts/new' do
# 	# bunch of contact
# end

# get '/contacts/:id/edit' do
# 	# bunch of contact
# end

# get '/contacts/:id' do
# 	# bunch of contact
# end




