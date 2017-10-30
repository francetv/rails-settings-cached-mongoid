module RailsSettings
  class ScopedSettings < MongoSettings
    include Mongoid::Attributes::Dynamic
    include Mongoid::Timestamps

    field :creator, type: String


    before_save :set_creator


    def self.for_thing(object)
      @object = object
      self
    end
    
    def self.thing_scoped
      unscoped.where(:thing_type => @object.class.base_class.to_s, :thing_id => @object.id)
    end
 
    private 
	    def set_creator
	      self.creator = RequestStore.store[:creator]
	    end
  end
end
