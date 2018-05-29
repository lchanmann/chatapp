require 'rails_helper'

RSpec.describe 'Chat stories' do
  before do
    allow(REDIS).to receive(:incr).with('user_count').and_return(1, 2, 3)
  end

  it "displays chat app" do
    visit root_url

    expect(page).to have_selector('h1', text: 'Public chat')
    within('#message-input') do
      expect(page).to have_selector('.username', text: 'User1')
      expect(page).to have_selector('textarea')
      expect(page).to have_selector('button')
    end
  end

  it "assigns username for each session" do
    visit root_url
    expect(page).to have_selector('.username', text: 'User1')

    using_session('other session') do
      visit root_url
      expect(page).to have_selector('.username', text: 'User2')
    end

    using_session('yet another session') do
      visit root_url
      expect(page).to have_selector('.username', text: 'User3')
    end
  end

  it "does not assign user for same session" do
    visit root_url
    visit root_url

    expect(page).to have_selector('.username', text: 'User1')
  end

  describe "send message to chatroom" do
    let(:message_text) { 'hello' }

    subject do
      visit root_url

      fill_in('messageText', with: message_text)
      click_button 'Send'
    end

    it "renders sent message" do
      subject
      expect(page).to have_selector('#message-list li', text: "User1: #{message_text}")
    end

    it "renders message sent by other" do
      visit root_url
      using_session('other') do
        visit root_url
        subject
      end

      expect(page).to have_selector('#message-list li', text: "User2: #{message_text}")
    end

    it "clears message input text" do
      subject
      expect(find_field('messageText').value).to be_blank
    end
  end
end
