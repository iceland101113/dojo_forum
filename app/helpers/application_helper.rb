module ApplicationHelper
  def user_relationship(user, current_user, status_u, status_f)
      if user == current_user
        
        link_to('Edit Profile', edit_user_path(user), class: "btn btn-primary")

      elsif user.is_friend?(current_user) && status_u == 1 

        '<button id="'.html_safe + current_user.id.to_s + '" type="button" class="friend btn btn-info" style="margin-bottom:10px;margin-left: 20px;">UnFriend</button>'.html_safe       

      elsif current_user.is_friend?(user) && status_f == 1 

        '<button id="'.html_safe + current_user.id.to_s + '" type="button" class="friend btn btn-info" style="margin-bottom:10px;margin-left: 20px;">UnFriend</button>'.html_safe  

      elsif user.is_friend?(current_user) && status_u == 0   

        '<button id="'.html_safe + current_user.id.to_s + '" type="button" class="friend btn btn-info" style="margin-bottom:10px;margin-left: 20px;">Add Friend</button>'.html_safe

      elsif current_user.is_friend?(user) && status_f == 0 

        '<button id="'.html_safe + current_user.id.to_s + '" type="button" disabled class="friend btn btn-info" style="margin-bottom:10px;margin-left: 20px;">Waiting</button>'.html_safe

      elsif user.is_friend?(current_user) 
      
        '<button id="'.html_safe + current_user.id.to_s + '" type="button" disabled class="friend btn btn-info" style="margin-bottom:10px;margin-left: 20px;">Have sent you invite</button>'.html_safe    

      elsif current_user.is_friend?(user) 

        '<button id="'.html_safe + current_user.id.to_s + '" type="button" disabled class="friend btn btn-info" style="margin-bottom:10px;margin-left: 20px;">Waiting</button>'.html_safe
        
      else 

        '<button id="'.html_safe + current_user.id.to_s + '" type="button" class="friend btn btn-info" style="margin-bottom:10px;margin-left: 20px;">Add Friend</button>'.html_safe

      end 
  end
end
