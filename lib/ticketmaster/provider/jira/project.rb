module TicketMaster::Provider
  module Jira
    # Project class for ticketmaster-jira
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      def initialize(native)
        @system = :jira
        @system_data = {
          :client => Client.new(native)
        }
        super(@system_data[:client].attributes)
      end
      
      class Client
        def initialize(native)
          @native = native
        end
        
        def attributes
          {
            "id" => @native.id,
            "name" => @native.name,
            "description" => @native.description
          }
        end
      end
      #API = Jira::Project # The class to access the api's projects
      # declare needed overloaded methods here
      
      
      # copy from this.copy(that) copies that into this
      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(:title => ticket.title, :description => ticket.description)
          ticket.comments.each do |comment|
            copy_ticket.comment!(:body => comment.body)
            sleep 1
          end
        end
      end

      class API
        class << self
          def find(*args)
            case by = args.first
            when Numeric
              wrap $jira.getProjectById(by)
            when :all, "all"
              $jira.getProjectsNoSchemes().map(&method(:wrap))
            else
              raise "can't find jira project #{by}"
            end
          end

          def wrap(proj)
            Project.new(proj)
          end
        end
      end
    end
  end
end


