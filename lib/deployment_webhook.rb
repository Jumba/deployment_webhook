module DeploymentWebhook
  GEM_ROOT = File.dirname(File.dirname(__FILE__))
  LIB_BASE = File.join(GEM_ROOT, 'lib', 'deployment_webhook')
  TASKS_BASE = File.join(GEM_ROOT, 'lib', 'tasks')

  Dir[File.join(LIB_BASE, '*.rb')].each { |file| require(file) }
  Dir[File.join(TASKS_BASE, '*.rake')].each { |file| require(file) }
end
