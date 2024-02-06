# module
module CommandModule
  extend ActiveSupport::Concern

  def run
    raise NotImplementError
  end

  def success?
    # errors.none?
    raise NotImplementError
  end
end
