class Keyword < ActiveRecord::Base
    
    default_scope {
    order('relevance DESC')
  }

end
