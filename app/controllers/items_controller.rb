class ItemsController < ApplicationController

  helper_method :sort_column, :sort_direction
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    if params[:item]
      result = Item.search(params[:item]).order("#{sort_column} #{sort_direction}")
      @items = result.paginate(:per_page => 2, :page => params[:page])
      @ids = result.map{|r| r.id}.join(',')
      @show_save_button = true
    else
      @items = Item.where("search_name is null").order("#{sort_column} #{sort_direction}").paginate(:per_page => 2, :page => params[:page])
    end
    @history = Item.uniq.pluck(:search_name).compact!
  end

  def import
     Item.import(params[:file])
     redirect_to root_url, notice: 'Items imported.'
  end

  def show
    @history = Item.uniq.pluck(:search_name).compact!
    @items = Item.where("search_name = '#{params[:id]}'").paginate(:per_page => 2, :page => params[:page])
    render 'index'
  end

  def save_results
    if params[:ids]
      arr = params[:ids].split(',')
      result = Item.find(arr).index_by(&:id)
      result_name = Item.last.id + 1
      result.each do |k,v|
        Item.create(kind: v.kind, height: v.height, emergency_exit: v.emergency_exit,
                    openable: v.openable, search_name: result_name)
      end
      redirect_to root_url, success: 'Search result saved.'
    end
  end

  def new_import

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:kind, :height, :emergency_exit, :openable)
    end

    def sort_column
      Item.column_names.include?(params[:sort]) ? params[:sort] : "kind"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
