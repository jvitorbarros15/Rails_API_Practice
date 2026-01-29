require "rails_helper"

describe "Books API", type: :request do
  let(:first_author) { FactoryBot.create(:author, first_name: "George", last_name: "Orwell", age: 46) }
  let(:second_author) { FactoryBot.create(:author, first_name: "JK", last_name: "Rowling", age: 58) }
  let(:third_author) { FactoryBot.create(:author, first_name: "JRR", last_name: "Tolkien", age: 83) }
  describe "GET /books" do

    before do
      FactoryBot.create(:book, title: "1984", author: first_author)
      FactoryBot.create(:book, title: "Harry Potter", author: second_author)
      FactoryBot.create(:book, title: "The Hobbit", author: third_author)
    end
    it 'returns all books' do
      get "/api/v1/books"

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(3)
      expect(response_body).to eq(
        [
          {
          'id' => 1,
          'title' => "1984",
          'author_name' => "George Orwell",
          'author_age' => 46,
          },
          {
          'id' => 2,
          'title' => "Harry Potter",
          'author_name' => "JK Rowling",
          'author_age' => 58,
          },
          {
          'id' => 3,
          'title' => "The Hobbit",
          'author_name' => "JRR Tolkien",
          'author_age' => 83,
          }
        ]
     )
    end
  end

  describe "POST /books" do
    it 'creates a new book' do
      expect {
        post "/api/v1/books", params: {
          book: {title: "Dune"},
          author:  {first_name: "Frank", last_name: "Herbert", age: '65'}
        }
      }.to change(Book, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(response_body).to eq(
        {
        'id' => 1,
        'title' => "Dune",
        'author_name' => "Frank Herbert",
        'author_age' => 65,
        }
      )
    end
  end

  describe "DELETE /books/:id" do
    let!(:book) { FactoryBot.create(:book, title: "To Kill a Mockingbird", author: first_author) }
    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change(Book, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
