$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "minitest/autorun"
require "pry"
require "bookscan_client"

require "webmock/minitest"
WEBMOCK_DATADIR = File.expand_path('../data', __FILE__)
WEBMOCK_PAGES = {
    BookscanClient::URL::MYPAGE => "mypage.html",
}
WEBMOCK_PAGES.each do |url, filename|
  path = File.expand_path(filename, WEBMOCK_DATADIR)
  WebMock.
      stub_request(:get, url).
      to_return(body: File.new(path), status: 200, headers: { 'Content-Type' => 'text/html' })
end
