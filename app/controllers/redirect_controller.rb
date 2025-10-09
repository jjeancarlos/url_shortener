class RedirectController < ApplicationController
  skip_before_action :require_login

  def show
    link = Link.find_by(short_code: params[:short_code])
    if link
      redirect_to link.original_url, allow_other_host: true
    else
      render plain: "Link não encontrado", status: :not_found
    end
  end
end
