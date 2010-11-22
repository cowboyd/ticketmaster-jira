module TicketMaster::Provider
  module Jira
    # Project class for ticketmaster-jira
    #
    #
    class Project < TicketMaster::Provider::Base::Project
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
        def self.find(*args)
          case args.first
          when Numeric
            raise "what the hell, jira projects don't have indexes"
          when :all, "all"
            $jira.getProjectsNoSchemes().map do |proj|
            {
              :id => proj.key,
              :name => proj.name,
              :description => proj.description,
              :system => :jira,
              :system_data => proj
            }
          end
          else
            raise "can't find jira project #{args.first}"
          end
        end
      end
    end
  end
end


