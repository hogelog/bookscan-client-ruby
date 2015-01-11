require_relative "./test_helper"

describe BookscanClient do
  before do
    stub_requests
    @client = BookscanClient.new
  end

  describe "#books" do
    it "returns book model array" do
      books = @client.books
      assert_equal books.size, 2
      assert_equal books[0].filename, "filename1"
      assert_equal books[0].hash, "hash1"
      assert_equal books[0].digest, "digest1"
      assert_equal books[0].image_url, nil
      assert_equal books[1].filename, "filename2"
      assert_equal books[1].image_url, "http://example.com/hoge.jpg"
    end
  end

  describe "#optimized_books" do
    it "returns optimized_book model array" do
      optbooks = @client.optimized_books
      assert_equal optbooks.size, 2
      assert_equal optbooks[0].filename, "filename1"
      assert_equal optbooks[0].digest, "digest1"
      assert_equal optbooks[1].filename, "filename2"
      assert_equal optbooks[1].digest, "digest2"
    end
  end
end
