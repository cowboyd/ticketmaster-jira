module TicketMaster::Provider
  module Jira
    # Ticket class for ticketmaster-jira
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      #API = Jira::Ticket # The class to access the api's tickets
      # declare needed overloaded methods here
      
      class API
      end
    end
  end
end
