module DeploymentWebhook
  class Notifier
    attr_reader :deployment_webhook_url, :application, :stage

    def initialize(deployment_webhook_url:, application:, stage:)
      @deployment_uri = deployment_webhook_url
      @application = application
      @stage = stage
    end

    def send_message
      require 'uri'
      require 'net/https'
      require 'json'

      header = { 'Content-Type': 'text/json' }
      uri = URI.parse(deployment_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, header)

      request.body = {
        application: application,
        user: deployer,
        stage: stage
      }.to_json

      response http.request(request)
    rescue StandardError
      # Do nothing
    end

    private

    def deployer
      name = `git config user.name`.strip
      name = nil if name.empty?
      name ||= Etc.getpwnam(ENV['USER']).gecos || ENV['USER'] || ENV['USERNAME']
      name
    end
  end
end