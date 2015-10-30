module Api
  class SpeechController < ApiController
    def speak
      ips = User.joins(:rooms).where(rooms: { name: params[:item][:room][:name] }).pluck(:ip)

      ips.each do |ip|
        conn = Faraday.new(url: ip) do |faraday|
          faraday.request :url_encoded
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
        end

        if params[:event] == "room_notification"
          conn.post "/notify", type: params[:item][:message][:color]
        else
          conn.post "/speak", text: phrase
        end
      end

      render nothing: true
    end

    private

    def phrase
      params[:item][:message][:message][7..-1]
    end
  end
end
