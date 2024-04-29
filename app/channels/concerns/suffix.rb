module Suffix
  extend ActiveSupport::Concern

  included do
    @suffix = nil
  end

  private

  def suffix
    @suffix ||= define_suffix
  end

  def define_suffix
    raise NotImplementedError, 'Subclasses must implement this method'
  end
end
