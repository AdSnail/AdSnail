class AdsController < ApplicationController
    def index
        @ads = Ad.all
    end

    def new
        @ad = Ad.new
    end

    def edit
        @ad = Ad.find(params[:id])
    end

    def show
        @ad = Ad.find(params[:id])
    end

    def create
        @ad = Ad.new(params.require(:ad).permit(
            :title, :description, :views, :likes
        ))
        if @ad.save
            redirect_to @ad
        else
            render 'new'
        end
    end

    def update
        @ad = Ad.find(params[:id])

        if @ad.update(ad_params)
          redirect_to @ad
        else
          render 'edit'
        end
    end

    def destroy
        @ad = Ad.find(params[:id])
        @ad.destroy

        redirect_to ads_path
    end

    private
    def ad_params
        params.require(:ad).permit(
            :title, :description, :views, :likes
        )
    end
end
