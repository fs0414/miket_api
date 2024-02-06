class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    p 'run the example job'
  end
end
