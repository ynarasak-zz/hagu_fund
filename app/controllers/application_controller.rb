class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic
  def hello
    #render plain: "hello, world!"
    render template: "top"
  end

  private
    def basic
      name = 'framgia'
      passwd = '21dbd0e487958a56fec41353204ef3ff8e2f1a4c'
      authenticate_or_request_with_http_basic('BA') do |n, p|
        n == name && Digest::SHA1.hexdigest(p) == passwd
      end
    end
end
