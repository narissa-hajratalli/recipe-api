class CategoryController < ApplicationController
  before_action :authorized

  # GET - get all categories
  def index
    @category_list = Category.all

    if @category_list.empty?
      render :json => {
          :error => 'Oops, no categories yet! Add some now.'
      }
    else
      render :json => {
          :response => "successful",
          :data => @category_list
      }
    end
  end

  # POST - create a new category
  def create
    @one_category =  Category.new(category_params)
    if @one_category.save
      render :json => {
          :response => "Success! Created your new category.",
          :data => @one_category
      }
    else
      render :json => {
          :error => "Cannot save data."
      }
    end
  end

  # GET - show ONE category
  def show
    @single_category = Category.exists?(params[:id])

    if @single_category
      render :json => {
          :response => "Successful.",
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :response => "Record not found."
      }
    end
  end

  # PUT - update a category
  def update

    if (@single_category_update = Category.find_by_id(params[:id])).present?
      @single_category_update.update(category_params)
      render :json => {
          :response => 'Successfully updated category.',
          :data => @single_category_update
      }
    else
      render :json => {
          :response => "Cannot update record."
      }
    end
  end

  # DELETE - delete a category
  def destroy
    if (@single_category_delete = Category.find_by_id(params[:id])).present?
      @single_category_delete.destroy
      render :json => {
          :response => 'Successfully deleted record.'
      }
    else
      render :json => {
          :response => 'Record not found.'
      }
    end
  end

  #####################################################
  private
  def category_params
    params.permit(:title, :description, :created_by)
  end

end
