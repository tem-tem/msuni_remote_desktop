class Admin::MsuFiletypesController < ApplicationController
  
  def create
    f = MsuFiletypes.new(ft_param)
    f.name = f.name.downcase
    f.save
  end

  private
    def ft_param
      params.require(:msu_filetype).permit(:name)
    end
end
