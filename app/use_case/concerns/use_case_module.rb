# this module is use_case interface
module UseCaseModule
  def run
    raise NotImplementError
  end

  def success?
    errors.none?
  end
end
