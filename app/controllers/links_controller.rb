class LinksController < ApplicationController
  before_action :require_login
  before_action :set_link, only: %i[show destroy]
  before_action :authorize_link, only: %i[show destroy]

  def index
    @links = current_user.links
  end

  def new
    @link = current_user.links.build
  end

  def create
    @link = current_user.links.build(link_params)
    if @link.save
      redirect_to @link, notice: "Link encurtado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    @link.destroy
    redirect_to links_path, notice: "Link excluído."
  end

  # Redirecionamento público: /:short_code
  def redirect
    @link = Link.find_by(short_code: params[:short_code])
    if @link
      redirect_to @link.original_url, allow_other_host: true
    else
      redirect_to root_path, alert: "Link não encontrado."
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end

  def set_link
    @link = Link.find(params[:id])
  end

  def authorize_link
    redirect_to links_path, alert: "Acesso não autorizado!" if @link.user != current_user
  end
end
