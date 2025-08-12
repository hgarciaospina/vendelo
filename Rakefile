# Rakefile completo y funcional para Rails 8
require_relative "config/application"

Rails.application.load_tasks

# Tarea para migrar desarrollo y sincronizar test
task :auto_migrate_all do
  puts "📦 Aplicando migraciones pendientes en desarrollo..."
  Rake::Task["db:migrate"].invoke

  puts "📦 Preparando base de datos de test (sincronizando esquema)..."
  Rake::Task["db:test:prepare"].invoke
end

# Alias por compatibilidad
task :auto_prepare => :auto_migrate_all

# Antes de ejecutar tests, prepara las migraciones y test DB
Rake::Task["test"].enhance(["auto_migrate_all"])

# Antes de abrir consola, aplica migraciones
if Rake::Task.task_defined?("console")
  Rake::Task["console"].enhance(["auto_migrate_all"])
end

# Tarea por defecto (ejecutar solo `rake` sin args)
task default: :auto_migrate_all
