class GroupsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
    def index
        @groups = Group.all
    end

    def new
        @group = Group.new
    end

    def show
        @group = Group.find( params[:id] )
        @posts = @group.posts
    end

    def edit
        @group = current_user.groups.find( params[:id] )
    end

    def create
        @group = current_user.groups.create( group_params )

        if @group.save
            current_user.join!( @group )
            redirect_to groups_path, notice: "Success created group!"
        else
            render :new
        end
    end

    def update
        @group = current_user.groups.find( params[:id] )
        
        if @group.update( group_params )
            redirect_to groups_path, notice: "Edit Group success!"
        else
            render :edit
        end
    end

    def destroy
        @group = current_user.groups.find( params[:id] )

        group_title= @group.title

        @group.destroy
        redirect_to groups_path, alert: "#{group_title} group success deleted!"
    end

    def join
        @group = Group.find( params[:id] )

        if !current_user.is_member_of?( @group )
            current_user.join!( @group )
            flash[:notice] = "Success join to group!"
        else
            flash[:warning] = "You already member of group!"
        end

        redirect_to group_path( @group )
    end

    def quit 
        @group = Group.find( params[:id])

        if current_user.is_member_of?( @group )
            current_user.quit!( @group )
            flash[:alert] = "Success quit group!"
        else
            flash[:warning] = "You a not member of group!"
        end

        redirect_to group_path( @group )
    end

    private

    def group_params
        params.require( :group ).permit( :title, :description )
    end
end
