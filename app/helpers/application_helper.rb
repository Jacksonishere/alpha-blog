module ApplicationHelper
  #allows you to call these methods in your views

  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)

    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{options[:size]}"

    image_tag(gravatar_url, alt: user.username, class: "rounded mx-auto mt-3 d-block")
  end

  def current_user
    # should be nil if it doesnt persist
    # byebug
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # byebug
  end

  def logged_in?
    #returns true if there is current_user, else false
    !!current_user
  end
end
