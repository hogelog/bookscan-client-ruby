class BookscanClient
  module Model
    class Book
      attr_accessor :filename, :hash, :digest, :image_url

      def initialize(filename: nil, hash: nil, digest: nil, image_url: nil)
        @filename = filename
        @hash = hash
        @digest = digest
        @image_url = image_url
      end

      def self.parse_books(page)
        page.search("#sortable_box .showbook").map{|book_link|
          url = "#{BookscanClient::URL::ROOT}#{book_link.attr("href")}"
          params = CGI.parse(URI.parse(url).query)
          next unless %w[f h d].all?{|key| params.keys.include?(key) }
          image = book_link.search("img")

          book = Book.new(filename: params["f"][0], hash: params["h"][0], digest: params["d"][0])
          book.image_url = image[0].attr("data-original") unless image.empty?

          book
        }
      end

      def download_url
        "#{BookscanClient::URL::DOWNLOAD}?d=#{digest}&f=#{CGI.escape(filename)}"
      end
    end
  end
end
