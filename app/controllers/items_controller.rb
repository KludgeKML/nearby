class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_owner
  before_action :set_search_params, only: [:index]

  # GET /items
  # GET /items.json
  def index
    @items = Item.where(owner: @owner) if @nearto.nil? && @tags.nil?
    respond_to do |format|
      format.json { render json: { items: @items } }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params, @owner)

    respond_to do |format|
      if @item.save
        format.json { render json: { result: 'created!', uuid: @item.uuid } }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
    # Set the owner
    def set_search_params
      @nearto = request.params[:nearto]
      @tags = []
      if request.params[:tags]
        request.params[:tags].split(',').each do |tag_pair|
          @tags << tag_pair.split(':')
        end
      end
    end

    # Set the owner
    def set_owner
      # TODO: get the owner from the header
      @owner = 'keith'
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params[:item]
    end
end
