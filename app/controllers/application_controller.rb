# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem
  after_filter :log_runtimes
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private
  def log_runtimes
    return if response.headers['Status'] == '304 Not Modified' || !(response.body and response.body.respond_to?(:sub!))
   
    db_runtime = ((0 + (@db_rt_before_render || 0) + (@db_rt_after_render || 0))* 1000).truncate
    rendering_runtime = ((@rendering_runtime || 0)* 1000).truncate
    total_runtime = ((@total_runtime || 0)* 1000).truncate
    logger.info "total : #{total_runtime} ms, db : #{db_runtime} ms, render : #{rendering_runtime} ms"
  
  end
end
