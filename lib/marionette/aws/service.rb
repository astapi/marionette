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

      def current_task_definition(cluster_name, service_name)
        ret = client.describe_services cluster: cluster_name, services: [service_name]
        #TODO cluster, service がない場合の処理を書く必要あり
        ret.services.first.to_h[:task_definition].split('/').last
      end

      def update_service(cluster_name, service_name, task)
        client.update_service(cluster: cluster_name,
                              service: service_name,
                              task_definition: task)
      end
    end
  end
end
