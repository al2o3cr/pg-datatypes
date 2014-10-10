require 'rubygems'
require 'bundler/setup'

require 'active_record'
require 'pg'

ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'pg-datatypes-demo')

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.logger.formatter = proc do |severity, datetime, progname, msg|
  "#{msg}\n"
end

gem 'dynamometer'
require 'dynamometer/dynamic_attributes_in_where'
require 'dynamometer/dynamic_attributes'

# HAX HAX HAX
# dynamometer does not play nice outside of Rails yet

ActiveRecord::Querying.module_eval do
  delegate :where_dynamic_attributes, to: :all
end

ActiveRecord::Base.class_eval do
  def self.partition_wheres(args); [args,{}]; end
end

ActiveRecord::Relation.send(:include, Dynamometer::DynamicAttributesInWhere)

