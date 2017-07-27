require 'marionette'
require 'aws-sdk'

module Marionette
  module Aws
    class Task
      def initialize
        @client = ::Aws::ECS::Client.new(region: 'ap-northeast-1')
      end

      def client
        @client
      end

      def task_name_list
        client.list_task_definition_families.families
      end

      def run_task(task)
      end

      def update_task(task_name, options = {})
        # get latest revision
        latest_revision = client.list_task_definitions(family_prefix: task_name).to_h[:task_definition_arns].last.split('/').last

        # get now container definition
        container_definitions = client.describe_task_definition(task_definition: latest_revision).task_definition.to_h[:container_definitions]
        if options[:update_environment]
          container_definitions = update_container_environment(container_definitions, options[:update_environment])
        end

        client.register_task_definition family: task_name, container_definitions: container_definitions
      end

      private
        def update_container_environment(container_definitions, update_environment)
          container_definitions.map do |c|
            update_environment.each do |ue|
              if c[:name] == ue[:container_name]
                ue[:environment].each do |key, value|
                  c[:environment] << { name: key.to_s, value: value }
                end
                #c[:environment].each do |e|
                #end
              end
            end
            c
          end
        end
    end
  end
end
