module OrderManager
  class Creator < ApplicationManager::Creator

    attr_reader :args

    def initialize(args)
      @args = args
    end

    private

    def execute_creation
      ::Order.create!(args)
    end
  end
end
