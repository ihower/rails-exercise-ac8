var TodoList = React.createClass({

  render: function(){
    var handleRemoveClick = this.props.onRemoveClick;

    var items = this.props.todos.map(function(todo){
      return (<Todo key={todo.id} todo={todo} onRemoveClick={ handleRemoveClick.bind(null, todo) } />);
    })

    return (
      <ul>
        {items}
      </ul>
    )
  }
})

var Todo = React.createClass({
  render: function(){
    var todo = this.props.todo;

    return (
      <li>
        {todo.title}
        <a onClick={ this.props.onRemoveClick }>(remove)</a>
      </li>
    )
  }
})
