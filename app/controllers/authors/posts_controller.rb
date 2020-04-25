module Authors
    class PostsController < BlogController
            before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts
    # GET /posts.json

    #pada post controller ini, terdapat 4 aksi, yaitu show, edit, update, destroy

    #di fungsi index, di sini semua post ditampilkan yang dibuat oleh current author dengan post paling baru
    def index
        @posts = current_author.posts.most_recent
    end

    # GET /posts/1
    # GET /posts/1.json

    #di fungsi show, menampilkan post tersebut pada pengguna
    def show

    end

    # GET /posts/new
    #di fungsi new, merupakan fungsi dimana kita membuat post baru oleh author yang sekarang.
    #terikat dengan category yakni category id.
    def new
        @post = current_author.posts.new
        @categories=Category.all.map{ |c| [c.name,c.id]}
    end

    # GET /posts/1/edit
    #di fungsi edit, merupakan fungsi dimana kita dapat mengedit post

    def edit
        @categories = Category.all.map { |c| [c.name, c.id] }
    end

    # POST /posts
    # POST /posts.json
    #fungsi create, merupakan fungsi dimana kita membuat post, kemudian post tersebut memiliki 
    #category id yang kita beri nilai parameter untuk id category tersebut.
    def create
        @post = current_author.posts.new(post_params)
        @post.category_id = params[:category_id]

        respond_to do |format|
        if @post.save
            #jika post tersebut disave, maka akan dikembalikan ke halaman author posts dengan notifikasi alert 'post was successfully created'
            #jika tidak, maka post akan tetap di fungsi dan nge-render new dengan format jsonnya error.
            format.html { redirect_to authors_posts_path(@post), notice: 'Post was successfully created.' }
            format.json { render :show, status: :created, location: @post }
        else
            format.html { render :new }
            format.json { render json: @post.errors, status: :unprocessable_entity }
        end
        end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    #fungsi ini jika kita ingin melakukan update, jika kita melakukan update maka halaman htmlnya akan dioper ke
    #author_post_path dengan notifikasi aler 'post was successfully created'
    #jika tidak maka tetap berada di halaman render edit
    def update
        @post.category_id=params[:category_id]
        respond_to do |format|
        if @post.update(post_params)
            format.html { redirect_to authors_posts_path(@post), notice: 'Post was successfully updated.' }
            format.json { render :show, status: :ok, location: @post }
        else
            format.html { render :edit }
            format.json { render json: @post.errors, status: :unprocessable_entity }
        end
        end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    #fungsi ini merupakan fungsi delete, yakni menghapus post yang ada. jika didelete, maka dioper ke author post url dengan 
    #notifikasi alert 'post was successfully destroyed', dengan format jsonnya tidak ada konten
    def destroy
        @post.destroy
        respond_to do |format|
        format.html { redirect_to authors_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
        end
    end

    #fungsi ini merupakan metode private, jadi semua fungsi tidak bisa mengakses fungsi fungsi 
    #yang berada di dalam private, karena fungsi set_post dan post_params agak sensitif, yakni set_post
    #me-set id parameter dari post
    #post parameter yakni hanya memperbolehkan beberapa parameter yang ada pada post, yakni title, body, description dan thumbnail
    private
        # Use callbacks to share common setup or rconstraints between actions.
        def set_post
        @post = Post.friendly.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def post_params
        params.require(:post).permit(:title, :body, :description, :thumb)
        end
    end

end