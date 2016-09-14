module Admin
  class PagesController < AdminController
    before_action :set_page, only: [:show, :edit, :update, :destroy]
    before_filter :ensure_admin

    def ensure_admin
      if current_user.admin?
        true
      else
        redirect_to root_path
      end
    end
    # GET /pages
    # GET /pages.json
    def index
      @pages = Page.all
      #@categories = Category.all
    end

    # GET /pages/1
    # GET /pages/1.json
    def show
    end

    # GET /pages/new
    def new
      @page = current_user.pages.build
    end

    # GET /pages/1/edit
    def edit
    end

    # POST /pages
    # POST /pages.json
    def create
      @page = current_user.pages.build(page_params)

      respond_to do |format|
        if @page.save
          format.html { redirect_to admin_page_path(@page), flash[:success] => 'Page was successfully created.' }
          format.json { render :show, status: :created, location: admin_page_path(@page) }
        else
          format.html { render :new }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /pages/1
    # PATCH/PUT /pages/1.json
    def update
      respond_to do |format|
        if @page.update(page_params)
          format.html { redirect_to admin_page_path(@page), flash[:success] => 'Page was successfully updated.' }
          format.json { render :show, status: :ok, location: admin_page_path(@page) }
        else
          format.html { render :edit }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /pages/1
    # DELETE /pages/1.json
    def destroy
      @page.destroy
      respond_to do |format|
        format.html { redirect_to admin_pages_path, flash[:error] => 'Page was successfully destroyed.' }
        format.json { head :no_content }
        format.js {render :layout => false}
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_page
        @page = Page.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def page_params
        params.require(:page).permit(:title, :body, :slug, :image, :remove_image, :publish_date_time, :user_id)
      end
  end
end