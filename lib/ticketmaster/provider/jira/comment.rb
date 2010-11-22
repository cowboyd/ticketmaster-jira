module TicketMaster::Provider
  module Jira
    # The comment class for ticketmaster-jira
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TicketMaster::Provider::Base::Comment
      #API = Jira::Comment # The class to access the api's comments
      # declare needed overloaded methods here
      
      class API
        def find(*args)
          puts "ARGS: #{args.join(", ")}"
          []
        end
      end
    end
  end
end
