require "bookscan_client/version"
require "bookscan_client/model"

require "uri"
require "cgi/util"
require "mechanize"
require "logger"

class BookscanClient
  module URL
    ROOT = "https://system.bookscan.co.jp/"
    LOGIN = "https://system.bookscan.co.jp/login.php"
    MYPAGE = "https://system.bookscan.co.jp/bookshelf_all_cover.php"
    DOWNLOAD = "https://system.bookscan.co.jp/download.php"
  end

  def initialize(logger: Logger.new(STDOUT), sleep: 0.5)
    @mechanize = Mechanize.new
    @logger = logger
    @sleep = sleep
  end

  def login(email, password)
    @mechanize.post(URL::LOGIN, "email" => email, "password" => password)
  end

  def login?
    names = cookies.map(&:name)
    names.include?("email") && names.include?("password")
  end

  def books
    page = fetch(URL::MYPAGE)
    BookscanClient::Model::Book.parse_books(page)
  end

  def cookies
    @mechanize.cookies
  end

  private

  def fetch(url)
    @logger.info("GET #{url}...")
    @mechanize.get(url)
  end
end
