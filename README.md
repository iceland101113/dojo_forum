# A Blog wesite
![image](https://github.com/iceland101113/dojo_forum/blob/master/%E5%9C%96%E7%89%871.png)  

## Introduction           
* All User can do:  
  + Sign Up  
  + Log in  
  + view publish post which was authorized
  + view publish post replies count and viewed count
  + comment on published post
  + edit your own profile
  + collect interesting post
  + make friend with other user
  + CRUD you own post and attach a picture when create post
  + set the category of your post
  + save your post as draft or publish it
  + set who can see and give commient on your published post(public, friend only, only author)
 
* All manager can do:
  + CRUD post categories
  + manage website user and set their role
  + can delete all the post
  
* For developer, can get json data by using API below:
  + get all post 
    https://dojo-forum20180513.herokuapp.com/api/v1/posts 
    
  + get auth_token
    https://dojo-forum20180513.herokuapp.com/api/v1/login 

  + get a post
    https://dojo-forum20180513.herokuapp.com/api/v1/posts/:id?auth_token= 

  + create a post 
    https://dojo-forum20180513.herokuapp.com/api/v1/posts?auth_token= 

  + edit a post
    https://dojo-forum20180513.herokuapp.com/api/v1/posts/:id?auth_token= 

  + delete a post
    https://dojo-forum20180513.herokuapp.com/api/v1/posts/:id?auth_token= 


## Version  
* ruby 2.3.7
* rails 5.1.6

## Getting Started
* set up
`bundle install`
`rails db:migrate`

* set default data
`rails db:seed`
