namespace :user do
    desc "Create user"
    task :create, [:name, :surname, :patronymic_name, :identification_number, :tag] => :environment do |t, args|
     user = User.new(**args.to_h.without(:tag), tags_attributes: [{name: args.to_h[:name]}])
     if user.save
      puts "SUCCESS: #{user.as_json}"
     else
      puts "FAILURE: #{user.errors.messages.inspect}"
     end
    end
end
