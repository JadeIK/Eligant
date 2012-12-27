user = 'jade'
apppath = "/home/#{user}/eligant_production"

worker_processes  2
listen            "#{apppath}/shared/sockets/#{user}.sock", :backlog => 64
timeout           30

working_directory "#{apppath}/current"
pid               "#{apppath}/shared/pids/unicorn.pid"
stderr_path       "#{apppath}/shared/log/unicorn.log"
stdout_path       "#{apppath}/shared/log/unicorn.log"

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{apppath}/current/Gemfile"
end