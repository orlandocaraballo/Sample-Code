class ClipmarkletsController < ApplicationController
  before_filter :set_temp_clipmarklet_var
  before_filter :authenticate_user!
  layout 'clipmarklet'
  
  def new
    # reset temp_clipmarklet because it's only needed if redirect by authenticate_user!
    session[:temp_clipmarklet] = nil
    @url = params[:url]
    @clipmarklet = params[:clipmarklet] ||= false
    orig_url = Util::URL.fix_url(params[:url])
    if Util::URL.valid_url? orig_url
      p = DealParser.new
      deal = p.parse_from_url(orig_url)
      if deal.nil?
        @error = "The specified URL is invalid."
      elsif deal.parsed_images.blank?
        @error = "The specified URL does not contain any images"
      else
        @url = deal.url
        @clips = Clip.original_clips_for_url(@url) if !params[:force]
        if !@clips.blank?
          render :duplicate and return
        else
          @clip = Clip.new
          @clip.deal = deal
          render :new and return
        end
      end
    else
      @error = "The specified URL is invalid"
    end

    render :error and return if @clip.blank?

  end
  
private
  def set_temp_clipmarklet_var
    # minor hack to set if page is clipmarklet for when user is not logged in and authenticate_user! redirects
    session[:temp_clipmarklet] = true
  end
end
