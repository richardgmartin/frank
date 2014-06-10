require 'sinatra'

get '/' do 
	@crm_app_name = "The RGM CRM"
	erb :index
end
