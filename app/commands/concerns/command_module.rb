# module
module CommandModule
  extend ActiveSupport::Concern

  def run
    raise NotImplementError
  end
end
