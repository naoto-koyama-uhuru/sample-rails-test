require 'factory_bot'
include FactoryBot::Syntax::Methods
FactoryBot.definition_file_paths = [ Rails.root.join('spec', 'factories') ]
FactoryBot.reload
