ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# 🔹 Garantiza que la base de datos de test esté actualizada
ActiveRecord::Migration.maintain_test_schema!

class ActiveSupport::TestCase
  # Corre tests en paralelo
  parallelize(workers: :number_of_processors)
  fixtures :all
end
