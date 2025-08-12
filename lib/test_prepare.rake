namespace :test do
  task :prepare_db do
    puts "🔄 Preparing test database..."
    Rake::Task["db:test:prepare"].invoke
  end
end

# Ejecutar la preparación de DB antes de cada test
Rake::Task["test"].enhance(["test:prepare_db"])
