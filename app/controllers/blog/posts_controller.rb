module Blog
    class PostsController < AuthorController
           

        # GET /posts
        # GET /posts.json
        def index
            @posts = Post.most_recent.paginate(:page => params[:page], per_page: 2)
        end

        # GET /posts/1
        # GET /posts/1.json
        def show
            @post = Post.friendly.find(params[:id])
        end
    end
end