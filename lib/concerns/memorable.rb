module Memorable
  module ClassMethods
    def destroy_all
      self.all
    end
  end
  module InstanceMethods
    def save
      self.class.all << self
    end
  end
end