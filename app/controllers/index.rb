
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

# Save the access token for each user in the database (for future use).
# Make API requests against the user's profile:
# GET private profile of a user
# GET public profile of a user
# Look at the API docs and find what other actions you can do on behalf of the user.

get '/redirect_auth_url' do
  client_id = "438933370330-c981ncf2po8qdumst3dtsbnursonhh0o.apps.googleusercontent.com"
  redirect "https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=#{client_id}&redirect_uri=https://thestreak.herokuapp.com/signedin&scope=https://www.googleapis.com/auth/plus.login&state=12345&approval_prompt=force"
end



get '/signedin' do
  p params # these are your string query parameters (your authorization code will be in here!)

  token_response = HTTParty.post("https://accounts.google.com/o/oauth2/token",
                                body: {
                                      code: params[:code],
                                      client_id: "438933370330-c981ncf2po8qdumst3dtsbnursonhh0o.apps.googleusercontent.com",
                                      client_secret: "ENV['SECRETKEY']",
                                      redirect_uri: "https://thestreak.herokuapp.com/signedin", # what you specify in your developer console (this matches the route we are currently in)
                                      grant_type: "authorization_code"
                                })

  token_response # returns an access_token, expires_in, refresh_token (optionally)

  # in order to make a request to the Google + API, we need to enable it in our Google Developer Console
  google_plus_response = HTTParty.get("https://www.googleapis.com/plus/v1/people/me?access_token=#{token_response["access_token"]}")
  google_plus_response
end


