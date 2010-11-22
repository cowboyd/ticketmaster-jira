require 'jira4r'
module TicketMaster::Provider
  # This is the Jira Provider for ticketmaster
  module Jira
    include TicketMaster::Provider::Base
    #TICKET_API = Jira::Ticket # The class to access the api's tickets
    #PROJECT_API = Jira::Project # The class to access the api's projects
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Jira.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:jira, auth)
    end
    
    # Providers must define an authorize method. This is used to initialize and set authentication
    # parameters to access the API
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      $jira = Jira4R::JiraTool.new(2,@authentication.url)
      $jira.login(@authentication.username, @authentication.password)
      # Set authentication parameters for whatever you're using to access the API
    end
    
    # declare needed overloaded methods here
    
  end
end


