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
    OPTIMIZED_BOOKS = "https://system.bookscan.co.jp/tunelablist.php"
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
    page.search("#sortable_box .showbook").map{|book_link|
      url = "#{BookscanClient::URL::ROOT}#{book_link.attr("href")}"
      params = CGI.parse(URI.parse(url).query)
      next unless %w[f h d].all?{|key| params.keys.include?(key) }
      image = book_link.search("img")

      book = BookscanClient::Model::Book.new(filename: params["f"][0], hash: params["h"][0], digest: params["d"][0])
      book.image_url = image[0].attr("data-original") unless image.empty?

      book
    }
  end

  def optimized_books
    page = fetch(URL::OPTIMIZED_BOOKS)
    page.search("a.download").map{|book_link|
      url = "#{BookscanClient::URL::ROOT}#{book_link.attr("href")}"
      params = CGI.parse(URI.parse(url).query)
      next unless %w[f d].all?{|key| params.keys.include?(key) }

      BookscanClient::Model::OptimizedBook.new(filename: params["f"][0], digest: params["d"][0])
    }
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
