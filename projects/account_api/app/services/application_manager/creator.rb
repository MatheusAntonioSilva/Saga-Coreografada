module ApplicationManager
  class Creator < ApplicationManager::Base

    def create(with_transaction = true)
      if with_transaction
        ActiveRecord::Base.transaction do
          begin
            execute_creation
          rescue ::StandardError
            produce_rollback
          end
        end
      else
        execute_creation
      end
    end

    private

    def execute_creation
      raise NotImplementedError
    end

    def produce_rollback
      raise ::NotImplementedError
    end
  end
end
