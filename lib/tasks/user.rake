# frozen_string_literal: true

namespace :user do
  desc 'Create user'
  task :create, %i[name surname patronymic_name identification_number tag] => :environment do |_t, args|
    user = User.new(**args.to_h.without(:tag), tags_attributes: [{ name: args.to_h[:name] }])
    if user.save
      puts "SUCCESS: #{user.as_json}"
    else
      puts "FAILURE: #{user.errors.messages.inspect}"
    end
  end
end
