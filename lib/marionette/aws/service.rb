require 'aws-sdk'

module Marionette
  module Aws
    class Service
      def initialize
        @client = ::Aws::ECS::Client.new(region: 'ap-northeast-1')
      end

      def client
        @client
      end

      def service_list(cluster_name)
        client.list_services(cluster: cluster_name).service_arns.map {|arn| arn.split('/').last }
      end

      def update_service(cluster_name, service_name, task)
        client.update_service(cluster: cluster_name,
                              service: service_name,
                              task_definition: task)
      end
    end
  end
end
