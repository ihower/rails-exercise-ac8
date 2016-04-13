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

  def update
    @topic = Topic.find( params[:id] )

    columns = [:subject, :content]

    if params.slice(*columns).keys.any?
      columns.each do |column|
        @topic[column] = params[column] if params[column]
      end

      if @topic.save
        render :json => { :id => @topic.id }
      else
        render :json => { :message => "failed", :errors => @topic.errors }, :status => 400
      end

    else
      render :json => { :message => "no keys"}, :status => 400
    end
  end

  def destroy
    @topic = Topic.find( params[:id] )
    @topic.destroy

    render :json => { :message => "OK" }
  end

end
