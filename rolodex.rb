class Rolodex
  attr_reader :contacts

  def initialize
    @contacts = []
    @id = 1000
  end

  # method to add a contact
  def add_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end

  # method to find contact by contact id
  def find(contact_id)
    @contacts.find {|contact| contact.id == contact_id
    }
   end

   # remove contact
   def remove_contact(contact)
    @contacts.delete(contact)
   end 
    
end