class DirectMessagesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def index
    @user = current_user
    @other_user = User.find(params[:id])
    @active_messages = @user.active_messages.where("to_id=?", @other_user.id)
    @passive_messages = @user.passive_messages.where("from_id=?", @other_user.id)
    @direct_messages = @active_messages.or(@passive_messages)
    redirect_to users_path(@other_user.id) and return unless @other_user.activated?
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  def edit
    @direct_message = DirectMessage.find(params[:id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end

  def create
    @user = current_user
    @direct_message = current_user.active_messages.build(direct_message_params)
    @other_user = User.find(@direct_message[:to_id])
    if @direct_message.save
      respond_to do |format|
        format.html { redirect_to direct_messages_path(params[:id]) }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to direct_messages_path(params[:id]) }
        format.js
      end
    end
  end

  def update
    @direct_message = DirectMessage.find(params[:id])
    @direct_message[:message] = params[:direct_message][:message]
    @user = User.find(@direct_message[:from_id])
    @other_user = User.find(@direct_message[:to_id])
    @direct_message.save
    respond_to do |format|
      format.html { redirect_to direct_messages_path(@other_user) }
      format.js
    end
  end

  def destroy
    @direct_message = DirectMessage.find(params[:id])
    #if @direct_message[:from_id] == current_user.id
      @direct_message.destroy
    #end
  end

  private

      def direct_message_params
        params.require(:direct_message).permit(:from_id, :to_id, :message, :picture)
      end

      def correct_user
        @direct_message = current_user.active_messages.find_by(id: params[:id])
        redirect_to root_url if @direct_message.nil?
      end
end
