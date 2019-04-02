class Recaptcha
  attr_reader :response_token

  def initialize(response_token, site_key, secret_key)
    @verify_url = "https://www.google.com/recaptcha/api/siteverify"
    @site_key = site_key
    @secret_key = secret_key
    @response_token = response_token
  end

  def verify 
    return true if Rails.env.test?

    response = HTTParty.post("#{@verify_url}?secret=#{@secret_key}&response=#{@response_token}")
    result = JSON.parse(response.body)

    if result["success"]
      return true
    else
      raise "Failed recaptcha! #{result['error-codes'].join(',')}"
    end
  end
end
