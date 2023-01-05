# frozen_string_literal: true

require 'English'
require 'os'
require 'pathname'
require 'fileutils'

def get_env_variable(key)
  ENV[key].nil? || ENV[key] == '' ? nil : ENV[key]
end

def run_command(cmd)
  puts "@@[command] #{cmd}"
  output = `#{cmd}`
  raise "Command failed. Check logs for details \n\n #{output}" unless $CHILD_STATUS.success?

  output
end

def install_firebase(path)
  version = get_env_variable('AC_FIREBASE_VERSION').nil? ? 'latest' : ENV['AC_FIREBASE_VERSION']
  os = OS.mac? ? 'macos' : 'linux'
  FileUtils.mkdir_p(path) unless File.directory?(path)
  run_command("curl -L https://firebase.tools/bin/#{os}/#{version} -o #{path}/firebase")
  run_command("chmod +rx #{path}/firebase")
end

web_path = get_env_variable('AC_FIREBASE_PROJECT_PATH')
raise 'Project path is empty' if web_path.nil?

token = get_env_variable('AC_FIREBASE_TOKEN')
service_account = get_env_variable('GOOGLE_APPLICATION_CREDENTIALS')
extra_parameters = get_env_variable('AC_FIREBASE_EXTRA_PARAMETERS')

raise 'No token or service account provided.' if token.nil? && service_account.nil?

raise 'Either use token or service account, not both.' if !token.nil? && !service_account.nil?

ac_temp = get_env_variable('AC_TEMP_DIR') || abort('Missing AC_TEMP_DIR variable.')
firebase_path = File.join(ac_temp, 'firebasetools')
install_firebase(firebase_path)
cmd = "cd \"#{web_path}\" && #{firebase_path}/firebase deploy"
cmd += " --token \"#{token}\"" unless token.nil?
cmd += " #{extra_parameters}" unless extra_parameters.nil?
result = run_command(cmd)
puts result
exit 0
