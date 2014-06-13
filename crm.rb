require_relative 'rolodex'
# require_relative 'contact'
require 'sinatra'
require 'data_mapper'

@@rolodex = Rolodex.new

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
	erb :new_contact
end


# modify an existing contact
get '/contacts/:id/edit' do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end		
end

# test view a contact

# contact = @@rolodex.find(1000)

# get "/contacts/1000" do
# 	@contact = @@rolodex.find(1000)
# 	erb :show_contact
# end	

# view a contact
get '/contacts/:id' do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end			
end

post "/contacts" do
	# puts params
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect("/contacts")
end

put "/contacts/:id" do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end	

delete "/contacts/:id" do
	puts "<<<<<<<<"
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		@@rolodex.remove_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end			




