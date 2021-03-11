class FriendshipsController < ApplicationController

    # accept
    def edit
        f = Friendship.find(params[:id])
        f.status = true
        if f.save
          redirect_to request.referrer
        else
          redirect_to users_path
        end
      end
    
    # add
    def new 
        
    
    end

end