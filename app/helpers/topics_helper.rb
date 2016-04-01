module TopicsHelper

  def topic_status_options

    Topic::STATUS.map do |status|
      [ t(status, :scope => "topic.status"), status ]
    end

  end

  def category_name_options
    Category.all.map do |c|
      [ c.name, c.id ]
    end
  end

end
