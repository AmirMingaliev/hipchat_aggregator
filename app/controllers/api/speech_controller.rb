class Api::SpeechController < Api::ApiController
  def speak
    ips = User.joins(:rooms).where(rooms: { name: params[:item][:room][:name] }).pluck(:ip)
    ips.each do |ip|
      conn = Faraday.new(url: "http://794301c7.ngrok.io") do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      conn.post '/speak', { text: phrase }

    end
    render nothing: true
  end

  private

  def phrase
    params[:item][:message][:message][7..-1]
  end
end
