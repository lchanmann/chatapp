require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  it { expect(get('/')).to route_to("home#index") }
end
