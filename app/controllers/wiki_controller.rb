class WikisController < ApplicationController
    def index
        @user = User.find_by(id: session[:user_id])
        @wikis = Wiki.all
    end
    
    def show
        @wiki = wiki.find(params[:id])
    end
    
    def new
        @wiki = wiki.new
    end
    
    def create
        @wiki = Wiki.new
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        @wiki.user_id = current_user.id
        @wiki.private = false
        
        if @wiki.save
            flash[:notice] = "Wiki was saved."
            redirect_to @wiki
        else
            flash.now[:alert] = "error"
            render :new
        end
    end
    
    def edit
        @wiki = Wiki.find(params[:id])
    end
    
    def update
        @wiki = Wiki.find(params[:id])
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        
        if @wiki.save
            flash[:notice] = "Post was updated."
            redirect_to @wiki
        else
            flash.now[:alert] = "There was an error saving. Do it again."
            render :edit
        end
    end
    
    def destroy
        @wiki = Wiki.find(params[:id])
        
        if @wiki.destroy
            flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
            redirect_to wikis_path
        else
            flash.now[:alert] = "It didn't work. do it again."
            render :show
        end
    end
    
end