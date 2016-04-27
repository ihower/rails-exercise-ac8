var TodoItem = React.createClass({
  render :function(){
    var todo = this.props.todo;
    return (
      <li>
        { todo.title }
        <a onClick={this.props.onRemoveClick.bind(null, todo)}>(remove)</a>
      </li>
    )
  }
})

var TodoList = React.createClass({

  render: function(){
    var todos = this.props.todos;
    var that = this;
    var items = todos.map(function(x){
      return (
        <TodoItem todo={x} onRemoveClick={that.props.onRemoveClick} />
      )
    })

    return (
      <ul>
        {items}
      </ul>
    )
  }
})
