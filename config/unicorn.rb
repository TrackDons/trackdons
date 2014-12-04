# config/unicorn/staging.rb
app_path = "/var/www/trackdons.org"
 
worker_processes   1
preload_app        true
timeout            180
listen             '127.0.0.1:9021'
user               'deploy', 'deploy'
working_directory  app_path
pid                "#{app_path}/tmp/pids/unicorn.pid"
stderr_path        "log/unicorn.log"
stdout_path        "log/unicorn.log"
 
before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
 
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
 
after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end