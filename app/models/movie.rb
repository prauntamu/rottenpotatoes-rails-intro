class Movie < ActiveRecord::Base
    


    def Movie.all_ratings
        ['G','PG','PG-13','R']
    end 

# had to do this to get around the not being able to use if in the controller ? 
# just sees if the rating is included in the params so the checkbox is persistent 
    def Movie.with_ratings(rating, ratings)
        if (ratings.nil?)
            return true  
        else if (ratings.keys).include?(rating)
            return true
        end 
        return false 
    end 
    end 
    

      
      
end
