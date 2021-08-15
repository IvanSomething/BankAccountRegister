namespace :user do
    desc "Create user"
    task :create, [:name, :surname, :patronymic_name, :identification_number] => :environment do |t, args|
     user = User.new(args.to_h)
     if user.save
      puts "SUCCESS: #{user.as_json}"
     else
      puts "FAILURE: #{user.errors.messages.inspect}"
     end
    end
end