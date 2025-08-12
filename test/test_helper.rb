# test/test_helper.rb
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Mantiene el esquema actualizado para la DB de test
  ActiveRecord::Migration.maintain_test_schema!

  # Ejecuta tests en paralelo
  parallelize(workers: :number_of_processors)

  # Carga fixtures
  fixtures :all

  # Métodos helper para todos los tests pueden ir aquí...
end
