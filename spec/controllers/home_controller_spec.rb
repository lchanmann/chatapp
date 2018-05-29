require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before do
    allow(REDIS).to receive(:incr).with('user_count').and_return(1)
  end

  describe 'GET #index' do
    it "assigns username" do
      expect {
        get :index
      }.to change { cookies.signed[:current_username] }.to eq("User1")
    end

    it "does not assign username when already exists" do
      cookies.signed[:current_username] = 'test'
      expect {
        get :index
      }.not_to change { cookies.signed[:current_username] }
    end
  end
end
