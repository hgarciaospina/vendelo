# lib/tasks/test_prepare.rake
namespace :test do
  task :sync_db do
    # Solo aplica migraciones si hay pendientes
    if ActiveRecord::Base.connection.migration_context.needs_migration?
      puts "🔄 Migrating development database..."
      Rake::Task["db:migrate"].invoke
    else
      puts "✅ Development DB already up to date."
    end

    puts "🔄 Preparing test database..."
    Rake::Task["db:test:prepare"].invoke
  end
end

# Ejecutar sincronización antes de cualquier test
Rake::Task["test"].enhance(["test:sync_db"])
