require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:username) { 'test' }

  it "identifies current_user from cookies" do
    connect cookies: { current_username: username }
    expect(connection.current_user).to eq(username)
  end

  it "rejects unauthorized connection" do
    expect {
      connect
    }.to have_rejected_connection
  end
end
