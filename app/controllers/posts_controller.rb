class PostsController < ApplicationController
    before_action :find_group
    before_action :authenticate_user!

    def new
        @post = @group.posts.new
    end

    def create
        @post = @group.posts.build( post_params )
        @post.author = current_user

        if @post.save
            redirect_to group_path( @group ), notice: "Add post success!"
        else
            render :new
        end
    end

    def edit
        @post = current_user.posts.find( params[:id])
    end

    def update 
        @post = current_user.posts.find( params[:id])

        if @post.update( post_params ) 
            redirect_to group_path( @group ), notice: 'Success edited POST'
        else
            render :edit
        end
    end

    def destroy
        @post = current_user.posts.find( params[:id])

        @post.destroy
        redirect_to group_path( @group ), alert: 'Success delete POST'
    end

    private

    def find_group
        @group = Group.find( params[:group_id])
    end

    def post_params
        params.require( :post ).permit( :content )
    end
end
