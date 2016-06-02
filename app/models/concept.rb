class Concept < ActiveRecord::Base
    
    default_scope {
    order('relevance DESC')
  }
  
end
