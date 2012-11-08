class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  
  
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    
    @user = Person.find_by_email(params[:user][:email])
    
    # DNE
    if @user.nil?
      @user = User.new(params[:user])
    
    # User
    elsif @user.registered?
      puts "@user.registered? #{@user.registered?}"
      
      if @user.authenticate(params[:user][:password])
        sign_in @user
        puts "user signed in "
        pp @current_user
        redirect_to @user, flash: {success: 'Your have already registered!'} and return
      else
        redirect_to signin_path, flash: {error: 'This user is already registered! Please sign in instead.'} and return
      end
    end

    # Person
    @user.attributes = params[:user]
    @user.type="User"
    
    
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to @user, flash: {success: 'Your registration was sucessful!'}}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        # Changes to user model reset the session_token 
        # invalidating the session so need to sign in again
        sign_in @user 
        format.html { redirect_to @user, flash: {success: 'Update successful!'} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted!"

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
