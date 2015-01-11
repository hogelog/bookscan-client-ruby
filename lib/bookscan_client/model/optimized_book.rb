class BookscanClient
  module Model
    class OptimizedBook
      attr_accessor :filename, :digest

      def initialize(filename: nil, digest: nil)
        @filename = filename
        @digest = digest
      end

      def download_url
        "#{BookscanClient::URL::DOWNLOAD}?d=#{digest}&f=#{CGI.escape(filename)}&optimize=1"
      end
    end
  end
end
