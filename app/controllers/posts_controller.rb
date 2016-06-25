class PostsController < ApplicationController
    def new
        @group = Group.find( params[:group_id])
        @post = @group.posts.new
    end

    def create
        @group = Group.find( params[:group_id])
        @post = @group.posts.build( post_params )

        if @post.save
            redirect_to group_path( @group ), notice: "Add post success!"
        else
            render :new
        end
    end

    private

    def post_params
        params.require( :post ).permit( :content )
    end
end