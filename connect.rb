require 'rubygems'
require 'bundler/setup'

require 'active_record'
require 'pg'

ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'pg-datatypes-demo')

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.logger.formatter = proc do |severity, datetime, progname, msg|
  "#{msg}\n"
end
