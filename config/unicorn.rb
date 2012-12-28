rails_root = File.dirname(__FILE__).gsub(/config$/, "")
pid_file = "#{rails_root}/tmp/pids/unicorn.pid"
socket_file= "#{rails_root}/tmp/unicorn.sock"
log_file = "#{rails_root}/log/unicorn.log"
err_log = "#{rails_root}/log/unicorn_error.log"

timeout 30
worker_processes 2
listen socket_file, :backlog => 64
pid pid_file
stderr_path err_log
stdout_path log_file

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end