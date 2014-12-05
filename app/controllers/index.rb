
#  Make these routes restful!
after do
  ActiveRecord::Base.connection.close
end





get '/' do
 erb :index
end

get '/signin' do
  erb :signin
end

post '/signin' do
 user = User.find_by(username: params[:username])
  if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/goals'
    else
      redirect '/signin'
    end
end

get '/signout' do
  session.clear
  redirect '/'
end

get '/signup' do
  erb :signup
end

post '/signup' do
  if user = User.new(username: params[:username], password: params[:password])
    user.save
  end
  redirect '/goals'
end

#  Make restful routes!
get '/newgoal' do

    erb :newgoal
end

get '/streaks/all' do
  @all_streaks = Status.all
  erb :streaksall
end

post '/streaks/all' do
  @status = current_user.statuses.build!(content: params[:content])

  erb :streaksall
end

#  Make restful routes!
post '/newgoal' do
  # p params
  @new_goal = current_user.goals.build(goal_name: params[:goal_name], goal_description: params[:goal_description])
   # loop through 21 times
      current_user.goals.each do |goal|
     21.times { goal.schedules << Schedule.create() }
   end

   #    current_user.goals.each do |goal|
   #   21.times { goal.schedules << Schedule.create() }
   # end
  @new_goal.save
  redirect '/goals'
  erb :newgoal
end

get '/goals' do
  if session[:user_id]
    @user_goals = current_user.goals
    @user_schedule = Schedule.where(user_id: params)
    @user = current_user.id
    @goal = Goal.where(user_id: @user)
    @schedule = Schedule.where(goal_id: @goal)
    erb :goals
  else
    redirect '/'
  end
end



# put '/goals' do

#     if request.xhr?
#         schedule = Schedule.where(id: params[:id])
#         schedule.complete = true


#        # @goal_update = @schedule.where(id: params[:id])
#        # .complete = true
#        # @goal_update.to_json
#      end
# end



# Implement a way of deleting a goal as well? Or edit a goal?

# Able to create many goals just need to change how they display



# Save the access token for each user in the database (for future use).
# Make API requests against the user's profile:
# GET private profile of a user
# GET public profile of a user
# Look at the API docs and find what other actions you can do on behalf of the user.


# get '/redirect_auth_url' do
#   client_id = ENV["CLIENT_I_D"]
#   scope_url = "https://www.googleapis.com/auth/plus.login&state=12345&approval_prompt=force"
#   redirect_uri = "https://thestreak.herokuapp.com/signedin"
#   redirect "https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scope_url}"
# end

# get '/logged_in' do
#   token_response = HTTParty.post("https://accounts.google.com/o/oauth2/token",
#                                 body: {
#                                       code: params[:code],
#                                       client_id: ENV["CLIENT_I_D"],
#                                       client_secret: ENV["SECRETKEY"],
#                                       redirect_uri: "https://thestreak.herokuapp.com/signedin",
#                                       grant_type: "authorization_code"
#                                 })

#   google_plus_response = HTTParty.get("https://www.googleapis.com/plus/v1/people/me?access_token=#{token_response["access_token"]}")
#   google_plus_response
# end

