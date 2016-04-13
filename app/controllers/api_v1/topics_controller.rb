class ApiV1::TopicsController < ApiController

  def index
    @topics = Topic.page( params[:page] )
  end

  def show
    @topic = Topic.find(params[:id])
    # show.json.jbuilder
  end

  def create
    @topic = Topic.new( :subject => params[:subject],
                        :content => params[:content] )

    if @topic.save
      render :json => { :id => @topic.id }
    else
      render :json => { :message => "failed", :errors => @topic.errors }, :status => 400
    end
  end

end
