
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
      redirct '/signin'
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

get '/goals' do
  if session[:user_id]
    # @all_goals = Goal.all
    @user_goals = current_user.goals
    @goals = Goal.find_by(user: current_user.id)
    @day_number = @goals.number_of_days
    # @decrease_goals = @goals.update(number_of_days: )
    erb :goals
  else
    redirect '/'
  end
end

get '/newgoal' do
  erb :newgoal
end

post '/newgoal' do
  # p params
  @new_goal = current_user.goals.build(goal_description: params[:goal_description], number_of_days: params[:number_of_days])
  # @new_goal = Goal.new(goal_description: params[:goal_description])
  @new_goal.save
  redirect '/goals'
  erb :newgoal
end




