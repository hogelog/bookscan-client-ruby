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

      def download_url
        "#{BookscanClient::URL::DOWNLOAD}?d=#{digest}&f=#{CGI.escape(filename)}"
      end
    end
  end
end
