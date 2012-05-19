namespace :db do
  desc "Drop, create, migrate then seed the database"
  task :reborn => :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  end
end