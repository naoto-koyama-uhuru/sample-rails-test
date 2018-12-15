RSpec.configure do |config|
  config.include include FactoryBot::Syntax::Methods
  config.before(:all) do
    FactoryBot.reload
  end
end
