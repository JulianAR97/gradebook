require './config/environment'

use Rack::MethodOverride
if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end


use AssignmentController
use SubjectController
use UserController
run ApplicationController
