class ApplicationController < ActionController::Base
  def hello
    #render plain: "hello, world!"
    render template: "top"
  end
end
