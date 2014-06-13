# require_relative 'rolodex'
# require_relative 'contact'
require 'sinatra'
require 'data_mapper'

# @@rolodex = Rolodex.new

# temporary fake data to test 'find contact' with id = 1000
# @@rolodex.add_contact(Contact.new("Gene", "Simmons", "gene@kiss.com", "Rockstar"))
# @@rolodex.add_contact(Contact.new("Brad", "Pitt", "brad@pitt.com", "Moviestar"))
# @@rolodex.add_contact(Contact.new("Usain", "Bolt", "usain@bolt.com", "Trackstar"))

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String

	def fullname
		"#{first_name} #{last_name}"
	end	

	# attr_accessor :id, :first_name, :last_name, :email, :note, :fullname

	# def initialize(first_name, last_name, email, note)
	# 	@first_name = first_name
	# 	@last_name = last_name
	# 	@email = email
	# 	@note = note
	# 	@fullname = first_name + ' ' + last_name
	# end
end	

DataMapper.finalize
DataMapper.auto_upgrade!

# ROUTE DEFINITIONS

# home page route
get '/' do 
	puts params
	@crm_app_name = "rgm crm"
	erb :index
end
	
#  view all contacts route
get '/contacts' do
	@contacts = Contact.all
	erb :contacts
end	

# add a new contact route
get '/contacts/new' do
	erb :new_contact
end

# view a contact route
get '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end			
end

# create a contact route
post "/contacts" do
	new_contact = Contact.create(
		:first_name => params[:first_name], 
		:last_name => params[:last_name], 
		:email => params[:email], 
		:note => params[:note]
	)
	redirect to("/contacts")
end

# modify an existing contact route
get '/contacts/:id/edit' do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end		
end	

put "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		contact_update = @contact.update(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
		)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end	


# delete a contact route
delete "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.destroy
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end			




