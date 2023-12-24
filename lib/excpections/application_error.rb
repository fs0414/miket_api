class Excpections::ApplicationError < StandardError
  attr_accessor :status, :error, :messaage

  def initialize(status: 500, error: unprocessable_entity, message: 'Something went wrong')
    @status = status
    @error = error
    # binding.pry
    @messaage = messaage


    # super(messaage)
  end
end
