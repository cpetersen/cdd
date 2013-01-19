require 'cdd'

def fake_response(body)
  net_http_resp = Net::HTTPResponse.new(1.0, 200, "OK")
  # net_http_resp.add_field 'Set-Cookie', 'Monster'
  RestClient::Response.create(body, net_http_resp, nil)
end
