module TicketMaster::Provider
  module Jira
    # Ticket class for ticketmaster-jira
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      #API = Jira::Ticket # The class to access the api's tickets
      # declare needed overloaded methods here
      def initialize(native)
        native = native.kind_of?(API) ? native.issue : native
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
            "status" => @native.status,
            "priority" => @native.priority,
            "title" => @native.summary,
            "resolution" => @native.resolution,
            "created_at" => @native.created,
            "update_at" => @native.updated,
            "description" => @native.description,
            "assignee" => @native.assignee,
            "requestor" => @native.reporter
          }
        end
      end
      class API
        attr_reader :issue
        def initialize(options)
          @options = options
          @issue = Jira4R::V2::RemoteIssue.new
          for key, value in options
            @issue.send("#{key}=",value) if @issue.respond_to?("#{key}=")
          end
          puts "issue: #{@issue.inspect}"
        end

        def save
          Ticket.new($jira.createIssue(@issue))
        end

        class << self
          def find(by, options)
            case by
            when :all, "all"
              $jira.getIssuesFromJqlSearch("project = #{options[:params][:project_id]}", 25).map(&method(:wrap))
            else
              raise "don't understand query #{by}"
            end
          end

          def wrap(native)
            Ticket.new(native)
          end
        end
      end

    end
  end
end
