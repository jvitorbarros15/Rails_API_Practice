require "rails_helper"

RSpec.describe Api::V1::BooksController, type: :controller do
  describe "GET index" do
    it 'has a max limit of 100' do
        expect(Book).to receive(:limit).with(100).and_call_original

        get :index, params: { limit: 999 }
    end
  end

  describe "POST create" do
    let(:book_name) { 'Test Book' }
    it 'calls UpdateSkuJob with correct params' do
      expect(UpdateSkuJob).to receive(:perform_later).with(book_name)
      post :create, params: {
        book: { title: book_name },
        author: { first_name: 'John', last_name: 'Doe', age: 30 } }
    end
  end
end
